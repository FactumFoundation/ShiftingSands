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
int lowFreqAmplitude = 1;
Pan lowFreqPan ;

Oscil       highFreqWave;
Pan highFreqPan ;
int highFreqAmplitude = 3;
int highFreqWaveValue;
int oscFreq = 0;

ArrayList freqList = new ArrayList();
int currentFreqIndex = -1; //-1;
Ani lowFreqAni;
Ani lowFreqAmpAni;

Ani highFreqAni;
Ani highFreqAmpAni;


float timeBetweenFrequencies = 20.5f;

int calibrationFreq = 3953;

// 0 -> Calibration mode
// 1 -> Play mode
// 2 -> Play random mode

int currentMode = 1;

AudioRecorder recorder;

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
  recorder = minim.createRecorder(out, "myrecording.wav");

  // create a sine wave Oscil, set to 440 Hz, at 0.5 amplitude
  lowFreqWave = new Oscil( 440, 1.0f, Waves.SINE );
  lowFreqPan = new Pan(1);
  lowFreqWave.patch(lowFreqPan);
  lowFreqPan.patch( out );

  highFreqWave = new Oscil( 29138, 0.5f, Waves.SINE );
  highFreqPan = new Pan(-1);
  highFreqWave.patch(highFreqPan);
  highFreqPan.patch( out );

  freqList.add(328);
  freqList.add(408);
  freqList.add(452);
  freqList.add(467);
  freqList.add(478);
  //freqList.add(483);
  freqList.add(498);
  freqList.add(508);
  //freqList.add(536);
  freqList.add(541);
  freqList.add(546);
  //freqList.add(552);
  freqList.add(572);
  freqList.add(590);
  freqList.add(637);
  freqList.add(676);
  freqList.add(710);
  freqList.add(726);
  freqList.add(744);
  freqList.add(753);  
  freqList.add(768); 
  freqList.add(775);  
  freqList.add(782);  
  freqList.add(813);  
  freqList.add(845); 
  freqList.add(851); 
  freqList.add(866); 
  freqList.add(873);  
  freqList.add(904);  
  freqList.add(917);
  freqList.add(926);  
  freqList.add(935); 
  freqList.add(951); 
  freqList.add(964); 
  freqList.add(967); 
  freqList.add(969);  //  freqList.add(971); 
  freqList.add(981);
  freqList.add(1004); 
  freqList.add(1027); 
  freqList.add(1051); 
  freqList.add(1076);   
  freqList.add(1080); 

  freqList.add(1107); 
  freqList.add(1130); 
  freqList.add(1217); //puede bajar
  freqList.add(1238); 
  freqList.add(1248); // puede quitarse
  freqList.add(1276);
  freqList.add(1301); 
  freqList.add(1311);
  freqList.add(1318);
  freqList.add(1331); 
  freqList.add(1445); 
  freqList.add(1494); 
  freqList.add(1510);
  freqList.add(1529);
  freqList.add(1606);
  freqList.add(1644);
  freqList.add(1687);
  freqList.add(1699);  //--> OJO 4 o 5
  freqList.add(1702);
  freqList.add(1721);
  freqList.add(1721);
  freqList.add(1744);
  freqList.add(1748);
  freqList.add(1759);
  freqList.add(1762);  //--> mirar por aqui de 0.01
  freqList.add(1778); //--> no afinada, bonita


  freqList.add(1796);
  freqList.add(1814);

  freqList.add(1852);

  freqList.add(2038);
  freqList.add(2036);
  freqList.add(2043);  

  freqList.add(2070);
  freqList.add(2076);
  freqList.add(2104);
  freqList.add(2177);
  freqList.add(2208);
  freqList.add(2258);
  freqList.add(2285);
  freqList.add(2320);
  freqList.add(2325);
  freqList.add(2340);
  freqList.add(2374);
  freqList.add(2383);
  freqList.add(2464);  
  freqList.add(2490);
  freqList.add(2499);
  freqList.add(2529);
  freqList.add(2534);


  ////////////////
  freqList.add(2569); 



  freqList.add(2596);
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
  freqList.add(2922); 
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
  freqList.add(3828);
  freqList.add(3842);

  freqList.add(3912);
  freqList.add(4317);

  /*
  freqList.add(6265);
   freqList.add(6346);
   freqList.add(6384);
   freqList.add(6414);
   freqList.add(6452);
   freqList.add(6480);
   freqList.add(6510);
   freqList.add(6531);
   freqList.add(6575);
   freqList.add(6677);
   freqList.add(6703);
   freqList.add(6758);
   freqList.add(7523);
   freqList.add(7660);   
   freqList.add(7678);
   freqList.add(7730);
   freqList.add(7739);
   freqList.add(7797);
   freqList.add(7867);
   freqList.add(7974);
   freqList.add(8001);
   freqList.add(8132);
   freqList.add(8213);
   freqList.add(8265);
   freqList.add(8345);
   freqList.add(8419);
   freqList.add(8457);
   freqList.add(8472);
   */

  Ani.init(this);

  // define a Ani with callbacks, specify the method name after the keywords: onStart, onEnd, onDelayEnd and onUpdate 
  lowFreqAni = new Ani(this, 2, "oscFreq", 400, Ani.LINEAR, "onEnd:nextFreq");
  lowFreqAmpAni = new Ani(this, 1, "lowFreqAmplitude", 0, Ani.LINEAR);
  lowFreqWave.setAmplitude(lowFreqAmplitude / 100.0f );

  int randomHighFreq   = (int)random(20000, 29600);
  highFreqAni = new Ani(this, 0.5, "highFreqWaveValue", randomHighFreq, Ani.LINEAR);
  highFreqAmpAni = new Ani(this, 2.5, "highFreqAmplitude", 100, Ani.LINEAR);
}

void fadeOut()
{
  println("fadeout");
  lowFreqAmpAni = new Ani(this, 2, "lowFreqAmplitude", 90, Ani.LINEAR);

  recorder.save();
  println("Done saving.");
  String fileName = "tone_chladni_";
  fileName += (int)((int)freqList.get(currentFreqIndex));
  
  fileName = addChar( fileName, '_', fileName.length()-1);
  fileName += "_Hz.wav";
  recorder = minim.createRecorder(out, fileName);
  recorder.beginRecord();
}

public String addChar(String str, char ch, int position) {
    return str.substring(0, position) + ch + str.substring(position);
}

void nextFreq()
{
  println("nextfreq");
  currentFreqIndex++;

  if (currentMode == 2)
    currentFreqIndex = (int)random(freqList.size()-1);

  timeBetweenFrequencies = 12.5f;

  if (currentFreqIndex >=freqList.size())
  {
    currentFreqIndex = 0;
    exit();
  }

  lowFreqAmpAni = new Ani(this, 2, timeBetweenFrequencies-2, "lowFreqAmplitude", 0, Ani.LINEAR, "onEnd:fadeOut");


  lowFreqAni = new Ani(this, 0.2, timeBetweenFrequencies, "oscFreq", (int)freqList.get(currentFreqIndex), Ani.LINEAR, "onEnd:nextFreq");




  println( "NextLowFreq: " +  "[ " + currentFreqIndex  + " ]" + (int)((int)freqList.get(currentFreqIndex)/10.0f));
}

void updateAudio()
{

  // Update audio
  lowFreqWave.setAmplitude(lowFreqAmplitude / 100.0f );
  lowFreqWave.setFrequency( oscFreq / 10.0f );

  highFreqWave.setAmplitude(0  );
  highFreqWave.setFrequency( highFreqWaveValue );

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

  textSize(90);
  textAlign(CENTER, CENTER);
  text( oscFreq  / 10.0f + " Hz", width/2, height/2);
  text( highFreqWaveValue + " Hz", width/2, height/2 + 90);

  textSize(12);
  textAlign(CENTER, CENTER);
  text( frameRate, 22, 12);

  textSize(12);
  textAlign(CENTER, CENTER);
  text( currentFreqIndex, 22, 24);
}

void calibrate()
{
  lowFreqWave.setAmplitude( 1.0f );
  lowFreqWave.setFrequency( calibrationFreq/10.0f  );

  highFreqWave.setAmplitude( 1.0f);
  highFreqWave.setFrequency( 25000 );
}

void draw()
{
  if (currentMode == 0 )
    calibrate();
  else
    updateAudio();

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
  case '0':
    currentMode = 0;
    break;
  case '1':
    currentMode = 1;
    break;
  case '2':
    currentMode = 2;
    break;
  case '+':
    calibrationFreq--;
    break;
  case '-':
    calibrationFreq++;
    break;


  default: 
    break;
  }

  if ( key == 'r' ) 
  {
    // to indicate that you want to start or stop capturing audio data, you must call
    // beginRecord() and endRecord() on the AudioRecorder object. You can start and stop
    // as many times as you like, the audio data will be appended to the end of the buffer 
    // (in the case of buffered recording) or to the end of the file (in the case of streamed recording). 
    if ( recorder.isRecording() ) 
    {
      recorder.endRecord();
    } else 
    {
      recorder.beginRecord();
    }
  }
  if ( key == 's' )
  {
    // we've filled the file out buffer, 
    // now write it to the file we specified in createRecorder
    // in the case of buffered recording, if the buffer is large, 
    // this will appear to freeze the sketch for sometime
    // in the case of streamed recording, 
    // it will not freeze as the data is already in the file and all that is being done
    // is closing the file.
    // the method returns the recorded audio as an AudioRecording, 
    // see the example  AudioRecorder >> RecordAndPlayback for more about that
  }
}
