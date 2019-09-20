
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

  Oscil       highFreqWave;
  Pan highFreqPan ;
  int highFreqAmplitude = 100; 
  int highFreqWaveValue;
  Ani highFreqAmpAni;

  // Volume control
  boolean           muted = false;


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

    highFreqWave = new Oscil( 28000, 1.0f, Waves.SINE );
    highFreqPan = new Pan(-1);
    highFreqWave.patch(highFreqPan);
    highFreqPan.patch( out );
  }

  void iniSequence() {
    // Create Ani objects and callbacks, specify the method name after the keywords: onStart, onEnd, onDelayEnd and onUpdate 
    lowFreqAni = new Ani(this, 4.5, "oscFreq", 513, Ani.LINEAR);
    lowFreqAmpAni = new Ani(this, 4.5, "lowFreqAmplitude", lowFreqMaxAmplitude*100f, Ani.LINEAR);
  }

  void addFrequency(float freq)
  {
    freqList.add((int)(freq*10.0f));
  }

  void nextFreq()
  {
    currentFreqIndex++;
    //currentFreqIndex = (int)random(freqList.size()-1);
    if (currentFreqIndex >=freqList.size())
      currentFreqIndex = 0;

    lowFreqAni = new Ani(this, 2.5, 10.5, "oscFreq", (int)freqList.get(currentFreqIndex), Ani.LINEAR, "onEnd:nextFreq");

    /*
    int dice = (int)random(0, 3);
     if (dice<1)
     {
     lowFreqWave.setAmplitude(0.0f);
     } else {
     lowFreqWave.setAmplitude(lowFreqMaxAmplitude);
     }
     */
  }

  void playNote(int midiPitch) {

    currentFreqIndex = midiPitch;
    if (currentFreqIndex >=freqList.size()) {
      currentFreqIndex = 0;
      println("Error with frequency index : ", midiPitch);
      println(mixer);
      println();
    }
    lowFreqAni = new Ani(this, 0.01f, "oscFreq", (int)freqList.get(currentFreqIndex), Ani.LINEAR);
    //println((int)freqList.get(currentFreqIndex));
    muted = false;
    /*
    int dice = (int)random(2); 
     int randomHighFreq = 0;
     if (dice < 1)
     {
     highFreqAmpAni = new Ani(this, 1.0, "highFreqAmplitude", 100, Ani.LINEAR);      
     // high freq patterns
     dice = (int)random(6); 
     
     //29059, 30784, 32453
     switch(dice) {
     case 1: 
     randomHighFreq   = 29138;
     break;
     case 2: 
     randomHighFreq   = 30889;
     break;
     default:
     randomHighFreq   = (int)random(29000, 33000);
     break;
     }
     highFreqWave.setFrequency(randomHighFreq);
     highFreqWaveValue = (int)randomHighFreq;
     } else
     {
     highFreqAmpAni = new Ani(this, 1.0, "highFreqAmplitude", 0, Ani.LINEAR);
     }
     */
  }

  void mute() {
    println("muted");
    muted = true;
  }

  void update()
  {
    /*
    highFreqWave.setAmplitude(0.0f   );
    */
     // Update amplitudes and frequencies
     if (muted) {

     lowFreqWave.setAmplitude(0f);
     } else {
     lowFreqWave.setAmplitude(lowFreqMaxAmplitude);
     }
     
    lowFreqWave.setFrequency( oscFreq / 10.0f );
    //lowFreqWave.setAmplitude( 0.4f );
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
