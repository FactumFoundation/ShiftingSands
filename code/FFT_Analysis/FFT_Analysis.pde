/**
  * This sketch demonstrates how to an <code>AudioRecorder</code> to record audio to disk. 
  * To use this sketch you need to have something plugged into the line-in on your computer, 
  * or else be working on a laptop with an active built-in microphone. 
  * <p>
  * Press 'r' to toggle recording on and off and the press 's' to save to disk. 
  * The recorded file will be placed in the sketch folder of the sketch.
  * <p>
  * For more information about Minim and additional features, 
  * visit http://code.compartmental.net/minim/
  */

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;
AudioInput in;
AudioRecorder recorder;

FFT fftLin;
FFT fftLog;

float height3;
float height23;
float spectrumScale = 4;

PFont font;

void setup()
{
  size(512, 200, P3D);
  
  minim = new Minim(this);

  in = minim.getLineIn(Minim.STEREO, 1024, 44100, 24);
  
// create an FFT object that has a time-domain buffer the same size as jingle's sample buffer
  // note that this needs to be a power of two 
  // and that it means the size of the spectrum will be 1024. 
  // see the online tutorial for more info.
  fftLin = new FFT( in.bufferSize(), in.sampleRate() );
  
  // calculate the averages by grouping frequency bands linearly. use 30 averages.
  fftLin.linAverages( 30 );
  
  // create an FFT object for calculating logarithmically spaced averages
  fftLog = new FFT( in.bufferSize(), in.sampleRate() );
  
  // calculate averages based on a miminum octave width of 22 Hz
  // split each octave into three bands
  // this should result in 30 averages
  fftLog.logAverages( 22, 3 );
  
  rectMode(CORNERS);
  font = loadFont("ArialMT-12.vlw");
}

void draw()
{
  background(0);
  
  textFont(font);
  textSize( 18 );
 
  float centerFrequency = 0;
  
  // perform a forward FFT on the samples in jingle's mix buffer
  // note that if jingle were a MONO file, this would be the same as using jingle.left or jingle.right
  fftLin.forward( in.mix );
  fftLog.forward( in.mix );
 
  // draw the full spectrum
  {
    noFill();
    for(int i = 0; i < fftLin.specSize(); i++)
    {
      // if the mouse is over the spectrum value we're about to draw
      // set the stroke color to red
      if ( i == mouseX )
      {
        centerFrequency = fftLin.indexToFreq(i);
        stroke(255, 0, 0);
      }
      else
      {
          stroke(255);
      }
      line(i, height3, i, height3 - fftLin.getBand(i)*spectrumScale);
    }
    
    fill(255, 128);
    text("Spectrum Center Frequency: " + centerFrequency, 5, height3 - 25);
  }
  
  // no more outline, we'll be doing filled rectangles from now
  noStroke();
  
  // draw the linear averages
  {
    // since linear averages group equal numbers of adjacent frequency bands
    // we can simply precalculate how many pixel wide each average's 
    // rectangle should be.
    int w = int( width/fftLin.avgSize() );
    for(int i = 0; i < fftLin.avgSize(); i++)
    {
      // if the mouse is inside the bounds of this average,
      // print the center frequency and fill in the rectangle with red
      if ( mouseX >= i*w && mouseX < i*w + w )
      {
        centerFrequency = fftLin.getAverageCenterFrequency(i);
        
        fill(255, 128);
        text("Linear Average Center Frequency: " + centerFrequency, 5, height23 - 25);
        
        fill(255, 0, 0);
      }
      else
      {
          fill(255);
      }
      // draw a rectangle for each average, multiply the value by spectrumScale so we can see it better
      rect(i*w, height23, i*w + w, height23 - fftLin.getAvg(i)*spectrumScale);
    }
  }
  
  // draw the logarithmic averages
  {
    // since logarithmically spaced averages are not equally spaced
    // we can't precompute the width for all averages
    for(int i = 0; i < fftLog.avgSize(); i++)
    {
      centerFrequency    = fftLog.getAverageCenterFrequency(i);
      // how wide is this average in Hz?
      float averageWidth = fftLog.getAverageBandWidth(i);   
      
      // we calculate the lowest and highest frequencies
      // contained in this average using the center frequency
      // and bandwidth of this average.
      float lowFreq  = centerFrequency - averageWidth/2;
      float highFreq = centerFrequency + averageWidth/2;
      
      // freqToIndex converts a frequency in Hz to a spectrum band index
      // that can be passed to getBand. in this case, we simply use the 
      // index as coordinates for the rectangle we draw to represent
      // the average.
      int xl = (int)fftLog.freqToIndex(lowFreq);
      int xr = (int)fftLog.freqToIndex(highFreq);
      
      // if the mouse is inside of this average's rectangle
      // print the center frequency and set the fill color to red
      if ( mouseX >= xl && mouseX < xr )
      {
        fill(255, 128);
        text("Logarithmic Average Center Frequency: " + centerFrequency, 5, height - 25);
        fill(255, 0, 0);
      }
      else
      {
          fill(255);
      }
      // draw a rectangle for each average, multiply the value by spectrumScale so we can see it better
      rect( xl, height, xr, height - fftLog.getAvg(i)*spectrumScale );
    }
  }
}
