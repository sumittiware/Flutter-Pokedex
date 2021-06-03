class Pokemon {
  String id;
  String name;
  String description;
  String imageUrl;
  String category;
  String eggroup;
  List<dynamic> abilties;
  List<dynamic> evolutions;
  List<dynamic> type;
  List<dynamic> weakness;
  String malepercentage;
  String height;
  String weight;
  int attack;
  String baseXp;
  String cycles;
  int defense;
  int hp;
  int specialAttack;
  int specialDefense;
  int speed;
  int total;

  Pokemon(
      {this.id,
      this.name,
      this.description,
      this.imageUrl,
      this.category,
      this.eggroup,
      this.abilties,
      this.evolutions,
      this.type,
      this.weakness,
      this.malepercentage,
      this.height,
      this.weight,
      this.attack,
      this.baseXp,
      this.cycles,
      this.defense,
      this.hp,
      this.specialAttack,
      this.specialDefense,
      this.speed,
      this.total});
}
