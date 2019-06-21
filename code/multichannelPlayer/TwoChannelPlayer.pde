//----------------------------------------------------------------------
// TwoChannelPlayer.pde
//
// Two channel sound player. You can specify sound device number to run
// several sound cards simultaneously
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

class TwoChannelPlayer
{
  PApplet            parent;
  Minim              minim;
  AudioOutput        output;
  Mixer              mixer;

  FilePlayer         filePlayerLeft;
  FilePlayer         filePlayerRight;
  Pan                panLeft;
  Pan                panRight;  
  Gain               gainLeft;
  Gain               gainRight;
  boolean            isFadeOutLeft  = false;  
  boolean            isFadeOutRight = false;
  float              gainValueLeft = 0.0f;
  float              gainValueRight = 0.0f;

  TwoChannelPlayer( PApplet parent, Mixer mixer )
  {
    this.parent = parent;
    this.mixer = mixer;  
    minim = new Minim(parent);
    minim.setOutputMixer(mixer);
    output = minim.getLineOut();
  }

  void update()
  {
    if (isFadeOutLeft)
    {
      if (gainValueLeft>-48.0f)
      {
        gainValueLeft-=0.1f;
        gainLeft.setValue(gainValueLeft);
      } else {
        if (filePlayerLeft.isPlaying())
          filePlayerLeft.pause();
      }
    }
    if (isFadeOutRight)
    {
      if (gainValueRight>-48.0f)
      {
        gainValueRight-=0.1f;
        gainRight.setValue(gainValueRight);
      } else {
        if (filePlayerRight.isPlaying())
          filePlayerRight.pause();
      }
    }
  };

  void loadChannelLeft( String fileName, Minim parentMinim )
  {
    filePlayerLeft = new FilePlayer( parentMinim.loadFileStream(fileName) );
    panLeft = new Pan(-1.0);  
    gainLeft = new Gain(gainValueLeft);
    filePlayerLeft.patch(gainLeft).patch(panLeft).patch(output);
    //filePlayerLeft.loop();
  }

  void loadChannelRight( String fileName, Minim parentMinim )
  {
    filePlayerRight = new FilePlayer( parentMinim.loadFileStream(fileName) );
    panRight = new Pan(1.0);    
    gainRight = new Gain(gainValueRight);
    filePlayerRight.patch(gainRight).patch(panRight).patch(output);
    //filePlayerRight.loop();
  }

  void playLeft()
  {
    filePlayerLeft.cue(0);
    filePlayerLeft.play();

    isFadeOutLeft = false;
    gainValueLeft = 0f;
    gainLeft.setValue(gainValueLeft);
  };

  void playRight()
  {
    filePlayerRight.cue(0);
    filePlayerRight.play();

    isFadeOutRight = false;
    gainValueRight = 0f;
    gainRight.setValue(gainValueRight);
  };

  void stopLeft()
  {
    //if (filePlayerLeft.isPlaying())
    isFadeOutLeft = true;
    //filePlayerLeft.pause();
  };

  void stopRight()
  {
    //if (filePlayerRight.isPlaying())
    isFadeOutRight = true;
    //filePlayerRight.pause();
  };
}