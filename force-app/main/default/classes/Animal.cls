public inherited sharing class Animal {

    public String animalType;

    public Animal(String animalType) {
        this.animalType = animalType;
    }

    public void makeNoise() {
        if (animalType == 'Lion') {
            roar();
        }
        else if (animalType == 'Cat') {
            meow();
        }
        else if (animalType == 'Horse') {
            neigh();
        }
        else if (animalType == 'Alligator') {
            hiss();
        }
        else if (animalType == 'Bear') {
            growl();
        }
        else if (animalType == 'Cow') {
            moo();
        }
        else if (animalType == 'Dog') {
            bark();
        }
    }

    public void move() {
        if (animalType == 'Lion' || animalType == 'Dog') {
            run();
        }
        else if (animalType == 'Cat' || animalType == 'Bear' || animalType == 'Cow') {
            walk();
        }
        else if (animalType == 'Horse') {
            slide();
        }
        else if (animalType == 'Alligator') {
            hiss();
        }
    }

    public void swim() {
        if (animalType == 'Lion' || animalType == 'Alligator' || animalType == 'Bear' || animalType == 'Dog') {
            doSwim();
        }
    }

    private void roar() {
        // roaring behavior here
    }

    private void meow() {
        // meowing behavior here
    }

    private void neigh() {
        // neighing behavior here
    }

    private void hiss() {
        // hissing behavior here
    }

    private void growl() {
        // growling behavior here
    }

    private void moo() {
        // mooing behavior here
    }

    private void bark() {
        // barking behavior here
    }

    private void run() {
        // running behavior here
    }

    private void walk() {
        // walking behavior here
    }

    private void slide() {
        // sliding behavior here
    }

    private void doSwim() {
        // swimming behavior here
    }


}