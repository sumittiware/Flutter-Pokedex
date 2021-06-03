import 'package:flutter/material.dart';
import 'package:pokedex/Data/type.dart';
import 'package:pokedex/Models/pokemon.dart';
import 'package:pokedex/Provider/pokemon_provider.dart';
import 'package:pokedex/styles/colors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../../styles/context.dart';

enum DisplayType { home, stats, evoluation }

class PokemonPanel extends StatefulWidget {
  final Pokemon pokemon;

  PokemonPanel(this.pokemon);

  @override
  _PokemonPanelState createState() => _PokemonPanelState();
}

class _PokemonPanelState extends State<PokemonPanel> {
  DisplayType currentDisplay = DisplayType.home;
  _buildHome() {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Text(
          "Weak against",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 8,
        ),
        Wrap(
          children: List.generate(widget.pokemon.weakness.length, (index) {
            return SizedBox(
              height: 50,
              width: 120,
              child: Image.asset(getTagImage(widget.pokemon.weakness[index])),
            );
          }),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 1,
          width: double.infinity - 100,
          color: AppColors.grey,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Abilities",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 8,
        ),
        Wrap(
          children: List.generate(widget.pokemon.abilties.length, (index) {
            return Text(widget.pokemon.abilties[index]);
          }),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 1,
          width: double.infinity - 100,
          color: AppColors.grey,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Breeding",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [Text("Height"), Text(widget.pokemon.height)],
            ),
            Container(
              height: 50,
              width: 2,
              color: AppColors.semiGrey,
            ),
            Column(
              children: [Text("Weight"), Text(widget.pokemon.weight)],
            ),
            Container(
              height: 50,
              width: 2,
              color: AppColors.semiGrey,
            ),
            Column(
              children: [
                Text("Gender"),
                Text("${widget.pokemon.malepercentage} male")
              ],
            ),
          ],
        )
      ],
    );
  }

  _buildStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Hp"), linearIndicator(widget.pokemon.hp)],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Attack"), linearIndicator(widget.pokemon.attack)],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Defense"), linearIndicator(widget.pokemon.defense)],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Special Attack"),
            linearIndicator(widget.pokemon.specialAttack)
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Special Defense"),
            linearIndicator(widget.pokemon.specialDefense),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Speed"),
            linearIndicator(widget.pokemon.speed),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Total  ${widget.pokemon.total}",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  _buildEvoluations() {
    if (widget.pokemon.evolutions.length < 2) {
      return Center(
        child: Text("Pokemon dosen't evolve!!"),
      );
    } else {
      List<Pokemon> evloutions = [];
      widget.pokemon.evolutions.forEach((element) {
        var pokemon = Provider.of<PokemonProvider>(context, listen: false)
            .getById(element);
        evloutions.add(pokemon);
      });
      return Column(
        children: List.generate(evloutions.length - 1, (index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Image(
                    height: 70,
                    width: 70,
                    image: NetworkImage(evloutions[index].imageUrl),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(evloutions[index].name)
                ],
              ),
              Container(
                height: 3,
                width: 60,
                color: AppColors.grey,
              ),
              Column(
                children: [
                  Image(
                    height: 70,
                    width: 70,
                    image: NetworkImage(evloutions[index + 1].imageUrl),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(evloutions[index + 1].name)
                ],
              ),
            ],
          );
        }),
      );
    }
  }

  LinearPercentIndicator linearIndicator(int value) {
    return LinearPercentIndicator(
      width: MediaQuery.of(context).size.width - 200,
      animation: true,
      lineHeight: 20.0,
      animationDuration: 800,
      percent: value / 100,
      linearStrokeCap: LinearStrokeCap.roundAll,
      progressColor: getTypeColor(widget.pokemon.type)[1],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 18, left: 18, right: 18),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Type",
              style: TextStyle(fontSize: 16),
            ),
            Wrap(
              children: List.generate(widget.pokemon.type.length, (index) {
                return SizedBox(
                  height: 50,
                  width: 120,
                  child: Image.asset(getTagImage(widget.pokemon.type[index])),
                );
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildMenuButton("General", DisplayType.home),
                _buildMenuButton("Stats", DisplayType.stats),
                _buildMenuButton("Evoluations", DisplayType.evoluation)
              ],
            ),
            if (currentDisplay == DisplayType.home) _buildHome(),
            if (currentDisplay == DisplayType.stats) _buildStats(),
            if (currentDisplay == DisplayType.evoluation)
              Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  _buildEvoluations()
                ],
              )
          ],
        ),
      ),
    );
  }

  SizedBox _buildMenuButton(String title, DisplayType type) {
    return SizedBox(
      height: 40,
      width: 100,
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentDisplay = type;
          });
        },
        child: Container(
          decoration: BoxDecoration(
              color: (currentDisplay == type)
                  ? getTypeColor(widget.pokemon.type)[0]
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                if (currentDisplay == type)
                  BoxShadow(
                    offset: Offset(0, context.responsive(4)),
                    blurRadius: 15,
                    color: getTypeColor(widget.pokemon.type)[1],
                  )
              ]),
          child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                    color:
                        (currentDisplay == type) ? Colors.white : Colors.black),
              )),
        ),
      ),
    );
  }
}
