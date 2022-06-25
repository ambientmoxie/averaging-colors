PImage seed;
IntDict inventory;

String storedColor;
int starter;

void setup() {
    size(512, 512);
    noStroke();
    String url = "https://picsum.photos/"+ width +"/"+height;
    seed = loadImage(url, "jpg");

    inventory = new IntDict();
    starter = 1;
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

            storedColor = hex(color(cR, cG, cB));

            if (inventory.hasKey(storedColor) == true) {
                inventory.increment(storedColor);
            } else {
                inventory.set(storedColor, starter);
            }
        }
    }
            // Convertir string to byte, byte to hex
            //String stringColor = inventory.maxKey();

            //println(inventory.maxKey(), inventory.maxValue());
            println(storedColor);
            fill(unhex(storedColor));
            rect(0, 0, 100, 100);
}
