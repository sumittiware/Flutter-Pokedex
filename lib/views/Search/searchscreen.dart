import 'package:flutter/material.dart';
import 'package:pokedex/Provider/pokemon_provider.dart';
import 'package:pokedex/styles/colors.dart';
import 'package:pokedex/views/AllPokemon/Widgets/pokemoncard.dart';
import 'package:provider/provider.dart';
import '../../styles/context.dart';

class ScearchScreen extends StatefulWidget {
  @override
  _ScearchScreenState createState() => _ScearchScreenState();
}

class _ScearchScreenState extends State<ScearchScreen> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final pokemon = Provider.of<PokemonProvider>(context);
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
            title: TextField(
              controller: _controller,
              onSubmitted: (_) {
                pokemon.searchPokemon(_controller.text.trim());
              },
              onChanged: (_) {
                pokemon.searchPokemon(_controller.text.trim());
              },
              decoration: InputDecoration(
                  hintText: "Search Pokemon",
                  suffixIcon: IconButton(
                      onPressed: () {
                        _controller.clear();
                      },
                      icon: Icon(
                        Icons.highlight_remove_rounded,
                        color: Colors.black,
                      ))),
            )),
        body: (pokemon.isSearched)
            ? ((pokemon.searchedPokemon.length != 0)
                ? GridView(
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
                      pokemon.searchedPokemon.length,
                      (index) => PokemonCard(
                        pokemon.searchedPokemon[index],
                        index,
                        isfromSearch: true,
                      ),
                    ),
                  )
                : Center(
                    child: Text("No Match Found"),
                  ))
            : Container());
  }
}
