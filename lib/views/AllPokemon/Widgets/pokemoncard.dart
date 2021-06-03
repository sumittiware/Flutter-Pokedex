import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex/Data/type.dart';
import 'package:pokedex/Models/pokemon.dart';
import 'package:pokedex/Provider/pokemon_provider.dart';
import 'package:pokedex/styles/appimages.dart';
import 'package:pokedex/styles/colors.dart';
import 'package:pokedex/styles/typegradient.dart';
import 'package:pokedex/views/PokemonDetails/pokemondetail.dart';
import 'package:provider/provider.dart';
import '../../../styles/context.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard(this.pokemon, this.index, {this.isfromSearch = false});

  final int index;
  final Pokemon pokemon;
  final bool isfromSearch;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final height = constraints.maxHeight;
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
              colors: getTypeColor(pokemon.type) ?? CustomColors.fire),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, context.responsive(8)),
              blurRadius: 15,
              color: AppColors.black.withOpacity(0.12),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              Provider.of<PokemonProvider>(context, listen: false)
                  .setCurrentIndex(index);
              return PokeInfo(
                isSearched: isfromSearch,
              );
            }));
          },
          child: Stack(
            children: <Widget>[
              Container(
                constraints: BoxConstraints.expand(),
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: context.responsive(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      pokemon.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      pokemon.id,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: -height * 0.136,
                right: -height * 0.03,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image(
                      image: AppImages.pokeball,
                      width: height,
                      height: height,
                      color: AppColors.black.withOpacity(0.05),
                    ),
                    Image.network(
                      pokemon.imageUrl,
                      fit: BoxFit.contain,
                      width: height * 0.7,
                      height: height * 0.7,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
