import 'package:flutter/cupertino.dart';
import 'package:pokedex/Models/type.dart';
import 'package:pokedex/styles/typegradient.dart';

List<PokemonType> pokemontypes = [
  PokemonType(
      type: "Dragon",
      colors: CustomColors.dragon,
      tagImg: "assets/pngs/Tag-Dragon.png",
      typeImg: "assets/pngs/Types-Dragon.png"),
  PokemonType(
      type: "Grass",
      colors: CustomColors.grass,
      tagImg: "assets/pngs/Tag-Grass.png",
      typeImg: "assets/pngs/Types-Grass.png"),
  PokemonType(
      type: "Fire",
      colors: CustomColors.fire,
      tagImg: "assets/pngs/Tag-Fire.png",
      typeImg: "assets/pngs/Types-Fire.png"),
  PokemonType(
      type: "Water",
      colors: CustomColors.water,
      tagImg: "assets/pngs/Tag-Water.png",
      typeImg: "assets/pngs/Types-Water.png"),
  PokemonType(
      type: "Bug",
      colors: CustomColors.bug,
      tagImg: "assets/pngs/Tag-Bug.png",
      typeImg: "assets/pngs/Types-Bug.png"),
  PokemonType(
      type: "Dark",
      colors: CustomColors.dark,
      tagImg: "assets/pngs/Tag-Dark.png",
      typeImg: "assets/pngs/Types-Dark.png"),
  PokemonType(
      type: "Electric",
      colors: CustomColors.electric,
      tagImg: "assets/pngs/Tag-Electric.png",
      typeImg: "assets/pngs/Types-Electric.png"),
  PokemonType(
      type: "Fairy",
      colors: CustomColors.fairy,
      tagImg: "assets/pngs/Tag-Fairy.png",
      typeImg: "assets/pngs/Types-Fairy.png"),
  PokemonType(
      type: "Fight",
      colors: CustomColors.fight,
      tagImg: "assets/pngs/Tag-Fight.png",
      typeImg: "assets/pngs/Types-Fight.png"),
  PokemonType(
      type: "Flying",
      colors: CustomColors.flying,
      tagImg: "assets/pngs/Tag-Flying.png",
      typeImg: "assets/pngs/Types-Flying.png"),
  PokemonType(
      type: "Ghost",
      colors: CustomColors.ghost,
      tagImg: "assets/pngs/Tag-Ghost.png",
      typeImg: "assets/pngs/Types-Ghost.png"),
  PokemonType(
      type: "Ground",
      colors: CustomColors.ground,
      tagImg: "assets/pngs/Tag-Ground.png",
      typeImg: "assets/pngs/Types-Ground.png"),
  PokemonType(
      type: "Ice",
      colors: CustomColors.ice,
      tagImg: "assets/pngs/Tag-Ice.png",
      typeImg: "assets/pngs/Types-Ice.png"),
  PokemonType(
      type: "Steel",
      colors: CustomColors.steel,
      tagImg: "assets/pngs/Tag-Steel.png",
      typeImg: "assets/pngs/Types-Steel.png"),
  PokemonType(
      type: "Rock",
      colors: CustomColors.rock,
      tagImg: "assets/pngs/Tag-Rock.png",
      typeImg: "assets/pngs/Types-Rock.png"),
  PokemonType(
      type: "Psychic",
      colors: CustomColors.psychic,
      tagImg: "assets/pngs/Tag-Psychic.png",
      typeImg: "assets/pngs/Types-Psychic.png"),
  PokemonType(
      type: "Poison",
      colors: CustomColors.poison,
      tagImg: "assets/pngs/Tag-Poison.png",
      typeImg: "assets/pngs/Types-Poison.png"),
];

getTypeColor(List<dynamic> type) {
  List<Color> colors = CustomColors.normal;
  for (int i = 0; i < pokemontypes.length; i++) {
    if (type.contains(pokemontypes[i].type)) {
      colors = pokemontypes[i].colors;
      break;
    }
  }
  return colors;
}

getTagImage(String type) {
  var result = "assets/pngs/Tag-Normal.png";
  for (int i = 0; i < pokemontypes.length; i++) {
    if (type == pokemontypes[i].type) {
      result = pokemontypes[i].tagImg;
      break;
    }
  }
  return result;
}

getTypeImage(String type) {
  var result = "assets/pngs/Types-Normal.png";
  for (int i = 0; i < pokemontypes.length; i++) {
    if (type == pokemontypes[i].type) {
      result = pokemontypes[i].typeImg;
      break;
    }
  }
  return result;
}
