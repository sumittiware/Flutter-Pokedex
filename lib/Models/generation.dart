import 'package:flutter/foundation.dart';

class Generation {
  const Generation(
      {@required this.title,
      @required this.pokemons,
      @required this.region,
      @required this.initialIndex,
      @required this.finalIndex});

  final List<String> pokemons;
  final String title;
  final String region;
  final int initialIndex;
  final int finalIndex;
}
