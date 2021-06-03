import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/Provider/pokemon_provider.dart';
import 'package:pokedex/styles/colors.dart';
import 'package:pokedex/views/home/homescreen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isError = false;
  bool isLoading = true;
  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    Provider.of<PokemonProvider>(context, listen: false)
        .fetchPokemons()
        .then((_) {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }));
    }).catchError((e) {
      setState(() {
        isError = true;
        isLoading = false;
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Material(
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(14)),
                    height: 350,
                    width: 300,
                    padding: EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image(
                          image: AssetImage('assets/images/error.png'),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        Text(
                            "Something went wrong! Please Check your Internet Connection."),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              SystemNavigator.pop();
                            },
                            child: Text("Okay!!"))
                      ],
                    ),
                  ),
                ),
              );
            });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.whiteGrey,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image(
            image: AssetImage('assets/splash/sky.png'),
            height: deviceSize.height,
            width: deviceSize.width,
            fit: BoxFit.cover,
          ),
          Positioned(
              bottom: 0,
              child: Image(
                  image: AssetImage('assets/splash/grass.png'),
                  height: 400,
                  width: deviceSize.width,
                  fit: BoxFit.cover)),
          Positioned(
            bottom: 100,
            child: Image(
              image: AssetImage('assets/images/pika_loader.gif'),
              width: 200,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              top: deviceSize.height * 0.2,
              child: Column(
                children: [
                  Image(
                    image: AssetImage('assets/splash/pokedex.png'),
                    height: 90,
                    width: 90,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    "All Generation Pokedex",
                    style: TextStyle(
                        color: AppColors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
