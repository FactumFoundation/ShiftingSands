class TwoOscillatorManager
{
  PApplet            parent;
  Minim              minim;
  AudioOutput        output;
  Mixer              mixer;

  Pan                panLeft;
  Pan                panRight;  
  Gain               gainLeft;
  Gain               gainRight;


  TwoOscillatorManager( PApplet parent, Mixer mixer )
  {
    this.parent = parent;
    this.mixer = mixer;  
    minim = new Minim(parent);
    minim.setOutputMixer(mixer);
    output = minim.getLineOut();
  }

  void update()
  {
  };
  
  
}
