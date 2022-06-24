PImage seed;
IntDict inventory;

color storedColor;

void setup() {
    size(512, 512);
    noStroke();
    String url = "https://picsum.photos/"+ width +"/"+height;
    seed = loadImage(url, "jpg");

    inventory = new IntDict();
    noLoop();

}

void draw() {
    image(seed, 0, 0);

    for (int i = 0; i < seed.width; ++i) {
        for (int j = 0; j < seed.height; ++j) {
            int pixelIndex = i + j * width;
            color pixR = seed.pixels[pixelIndex];
            color pixG = seed.pixels[pixelIndex];
            color pixB = seed.pixels[pixelIndex];

            float cR = red(pixR);
            float cG = green(pixG);
            float cB = blue(pixB);

            storedColor = color(cR, cG, cB);

            inventory.set(str(pixelIndex), storedColor);


        }
    }
            println(inventory);
            fill(storedColor);
            rect(0, 0, 100, 100);
}
