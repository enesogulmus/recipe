class Recipe {

  String title;
  String description;
  String image;
  String nutrition;
  int time;
  int calories;
  int carbo;
  int protein;



  Recipe(this.title, this.description, this.image,this.nutrition,this.time, this.calories, this.carbo, this.protein);

}

List<Recipe> getRecipes(){
  return <Recipe>[
    Recipe("Chicken Fried Rice", "So irresistibly delicious", "assets/images/chicken_fried_rice.png","Vegetable", 12, 212, 35, 6),
    Recipe("Pasta Bolognese", "True Italian classic with a meaty, chilli sauce", "assets/images/pasta_bolognese.png","Vegetable", 15, 246, 45, 10),
    Recipe("Garlic Potatoes", "Crispy Garlic Roasted Potatoes", "assets/images/filete_con_papas_cambray.png","Vegetable", 29, 301, 30, 8),
    Recipe("Asparagus", "White Onion, Fennel, and watercress Salad", "assets/images/asparagus.png","Vegetable", 35, 327, 35, 12),
    Recipe("Filet Mignon", "Bacon-Wrapped Filet Mignon", "assets/images/steak_bacon.png","Vegetable", 55, 364, 55, 20),

    Recipe("Split pea and vegetable curry", "Is a real mood-boosting dish", "assets/images/split-pea-and-vegetable-curry.png","Normal", 13, 288 , 15, 12),
    Recipe("Squash and pepper risotto", "Comforting and tasty but irresistibly low in fat", "assets/images/squash-and-pepper-risotto.png","Normal", 14, 367, 71, 11),
    Recipe("Roast chicken with potato wedges", "Chicken and potatoes roasted in the same pan", "assets/images/roast-chicken-with-potato-wedges.png","Normal", 28, 378, 39, 23),
    Recipe("Sweet chilli prawn stir-fry", "Delicious sweet and spicy flavours", "assets/images/sweet-chilli-prawn-stir-fry.png","Normal", 34, 220 , 23, 20),
    Recipe("Baked stuffed peppers", "Slow roasted peppers filled to the brim with tasty bacon", "assets/images/baked-stuffed-peppers.png","Normal", 54, 209 , 12, 10),

    Recipe("Butternut squash risotto", "A warm and comforting butternut squash risotto", "assets/images/butternut-squash-risotto.png","Vegan", 11, 320 , 69, 7),
    Recipe("Pissaladière", "This French-style onion tart makes a lovely light lunch", "assets/images/pissaladiere.png","Vegan", 10, 293 , 27, 7),
    Recipe("Thai prawn curry and noodles", "A gorgeous red curry in fragrant coconut milk", "assets/images/thai-prawn-curry-noodles.png","Vegan", 30, 326 , 32, 11),
    Recipe("Baked chicken jambalaya", "A delicious, slightly spicy one-pot meal", "assets/images/baked-chicken-jambalaya.png","Vegan", 33, 350 , 17, 33),
    Recipe("Chicken and spring onion pancake", "Onion pancake is absolutely delicious", "assets/images/meat-pancake.png","Vegan", 56, 298 , 24, 20),
  ];
}