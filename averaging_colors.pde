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

    for (int i = 0; i < pg.width; ++i) {
        for (int j = 0; j < pg.height; ++j) {
            int pixelIndex = i + j * width / divider;
            color pixR = pg.pixels[pixelIndex];
            color pixG = pg.pixels[pixelIndex];
            color pixB = pg.pixels[pixelIndex];

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
    println(inventory);
    float neededNbr = 40;
    float amount = sq(neededNbr); //square the grid
    float w = (width / divider) / neededNbr;
    float h = height / neededNbr;
    
    for (int index = 1; index < amount + 1; index++) {

        usableColor = unhex(inventory.key(index));
        sg.stroke(usableColor);
        sg.fill(usableColor);
        sg.rect(col, row, w, h);
    
        col += w;
        
        if(index % neededNbr == 0) {
            row += h;
            col = 0;
        }

    }

    sg.endDraw();
}
