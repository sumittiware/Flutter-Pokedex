import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:pokedex/Models/generation.dart';
import 'package:pokedex/Models/pokemon.dart';
import 'package:http/http.dart' as http;

class PokemonProvider with ChangeNotifier {
  List<Pokemon> _pokemons = [];
  List<Pokemon> _generationPokemon = [];
  List<Pokemon> _searchedPokemons = [];
  bool _isSearched = false;

  List<Pokemon> get pokemons {
    return [..._pokemons];
  }

  List<Pokemon> get generationPokemon {
    return [..._generationPokemon];
  }

  List<Pokemon> get searchedPokemon {
    return [..._searchedPokemons];
  }

  bool get isSearched {
    return _isSearched;
  }

  int _currentIndex;

  int get currentIndex {
    return _currentIndex;
  }

  setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<void> fetchPokemons() async {
    try {
      final url = Uri.parse(
          'https://pokemon-backend-76ba7-default-rtdb.firebaseio.com/Pokemon.json/');
      final response = await http.get(url);
      final result = json.decode(response.body);
      List<Pokemon> loadedPokemon = [];
      if (result != null) {
        try {
          for (int i = 1; i < result.length; i++) {
            var pokemon = result[i];
            loadedPokemon.add(Pokemon(
                id: pokemon['id'] ?? "",
                name: pokemon['name'] ?? "Unknown",
                description: pokemon['xdescription'] ?? "No data avaliable",
                imageUrl: pokemon['imageurl'] ?? "",
                category: pokemon['category'] ?? "unknown",
                abilties: pokemon['abilities'] ?? [],
                eggroup: pokemon['egg_groups'] ?? "unknown",
                evolutions: pokemon['evolutions'] ?? [],
                attack: pokemon['attack'] ?? [],
                baseXp: pokemon['base_exp'] ?? "unknown",
                cycles: pokemon['cycles'] ?? "unknown",
                defense: pokemon['defense'] ?? 0,
                height: pokemon['height'] ?? 0,
                hp: pokemon['hp'] ?? 0,
                malepercentage: pokemon['male_percentage'] ?? "unknown",
                type: pokemon['typeofpokemon'] ?? [],
                weakness: pokemon['weaknesses'] ?? [],
                weight: pokemon['weight'] ?? "unknown",
                specialAttack: pokemon['special_attack'] ?? 0,
                specialDefense: pokemon['special_defense'] ?? 0,
                speed: pokemon['speed'] ?? 0,
                total: pokemon['total'] ?? 0));
          }
        } catch (e) {
          throw result['error'];
        }
        _pokemons = loadedPokemon;
        notifyListeners();
      } else {
        throw result['messege'];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  getById(String id) {
    return _pokemons.firstWhere((element) => element.id == id);
  }

  pokemonByGeneration(Generation generation) {
    _generationPokemon.clear();
    for (int i = generation.initialIndex; i < generation.finalIndex; i++) {
      _generationPokemon.add(pokemons[i]);
    }
    notifyListeners();
    return [..._generationPokemon];
  }

  searchPokemon(String name) {
    _searchedPokemons.clear();
    _pokemons.forEach((element) {
      if (element.name.toLowerCase() == name.toLowerCase() ||
          element.name.toLowerCase().startsWith(name.toLowerCase())) {
        _searchedPokemons.add(element);
      }
    });
    _isSearched = true;
    notifyListeners();
  }
}
