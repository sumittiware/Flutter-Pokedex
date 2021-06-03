import 'package:flutter/material.dart';
import 'package:pokedex/Models/generation.dart';
import 'package:pokedex/Provider/pokemon_provider.dart';
import 'package:pokedex/styles/colors.dart';
import 'package:pokedex/views/AllPokemon/Widgets/pokemoncard.dart';
import 'package:provider/provider.dart';
import '../../styles/context.dart';

class AllPokemons extends StatefulWidget {
  final Generation generation;
  AllPokemons({this.generation});
  @override
  _AllPokemonsState createState() => _AllPokemonsState();
}

class _AllPokemonsState extends State<AllPokemons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(widget.generation.title,
              style: TextStyle(color: AppColors.black))),
      body: _buildPokemon(context, widget.generation),
    );
  }

  Widget _buildPokemon(BuildContext context, Generation generation) {
    final pokemons = Provider.of<PokemonProvider>(context, listen: false)
        .pokemonByGeneration(generation);
    return (pokemons.length == 0)
        ? Center(child: Text("Comming Soon!!"))
        : GridView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              left: 26,
              right: 26,
              top: context.responsive(26),
              bottom: context.responsive(26) + context.padding.bottom,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.55,
              crossAxisSpacing: 10,
              mainAxisSpacing: context.responsive(10),
            ),
            children: List.generate(
              pokemons.length,
              (index) => PokemonCard(pokemons[index], index),
            ),
          );
  }
}
