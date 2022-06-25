/* autogenerated by Processing revision 1276 on 2022-06-25 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class averaging_colors extends PApplet {

PImage seed;
IntDict inventory;

int storedColor;
int starter;

 public void setup() {
    /* size commented out by preprocessor */;
    noStroke();
    String url = "https://picsum.photos/"+ width +"/"+height;
    seed = loadImage(url, "jpg");

    inventory = new IntDict();
    starter = 1;
    noLoop();

}

 public void draw() {
    image(seed, 0, 0);

    for (int i = 0; i < seed.width; ++i) {
        for (int j = 0; j < seed.height; ++j) {
            int pixelIndex = i + j * width;
            int pixR = seed.pixels[pixelIndex];
            int pixG = seed.pixels[pixelIndex];
            int pixB = seed.pixels[pixelIndex];

            float cR = red(pixR);
            float cG = green(pixG);
            float cB = blue(pixB);

            storedColor = color(cR, cG, cB);

            if (inventory.hasKey(str(storedColor)) == true) {
                inventory.increment(str(storedColor));
            } else {
                inventory.set(str(storedColor), starter);
            }
        }
    }
            // inventory.maxValue();
            String stringColor = inventory.maxKey();

            println(inventory.maxKey(), inventory.maxValue());
            println(hex(stringColor));
            fill(storedColor);
            rect(0, 0, 100, 100);
}


  public void settings() { size(512, 512); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "averaging_colors" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
