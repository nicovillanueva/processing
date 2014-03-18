import java.io.File;
import java.nio.*;

/**
* Convert into singleton!!!
*/

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
  * Get PImage to fuck, save it into a file (to get each byte)
  * 
  */
  public PImage getByteGlitched(PImage src, int bytesToInject) {
    String preHackFile = dataPath("hackme.jpg");
    String postHackFile = dataPath("hacked.jpg");
    src.save(preHackFile);
    byte[] data = loadBytes(preHackFile);
    
    for(int i = 0; i < bytesToInject; i++){
      data[(int)random(128, data.length)] = (byte)(random(255));
      println("Corruption rounds: " + (i+1));
    }
    
    saveBytes(postHackFile, data);
    
    PImage hacked = loadImage(postHackFile);
    
    new File(preHackFile).delete();
    new File(postHackFile).delete();
    return hacked;
  }
  
  public PImage getByteGlitchedNEW(PImage src, int bytesToInject) {
    String postHackFile = dataPath("hacked.jpg");
    
    src.loadPixels();
    int[] srcpxls = src.pixels; 
    /*ByteBuffer bytebuff = ByteBuffer.allocate(srcpixels.length * 4);
    IntBuffer intbuff = bytebuff.asIntBuffer();
    intbuff.put(srcpixels);
    byte[] data = bytebuff.array();*/
    ByteBuffer bb = ByteBuffer.allocate(srcpxls.length * 4);
    bb.asIntBuffer().put(srcpxls);
    byte[] data = bb.array();
    
    for(int i = 0; i < bytesToInject; i++){
      data[(int)random(128, data.length)] = (byte)(random(255));
      println("Corruption rounds: " + (i+1));
    }
    
    saveBytes(postHackFile, data);
    
    PImage hacked = loadImage(postHackFile);
    
    new File(postHackFile).delete();
    return hacked;
  }
  
  /**
  * Pixellate
  */
  public PImage getPixelatedImage(PImage src, int sqSize) {
     // Divide into square array
     // Take average
     // fill each pxl with avg
     return null;
  }
}
