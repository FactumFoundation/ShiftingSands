//----------------------------------------------------------------------
//
// Date: 11/04/2017
//
// multiple_sound_cards_2.pde
//
// Triggers MP3 sounds trough several USB sound cards (using 
// Minim library). Also it allows to load a different MP3
// file for each channel (10 in this case)
//
// Copyright (C) 2017  Jorge Cano
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
//----------------------------------------------------------------------

import ddf.minim.*;
import ddf.minim.signals.*;
import javax.sound.sampled.*;
import ddf.minim.ugens.*;

import themidibus.*; //Import the library

MidiBus          mMidiBus; 
Minim            mMinim;
Mixer.Info[] mixerInfo;

TwoChannelPlayer player1;
TwoChannelPlayer player2;
TwoChannelPlayer player3;
TwoChannelPlayer player4;
TwoChannelPlayer player5;
TwoChannelPlayer player6;
void setup()
{
  size(512, 200, P3D);

  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  mMidiBus = new MidiBus(this, 0, -1); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.

  mixerInfo = AudioSystem.getMixerInfo();

  println("");
  println( "Available Sound Devices:");
  for (int i = 0; i < mixerInfo.length; i++)
  {
    println(i + " = " + mixerInfo[i].getName());
  } 

  mMinim = new Minim(this);

  // Cambiar aquí el id de tarjeta de sonido
  player1 = new TwoChannelPlayer( this, AudioSystem.getMixer(mixerInfo[1]));
  player1.loadChannelLeft("1.mp3", mMinim);
  player1.loadChannelRight("2.mp3", mMinim);

  player2 = new TwoChannelPlayer( this, AudioSystem.getMixer(mixerInfo[2]));
  player2.loadChannelLeft("3.mp3", mMinim);
  player2.loadChannelRight("4.mp3", mMinim);

  player3 = new TwoChannelPlayer( this, AudioSystem.getMixer(mixerInfo[4]));
  player3.loadChannelLeft("5.mp3", mMinim);
  player3.loadChannelRight("6.mp3", mMinim);

  player4 = new TwoChannelPlayer( this, AudioSystem.getMixer(mixerInfo[6]));
  player4.loadChannelLeft("7.mp3", mMinim);
  player4.loadChannelRight("8.mp3", mMinim);

  player5 = new TwoChannelPlayer( this, AudioSystem.getMixer(mixerInfo[3]));
  player5.loadChannelLeft("9.mp3", mMinim);
  player5.loadChannelRight("10.mp3", mMinim);

  player6 = new TwoChannelPlayer( this, AudioSystem.getMixer(mixerInfo[7]));
  player6.loadChannelLeft("9.mp3", mMinim);
  player6.loadChannelRight("10.mp3", mMinim);
}

void draw()
{
  player1.update();
  player2.update();
  player3.update();
  player4.update();
  player5.update();
  player6.update();
}

void playAll()
{
  player1.playLeft();
  player1.playRight();
  player2.playLeft();
  player2.playRight();
  player3.playLeft();
  player3.playRight();
  player4.playLeft();
  player4.playRight();
  player5.playLeft();
  player5.playRight();
  player6.playLeft();
  player6.playRight();
}

void stopAll()
{
  player1.stopLeft();
  player1.stopRight();
  player2.stopLeft();
  player2.stopRight();
  player3.stopLeft();
  player3.stopRight();
  player4.stopLeft();
  player4.stopRight();
  player5.stopLeft();
  player5.stopRight();
  player6.stopLeft();
  player6.stopRight();
}
void keyPressed()
{
  //playAll();
  if ( key == '1')
  {
    stopAll();
    player1.playLeft();
    player1.playRight();
  }
  if ( key == '2')
  {
    stopAll();
    player2.playLeft();
    player2.playRight();
  }
    if ( key == '3')
  {
    stopAll();
    player3.playLeft();
    player3.playRight();
  }
    if ( key == '4')
  {
    stopAll();
    player4.playLeft();
    player4.playRight();
  }
    if ( key == '5')
  {
    stopAll();
    player5.playLeft();
    player5.playRight();
  }
    if ( key == '6')
  {
    stopAll();
    player6.playLeft();
    player6.playRight();
  }
  
}

void noteOn(int channel, int pitch, int velocity) {
  switch (pitch)
  {
  case 59:
    player1.playLeft();
    break;
  case 58:
    player1.playRight();    
    break;
  case 57:
    player2.playLeft();
    break;
  case 56:
    player2.playRight();
    break;
  case 55:
    player3.playLeft();
    break;
  case 54:
    player3.playRight();
    break;
  case 53:
    player4.playLeft();
    break;
  case 52:
    player4.playRight();
    break;
  case 51:
    player5.playLeft();
    break;
  case 50:
    player5.playRight();
    break;
  }
}

void noteOff(int channel, int pitch, int velocity) {
  switch (pitch)
  {
  case 59:
    player1.stopLeft();
    break;
  case 58:
    player1.stopRight();    
    break;
  case 57:
    player2.stopLeft();
    break;
  case 56:
    player2.stopRight();
    break;
  case 55:
    player3.stopLeft();
    break;
  case 54:
    player3.stopRight();
    break;
  case 53:
    player4.stopLeft();
    break;
  case 52:
    player4.stopRight();
    break;
  case 51:
    player5.stopLeft();
    break;
  case 50:
    player5.stopRight();
    break;
  }
}
