import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex/Models/generation.dart';

import 'package:pokedex/styles/appimages.dart';
import 'package:pokedex/styles/colors.dart';
import 'package:pokedex/views/AllPokemon/allpokemon.dart';
import '../../../styles/context.dart';

class GenerationCard extends StatelessWidget {
  const GenerationCard(this.generation);

  final Generation generation;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final height = constraints.maxHeight;

      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AllPokemons(
              generation: generation,
            );
          }));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, context.responsive(8)),
                blurRadius: 15,
                color: AppColors.black.withOpacity(0.12),
              ),
            ],
          ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      generation.title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Text(
                      generation.region,
                      // style: TextStyle(),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: -height * 0.136,
                right: -height * 0.03,
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Image(
                      image: AppImages.pokeball,
                      width: height,
                      height: height,
                      color: AppColors.black.withOpacity(0.05),
                    ),
                    SizedBox(
                      width: height * 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: generation.pokemons
                            .map(
                              (pokemon) => Expanded(
                                child: Image.asset(
                                  pokemon,
                                  fit: BoxFit.contain,
                                  width: height * 0.6,
                                  height: height * 0.6,
                                ),
                              ),
                            )
                            .toList(),
                      ),
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
