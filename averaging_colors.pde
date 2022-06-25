PImage seed;
IntDict inventory;

String storedColor;
int usableColor;
int starter;

void setup() {
    size(512, 512);
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

    inventory.sortValuesReverse();
    float amount = 100;
    float w = width / amount;
    float h = height / amount;

    for (int index = 0; index < amount; index++) {
        int posX = int(index * w);  
        usableColor = unhex(inventory.key(index));
        stroke(usableColor);
        fill(usableColor);
        rect(posX, 0, w, h);
    }

}
