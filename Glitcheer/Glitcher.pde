class Glitcher{
  PImage output;
  float r, g, b;
  color c;

  /**
  *  Get an image to glitch, and the horizontal and vertical displacement of RGB channels.
  */
  public PImage getTransposedRgb(PImage src, int horiz, int vert){
    this.output = createImage(src.width, src.height, RGB);
    
    for(int h = 0; h < src.height; h++){
      for(int w = 0; w < src.width; w++){
        this.r = red(src.get((w + horiz > src.width || w + horiz < 0 ? w : w + horiz), (h + vert > src.height || h + vert < 0 ? h : h + vert)));
        this.g = green(src.get(w, h));
        this.b = blue(src.get((w - horiz > src.width || w - horiz < 0 ? w : w - horiz), (h - vert > src.height || h - vert < 0 ? h : h - vert)));
        c = color(r, g, b);
        this.output.set(w, h, c);
      }
    }
    return this.output;
  }
  
  /**
  *  Displaces the RGB channels horizontally, every N vertical pixels.
  */
  public PImage getSteppedTransposedRgb(PImage src, int horiz, int steps) {
    this.output = createImage(src.width, src.height, RGB);
    boolean transposeSwitch = true;
    int counter = 0;
    for(int h = 0; h < src.height; h++){
      if(counter >= steps) {
        counter = 0;
        transposeSwitch = (transposeSwitch ? false : true);
      }
      for(int w = 0; w < src.width; w++){
        if(counter < steps && transposeSwitch == true){
          this.r = red(src.get((w + horiz > src.width || w + horiz < 0 ? w : w + horiz), h));
          this.g = green(src.get(w, h));
          this.b = blue(src.get((w - horiz > src.width || w - horiz < 0 ? w : w - horiz), h));
        } else {
          this.r = red(src.get(w, h));
          this.g = green(src.get(w, h));
          this.b = blue(src.get(w, h));
        }
        c = color(r, g, b);
        this.output.set(w, h, c);
      }
      counter += 1;
    }
    return this.output;
  }
  
  /**
  *  I screwed up and something cool came up.
  *  Left it for science.
  */
  public PImage getWeirdShit(int wid, int hei) {
    this.output = createImage(wid, hei, RGB);
    this.output.loadPixels();
    
    for(int h = 0; h < output.height; h++){
      for(int w = 0; w < output.width; w++){
        this.output.pixels[w * h] = color(255, 255, 0);
      }
    }
    return this.output;
  }
  
  /**
  * Displaces the pixel, depending on it's brightness.
  */
  public PImage getThresholdDisplacement(PImage src, int maxDisplacement) {
    this.output = createImage(src.width + abs(maxDisplacement), src.height, RGB);
    this.output.loadPixels();
    
    for(int h = 0; h < output.height; h++){
      for(int w = 0; w < output.width; w++){
        int displacement = (int) map(brightness(src.get(w, h)), 0, 255, 0, maxDisplacement);
        this.output.set(w, h, src.get((w + maxDisplacement) - displacement, h));
      }
    }
    return this.output;
  }
  
  /**
  * Gets the filename of the image to hack
  * fucks it up, saves the hacked copy,
  * and returns the PImage of the latter.
  */
  public PImage getByteGlitched(String file, int bytesToInject) {
    byte[] data = loadBytes(file);
    
    for(int i = 0; i < bytesToInject; i++){
      data[(int)random(128, data.length)] = (byte)(random(255));
    }
    
    saveBytes("hacked.jpg", data);
    return loadImage("hacked.jpg");
  }
  
}
