import ddf.minim.*;
import ddf.minim.ugens.*;
import javax.sound.sampled.Line;
import javax.sound.sampled.Mixer;
import javax.sound.sampled.AudioSystem;
import de.looksgood.ani.*;

// Vibra la estructura
// 48.2, 54.6, 59.0, 74.4, 97.1

// No hace 
// 70.9


Minim       minim;
AudioOutput out;

Oscil       lowFreqWave;
int lowFreqAmplitude = 10;
Pan lowFreqPan ;

Oscil       highFreqWave;
Pan highFreqPan ;
int highFreqAmplitude = 3;
int highFreqWaveValue;
int oscFreq = 0;

ArrayList freqList = new ArrayList();
int currentFreqIndex = 0;
Ani lowFreqAni;
Ani lowFreqAmpAni;

Ani highFreqAni;
Ani highFreqAmpAni;


float timeBetweenFrequencies = 10.5f;

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
  out = minim.getLineOut(Minim.STEREO, 1024, 48000, 16);

  // create a sine wave Oscil, set to 440 Hz, at 0.5 amplitude
  lowFreqWave = new Oscil( 440, 1.0f, Waves.SINE );
  lowFreqPan = new Pan(1);
  lowFreqWave.patch(lowFreqPan);
  lowFreqPan.patch( out );

  highFreqWave = new Oscil( 29138, 0.5f, Waves.SINE );
  highFreqPan = new Pan(-1);
  highFreqWave.patch(highFreqPan);
  highFreqPan.patch( out );

  freqList.add(327);
  freqList.add(386);
  freqList.add(410);
  freqList.add(453);
  freqList.add(483);
  freqList.add(498);
  freqList.add(509);
  freqList.add(533);
  freqList.add(541);
  freqList.add(546);
  freqList.add(551);
  freqList.add(572);
  freqList.add(590);
  freqList.add(639);
  freqList.add(677);
  freqList.add(710);
  freqList.add(726);
  freqList.add(744);
  freqList.add(753);  


  freqList.add(786); 
  freqList.add(935); 
  freqList.add(951); 
  freqList.add(971); 
  freqList.add(1108); 
  freqList.add(1217); 
  freqList.add(1248); 
  freqList.add(1274); 
  freqList.add(1330); 
  freqList.add(1510);
  freqList.add(1687);
  freqList.add(1700);
  freqList.add(1796);
  freqList.add(1814);
  freqList.add(2036);
  freqList.add(2070);
  freqList.add(2076);
  freqList.add(2104);
  freqList.add(2285);
  freqList.add(2320);
  freqList.add(2340);
  freqList.add(2383);
  freqList.add(2464);  
  freqList.add(2490);
  freqList.add(2499);
  freqList.add(2534);
  freqList.add(2569);




  freqList.add(2594);
  freqList.add(2604);
  freqList.add(2630);
  freqList.add(2658);
  freqList.add(2665);
  freqList.add(2671);

  freqList.add(2699);
  freqList.add(2709);
  freqList.add(2736);
  freqList.add(2762);
  freqList.add(2795);

  freqList.add(2812);
  freqList.add(2836);
  freqList.add(2846);
  freqList.add(2910); 
  freqList.add(2936);
  freqList.add(2948);
  freqList.add(2989);
  freqList.add(3008);
  freqList.add(3020);
  freqList.add(3028);
  freqList.add(3042);
  freqList.add(3070);
  freqList.add(3075);
  freqList.add(3082);
  freqList.add(3113);
  freqList.add(3125);
  freqList.add(3142);
  freqList.add(3148);
  freqList.add(3154);

  freqList.add(3167);





  currentFreqIndex =-1;
  Ani.init(this);

  // define a Ani with callbacks, specify the method name after the keywords: onStart, onEnd, onDelayEnd and onUpdate 
  lowFreqAni = new Ani(this, 4.5, "oscFreq", 200, Ani.LINEAR, "onEnd:nextFreq");
  lowFreqAmpAni = new Ani(this, 4.5, "lowFreqAmplitude", 100, Ani.LINEAR);

  highFreqAni = new Ani(this, 4.5, "highFreqWaveValue", 28000, Ani.LINEAR);
  highFreqAmpAni = new Ani(this, 6.5, "highFreqAmplitude", 10, Ani.LINEAR);
}

void nextFreq()
{

  currentFreqIndex++;

  //currentFreqIndex = (int)random(freqList.size()-1);
  //timeBetweenFrequencies = 6.5f;

  if (currentFreqIndex >=freqList.size())
    currentFreqIndex = 0;

  int dice = (int)random(9);
  boolean isMovingPattern = false;
  if (dice >= 1)
  {
    lowFreqAni = new Ani(this, 0.2, timeBetweenFrequencies, "oscFreq", (int)freqList.get(currentFreqIndex), Ani.LINEAR, "onEnd:nextFreq");

    //int f = (int)random(500, 5000);
    //lowFreqAni = new Ani(this, 50.5, 5.5, "oscFreq",f, Ani.LINEAR, "onEnd:nextFreq");
  } else
  {
    lowFreqAni = new Ani(this, 0.2, timeBetweenFrequencies, "oscFreq", 2582, Ani.LINEAR, "onEnd:nextFreq"); 
    isMovingPattern = true;
  }

  //50.8
  dice = (int)random(4); 
  int randomHighFreq = 0;
  if (dice < 0)
  {
    //if (highFreqAmplitude<1)
    highFreqAmpAni = new Ani(this, timeBetweenFrequencies/2.0f, "highFreqAmplitude", 100, Ani.LINEAR);
    //else
    //  highFreqAmpAni = new Ani(this, timeBetweenFrequencies/2.0f, timeBetweenFrequencies/2.0f, "highFreqAmplitude", 0, Ani.LINEAR);

    lowFreqAmpAni = new Ani(this, timeBetweenFrequencies, "lowFreqAmplitude", 0, Ani.LINEAR);

    // high freq patterns
    dice = (int)random(6); 

    //29059, 30784, 32453
    switch(dice) {
      /*
    case 1: 
       randomHighFreq   = 29138;
       break;
       case 2: 
       randomHighFreq   = 30889;
       break;
       */
    default:
      randomHighFreq   = (int)random(20000, 29600);
      break;
    }

    //highFreqAni = new Ani(this, timeBetweenFrequencies/2.0f, timeBetweenFrequencies/2.0f, "highFreqWaveValue", randomHighFreq, Ani.LINEAR);
    highFreqAni = new Ani(this, 0.1f, 0.5f, "highFreqWaveValue", randomHighFreq, Ani.LINEAR);
  } else
  {

    highFreqAmpAni = new Ani(this, 3.5, "highFreqAmplitude", 0, Ani.LINEAR);

    if (isMovingPattern)
      lowFreqAmpAni = new Ani(this, 3.5, "lowFreqAmplitude", 100, Ani.LINEAR);
    else
      lowFreqAmpAni = new Ani(this, 3.5, "lowFreqAmplitude", 100, Ani.LINEAR);
  }



  println( "NextLowFreq: " +  "[ " + currentFreqIndex  + " ]" + (int)((int)freqList.get(currentFreqIndex)/10.0f));
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
  highFreqWave.setFrequency( highFreqWaveValue );
  textSize(90);
  textAlign(CENTER, CENTER);
  text( oscFreq  / 10.0f + " Hz", width/2, height/2);
  text( highFreqWaveValue + " Hz", width/2, height/2 + 90);

  textSize(12);
  textAlign(CENTER, CENTER);
  text( frameRate, 22, 12);

  //println(highFreqAmplitude);
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
