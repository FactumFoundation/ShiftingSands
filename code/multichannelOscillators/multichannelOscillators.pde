import ddf.minim.*;
import ddf.minim.signals.*;
import javax.sound.sampled.*;
import ddf.minim.ugens.*;

Minim            mMinim;

TwoOscillatorManager manager_12;

void setup()
{
  size(512, 200, P3D);

  // Get all audio devices installed on this sytem
  Mixer.Info[] mixerInfo;
  mixerInfo = AudioSystem.getMixerInfo();

  println("");
  println( "Available Sound Devices:");
  for (int i = 0; i < mixerInfo.length; i++)
  {
    println(i + " = " + mixerInfo[i].getName());
  }

  mMinim = new Minim(this);
  
  // Create two oscillator managers
  manager_12 = new TwoOscillatorManager (this,AudioSystem.getMixer(mixerInfo[1]));
  
  
  
}





void draw()
{
}
