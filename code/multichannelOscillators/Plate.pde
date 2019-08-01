
class Plate
{
  PApplet           parent;
  Minim             minim;
  AudioOutput       out;
  Mixer             mixer;

  ArrayList         freqList = new ArrayList();
  int               currentFreqIndex = 0;

  Oscil             lowFreqWave;
  Pan               lowFreqPan ;
  float             lowFreqMaxAmplitude = 0.2f;
  int               oscFreq = 0;
  int               lowFreqAmplitude = 0;
  Ani               lowFreqAni;
  Ani               lowFreqAmpAni;

  Plate( PApplet parent, Mixer mixer )
  {
    this.parent = parent;
    this.mixer = mixer;  
    minim = new Minim(parent);
    minim.setOutputMixer(mixer);
    out = minim.getLineOut( Minim.STEREO, 1024, 96000, 16 );

    // Create a sine wave Oscil, set to 440 Hz, at 0.5 amplitude
    lowFreqWave = new Oscil( 440, lowFreqAmplitude/100.0f, Waves.SINE );
    lowFreqPan = new Pan(1);
    lowFreqWave.patch(lowFreqPan);
    lowFreqPan.patch( out );

    // Create Ani objects and callbacks, specify the method name after the keywords: onStart, onEnd, onDelayEnd and onUpdate 
    lowFreqAni = new Ani(this, 4.5, "oscFreq", 513, Ani.LINEAR, "onEnd:nextFreq");
    lowFreqAmpAni = new Ani(this, 4.5, "lowFreqAmplitude", lowFreqMaxAmplitude*100f, Ani.LINEAR);
  }

  void addFrequency(float freq)
  {
    freqList.add((int)(freq*10.0f));
  }

  void nextFreq()
  {
    currentFreqIndex++;
    currentFreqIndex = (int)random(freqList.size()-1);
    if (currentFreqIndex >=freqList.size())
      currentFreqIndex = 0;

    lowFreqAni = new Ani(this, 2.5, 10.5, "oscFreq", (int)freqList.get(currentFreqIndex), Ani.LINEAR, "onEnd:nextFreq");
  }

  void update()
  {
    // Update amplitudes and frequencies
    lowFreqWave.setAmplitude(0.2f/*lowFreqAmplitude / 100.0f */);
    lowFreqWave.setFrequency( oscFreq / 10.0f );
  };

  void draw( int y, int deltaY)
  {
    strokeWeight(1);

    // draw the waveform we are using in the oscillator
    for (int i = 0; i < out.bufferSize() - 1; i++)
    {
      stroke(255, 0, 0);
      line( i, y  - out.left.get(i)*20, i+1, y  - out.left.get(i+1)*50 );
      stroke(0, 0, 255);
      line( i, y + deltaY - out.right.get(i)*20, i+1, y + deltaY - out.right.get(i+1)*50 );
    }
  };
}
