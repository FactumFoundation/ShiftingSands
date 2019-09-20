import ddf.minim.*;
import ddf.minim.signals.*;
import javax.sound.sampled.*;
import ddf.minim.ugens.*;
import de.looksgood.ani.*;

Mixer.Info[]   mixerInfo;
Minim          mMinim;

Plate plate;
Plate plate_2;

void setup()
{
  size(512, 200, P3D);

  // Get all audio devices installed on this sytem
  mixerInfo = AudioSystem.getMixerInfo();

  println("");
  println( "Available Sound Devices:");
  for (int i = 0; i < mixerInfo.length; i++)
  {
    println(i + " = " + mixerInfo[i].getName());
  }

  mMinim = new Minim(this);
  Ani.init(this);

  createPlates();
}

void createPlates()
{
  plate = new Plate (this, AudioSystem.getMixer(mixerInfo[2]));
  plate_2 = new Plate (this, AudioSystem.getMixer(mixerInfo[4]));


  plate.addFrequency(54.8);
  plate.addFrequency(74.9);
  plate.addFrequency(81.2);
  plate.addFrequency(96.8);
  plate.addFrequency(152.9);
  plate.addFrequency(232.5);
  plate.addFrequency(301.7);
  plate.addFrequency(316.6);
  plate.addFrequency(346.9);

  plate_2.addFrequency(53.1);
  plate_2.addFrequency(68.8);
  plate_2.addFrequency(77.3);
  plate_2.addFrequency(97.3);
  plate_2.addFrequency(144.0);
  plate_2.addFrequency(237.3);
  plate_2.addFrequency(308.7);
  plate_2.addFrequency(330.7);
  plate_2.addFrequency(352.0);
}





void draw()
{
  background(120);
  plate.update();
  plate_2.update();
  plate.draw( 50, 100 );
}
