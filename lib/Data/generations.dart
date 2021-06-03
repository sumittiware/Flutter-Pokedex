import 'package:pokedex/Models/generation.dart';

const List<Generation> generations = [
  Generation(
    title: 'Generation I',
    region: 'Kento Region',
    initialIndex: 0,
    finalIndex: 150,
    pokemons: [
      'assets/images/bulbasaur.png',
      'assets/images/charmander.png',
      'assets/images/squirtle.png'
    ],
  ),
  Generation(
    title: 'Generation II',
    region: 'Jotho Region',
    initialIndex: 151,
    finalIndex: 250,
    pokemons: [
      'assets/images/chikorita.png',
      'assets/images/cyndaquil.png',
      'assets/images/totodile.png'
    ],
  ),
  Generation(
    title: 'Generation III',
    region: 'Hoenn Region',
    initialIndex: 251,
    finalIndex: 385,
    pokemons: [
      'assets/images/treecko.png',
      'assets/images/torchic.png',
      'assets/images/mudkip.png'
    ],
  ),
  Generation(
    title: 'Generation IV',
    region: 'Sinnoh Region',
    initialIndex: 386,
    finalIndex: 493,
    pokemons: [
      'assets/images/turtwig.png',
      'assets/images/chimchar.png',
      'assets/images/piplup.png'
    ],
  ),
  Generation(
    title: 'Generation V',
    region: 'Unova Region',
    initialIndex: 494,
    finalIndex: 648,
    pokemons: [
      'assets/images/snivy.png',
      'assets/images/tepig.png',
      'assets/images/oshawott.png'
    ],
  ),
  Generation(
    title: 'Generation VI',
    region: 'Kalos Region',
    initialIndex: 649,
    finalIndex: 720,
    pokemons: [
      'assets/images/chespin.png',
      'assets/images/fennekin.png',
      'assets/images/froakie.png'
    ],
  ),
  Generation(
    title: 'Generation VII',
    region: 'Alola Region',
    initialIndex: 721,
    finalIndex: 809,
    pokemons: [
      'assets/images/rowlet.png',
      'assets/images/litten.png',
      'assets/images/popplio.png'
    ],
  ),
  Generation(
    title: 'Generation VIII',
    region: 'Galar Region',
    initialIndex: 0,
    finalIndex: 0,
    pokemons: [
      'assets/images/grookey.png',
      'assets/images/scorbunny.png',
      'assets/images/sobble.png'
    ],
  ),
];
