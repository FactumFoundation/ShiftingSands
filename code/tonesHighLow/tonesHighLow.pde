import ddf.minim.*;
import ddf.minim.ugens.*;
import javax.sound.sampled.Line;
import javax.sound.sampled.Mixer;
import javax.sound.sampled.AudioSystem;
import de.looksgood.ani.*;

Minim       minim;
AudioOutput out;
Oscil       lowFreqWave;
int lowFreqAmplitude = 10;

Pan lowFreqPan ;
Oscil       highFreqWave;
Pan highFreqPan ;
int highFreqAmplitude = 10;

int highFreqWaveValue;

int oscFreq = 0;

ArrayList freqList = new ArrayList();
int currentFreqIndex = 0;
Ani lowFreqAni;
Ani lowFreqAmpAni;

Ani highFreqAmpAni;
void setup()
{
  size(512, 400, P3D);

  minim = new Minim(this);

  Mixer.Info[] mixerInfo = AudioSystem.getMixerInfo();
  for (int i = 0; i < mixerInfo.length; i++)
  {

    Mixer.Info info = mixerInfo[i];

    System.out.println(String.format("Name [%s] \n Description [%s]\n\n", info.getName(), info.getDescription()));
    System.out.println(info.getDescription());
  }

  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut(Minim.STEREO, 1024, 96000, 16);

  // create a sine wave Oscil, set to 440 Hz, at 0.5 amplitude
  lowFreqWave = new Oscil( 440, 1.0f, Waves.SINE );
  lowFreqPan = new Pan(1);
  lowFreqWave.patch(lowFreqPan);
  lowFreqPan.patch( out );

  highFreqWave = new Oscil( 28000, 1.0f, Waves.SINE );
  highFreqPan = new Pan(-1);
  highFreqWave.patch(highFreqPan);
  highFreqPan.patch( out );

  freqList.add(513);
  freqList.add(704);
  freqList.add(759);
  freqList.add(802);
  freqList.add(854);
  freqList.add(975);
  //freqList.add(978);
  freqList.add(1134);
  freqList.add(1235);
  freqList.add(1320);
  freqList.add(1510);
  freqList.add(1763); 
  freqList.add(1900);  
  freqList.add(2035); 
  freqList.add(2331);
  freqList.add(2658); 
  freqList.add(2689);  
  freqList.add(3018); 
  freqList.add(3406);  
  freqList.add(3589); //**--* 
  freqList.add(3614);
  freqList.add(3822);
  freqList.add(4051);
  freqList.add(4121);
  freqList.add(4169);
  freqList.add(4250);
  freqList.add(4289);
  freqList.add(4406);
  freqList.add(4566);
  freqList.add(4699);
  freqList.add(4786);
  freqList.add(4794);
  freqList.add(5057);
  freqList.add(5371);
  freqList.add(5656);
  freqList.add(5855);
  freqList.add(5848);
  freqList.add(6014);

  currentFreqIndex =0;
  Ani.init(this);

  // define a Ani with callbacks, specify the method name after the keywords: onStart, onEnd, onDelayEnd and onUpdate 
  lowFreqAni = new Ani(this, 4.5, "oscFreq", 513, Ani.LINEAR, "onEnd:nextFreq");
  lowFreqAmpAni = new Ani(this, 4.5, "lowFreqAmplitude", 100, Ani.LINEAR);


  highFreqAmpAni = new Ani(this, 4.5, "highFreqAmplitude", 100, Ani.LINEAR);
}

void nextFreq()
{

  currentFreqIndex++;

  currentFreqIndex = (int)random(freqList.size()-1);
  if (currentFreqIndex >=freqList.size())
    currentFreqIndex = 0;

  int dice = (int)random(6);
  boolean isMovingPattern = false;
  if (dice >= 1)
  {
    lowFreqAni = new Ani(this, 1.5, 10.5, "oscFreq", (int)freqList.get(currentFreqIndex), Ani.LINEAR, "onEnd:nextFreq");
  } else
  {
    lowFreqAni = new Ani(this, 0.9, 10.5, "oscFreq", 3597, Ani.LINEAR, "onEnd:nextFreq"); 
    isMovingPattern = true;
  }


  dice = (int)random(2); 
  float randomHighFreq = 0;
  if (dice < 1)
  {

    highFreqAmpAni = new Ani(this, 1.0, "highFreqAmplitude", 0, Ani.LINEAR);

    if (isMovingPattern)
      lowFreqAmpAni = new Ani(this, 3.5, "lowFreqAmplitude", 100, Ani.LINEAR);
    else
      lowFreqAmpAni = new Ani(this, 3.5, "lowFreqAmplitude", 65, Ani.LINEAR);
  } else
  {

    highFreqAmpAni = new Ani(this, 1.0, "highFreqAmplitude", 100, Ani.LINEAR);
    lowFreqAmpAni = new Ani(this, 3.5, "lowFreqAmplitude", 0, Ani.LINEAR);


    // high freq patterns
    dice = (int)random(6); 

    switch(dice) {
    case 1: 
      randomHighFreq   = 29138;
      break;
    default:
      randomHighFreq   = random(29000, 33000);
      break;
    }


    highFreqWave.setFrequency(randomHighFreq);
    highFreqWaveValue = (int)randomHighFreq;
  }



  println( "NextLowFreq: " +  "[ " + currentFreqIndex  + " ]" + (int)freqList.get(currentFreqIndex)/10.0f);
  println( "CurrentHighFreq: " + randomHighFreq);
}


void draw()
{
  //frameRate(30);
  background(0);
  stroke(110);
  strokeWeight(1);

  // lowFreqAmplitude = 0.0f;
  // draw the waveform of the output
  for (int i = 0; i < out.bufferSize() - 1; i++)
  {
    line( i, 50  - out.left.get(i)*20, i+1, 50  - out.left.get(i+1)*50 );
    line( i, 150 - out.right.get(i)*20, i+1, 150 - out.right.get(i+1)*50 );
  }

  // draw the waveform we are using in the oscillator
  stroke( 30, 0, 0 );
  strokeWeight(1);
  for ( int i = 0; i < width-1; ++i )
  {
    point( i, height/2 - (height*0.49) * lowFreqWave.getWaveform().value( (float)i / width ) );
  }

  lowFreqWave.setAmplitude(lowFreqAmplitude / 100.0f );

  lowFreqWave.setFrequency( oscFreq / 10.0f );

  highFreqWave.setAmplitude(highFreqAmplitude / 100.0f );
  textSize(90);
  textAlign(CENTER, CENTER);
  text( oscFreq  / 10.0f + " Hz", width/2, height/2);
  text( highFreqWaveValue + " Hz", width/2, height/2 + 90);

  textSize(12);
  textAlign(CENTER, CENTER);
  text( frameRate, 22, 12);
}

void mouseMoved()
{
  // usually when setting the amplitude and frequency of an Oscil
  // you will want to patch something to the amplitude and frequency inputs
  // but this is a quick and easy way to turn the screen into
  // an x-y control for them.
  /*
  float amp = map( mouseY, 0, height, 1, 0 );
   wave.setAmplitude( amp );
   
   float freq = map( mouseX, 0, width, 110, 880 );
   wave.setFrequency( freq );
   */
}

void keyPressed()
{ 
  switch( key )
  {
  case '+':
    oscFreq += 100;
    break;


  case '-':
    oscFreq -= 100;
    break;


  default: 
    break;
  }
}
