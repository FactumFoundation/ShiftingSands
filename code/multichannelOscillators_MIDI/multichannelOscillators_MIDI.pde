import ddf.minim.*;
import ddf.minim.signals.*;
import javax.sound.sampled.*;
import ddf.minim.ugens.*;
import de.looksgood.ani.*;
import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus

Mixer.Info[]   mixerInfo;
Minim          mMinim;

ArrayList<Plate> plates;

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
  
  // MIDI support
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  //                  Parent In Out
  //                    |    |  |
  myBus = new MidiBus(this, 1, -1); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  
}

void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
  for(int i =0; i < plates.size(); i++){
    if(channel == i){
        plates.get(i).playNote(pitch);
    }
  }
  
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println();
  println("Note Off:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
  for(int i =0; i < plates.size(); i++){
    if(channel == i){
        plates.get(i).mute();
    }
  }
  
}


void createPlates()
{
  plates = new ArrayList<Plate>();
  
  Plate newPlate = new Plate (this, AudioSystem.getMixer(mixerInfo[2]));

  newPlate.addFrequency(54.8);
  newPlate.addFrequency(74.9);
  newPlate.addFrequency(81.2);
  newPlate.addFrequency(96.8);
  newPlate.addFrequency(152.9);
  newPlate.addFrequency(232.5);
  newPlate.addFrequency(301.7);
  newPlate.addFrequency(316.6);
  newPlate.addFrequency(346.9);
  plates.add(newPlate);

  newPlate = new Plate (this, AudioSystem.getMixer(mixerInfo[4]));
  newPlate.addFrequency(53.1);
  newPlate.addFrequency(68.8);
  newPlate.addFrequency(77.3);
  newPlate.addFrequency(97.3);
  newPlate.addFrequency(144.0);
  newPlate.addFrequency(237.3);
  newPlate.addFrequency(308.7);
  newPlate.addFrequency(330.7);
  newPlate.addFrequency(352.0);
  plates.add(newPlate);
  
  newPlate = new Plate (this, AudioSystem.getMixer(mixerInfo[6]));
  newPlate.addFrequency(53.1);
  newPlate.addFrequency(68.8);
  newPlate.addFrequency(77.3);
  newPlate.addFrequency(97.3);
  newPlate.addFrequency(144.0);
  newPlate.addFrequency(237.3);
  newPlate.addFrequency(308.7);
  newPlate.addFrequency(330.7);
  newPlate.addFrequency(352.0);
  plates.add(newPlate);
  
  newPlate = new Plate (this, AudioSystem.getMixer(mixerInfo[3]));
  newPlate.addFrequency(53.1);
  newPlate.addFrequency(68.8);
  newPlate.addFrequency(77.3);
  newPlate.addFrequency(97.3);
  newPlate.addFrequency(144.0);
  newPlate.addFrequency(237.3);
  newPlate.addFrequency(308.7);
  newPlate.addFrequency(330.7);
  newPlate.addFrequency(352.0);
  plates.add(newPlate);
  
    newPlate = new Plate (this, AudioSystem.getMixer(mixerInfo[7]));
  newPlate.addFrequency(53.1);
  newPlate.addFrequency(68.8);
  newPlate.addFrequency(77.3);
  newPlate.addFrequency(97.3);
  newPlate.addFrequency(144.0);
  newPlate.addFrequency(237.3);
  newPlate.addFrequency(308.7);
  newPlate.addFrequency(330.7);
  newPlate.addFrequency(352.0);
  plates.add(newPlate);
  
  
}

void draw()
{
  background(120);
  for(int i =0; i < plates.size(); i++){
    plates.get(i).update();
  }
  plates.get(0).draw( 50, 100 );
}
