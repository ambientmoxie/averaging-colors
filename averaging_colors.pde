// ---------------------------------------------------------------
// Author : Maxime Benoit
// Date : 27/06/2022
// Description : Parse and sort colors from an image
// Next : Rasterized seed image for a better average color display
// ---------------------------------------------------------------

PGraphics pg;
PGraphics sg;
PImage seed;
IntDict inventory;

String storedColor;
int usableColor;
int starter;
int divider;

int incr = 0;

float col;
float row;

void setup() {
    size(1024, 512);
    
    pixelDensity(2);

    divider = 2;

    col = 0;
    row = 0;

    String url = "https://picsum.photos/"+ width / divider +"/"+height;
    pg = createGraphics(width / divider, height);
    sg = createGraphics(width / divider, height);
    seed = loadImage(url, "jpg");
    //seed = loadImage("test.png");
    inventory = new IntDict();
    starter = 1; 
}

void draw() {

    displaySeed();
    displayShapes();
    image(pg, 0,0);
    image(sg, width / divider,0);
    noLoop();
    
}

void displaySeed(){
    pg.beginDraw();
    pg.background(255,0,0);
    pg.image(seed, 0, 0);
    pg.endDraw();
}

void displayShapes(){

    sg.beginDraw();

    sg.background(255);

    for (int i = 0; i < seed.width; ++i) {
        for (int j = 0; j < seed.height; ++j) {
            int pixelIndex = i + j * seed.width;
            color pixR = seed.pixels[pixelIndex];
            color pixG = seed.pixels[pixelIndex];
            color pixB = seed.pixels[pixelIndex];

            float cR = red(pixR);
            float cG = green(pixG);
            float cB = blue(pixB);

            storedColor = hex(color(cR, cG, cB));

            if (inventory.hasKey(storedColor) == true) {
                inventory.increment(storedColor);
            } else {
                inventory.set(storedColor, starter);
            }
        }
    }

    inventory.sortValuesReverse();



    // Check how many value there is in the dict
    //  devideArray();
    // Separate this values into (random nmb) pack exemple : 4



    // Faire la moyenne de chaque pack
    // resulting average 4 colors 

    //float amount = 3;
    float neededNbr = 10;
    float amount = sq(neededNbr); //square the grid
    float w = sg.width / neededNbr;
    float h = sg.height / neededNbr;
    
    for (int index = 0; index < amount + 1; index++) {

        usableColor = unhex(inventory.key(index));
        sg.stroke(usableColor);
        sg.fill(usableColor);
        sg.rect(col, row, w, h);
    
        col += w;
        
        if(index % neededNbr == 0 && index != 0) {
            row += h;
            col = 0;
        }
    }

    sg.endDraw();
}

// void devideArray(){
//     // Check how many value there is in the dict
//     int shunk = 10;
//     int dictSize = inventory.size();
//     println(dictSize);
//     // Separate this values into (random nmb) pack exemple : 10
//     String[] theKeys = inventory.keyArray();
//     for(int i = 0; i < theKeys.length; i++) {

//         if(i % shunk == 0 && i != 0) {
//             theKeys = splice(theKeys, "/", i);
//         }
//     }
//     String[] splitedColorArray = split(theKeys, '/');
//     println(splitedColorArray[1]);
  
// }