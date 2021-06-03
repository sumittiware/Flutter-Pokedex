import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/Provider/pokemon_provider.dart';
import 'package:pokedex/styles/colors.dart';
import 'package:pokedex/styles/fonts.dart';
import 'package:pokedex/views/home/homescreen.dart';
import 'package:pokedex/views/splashscreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: PokemonProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokedex',
        theme: ThemeData(
          fontFamily: AppFonts.circularStd,
          textTheme: theme.textTheme.apply(
            fontFamily: AppFonts.circularStd,
            displayColor: AppColors.black,
          ),
          scaffoldBackgroundColor: AppColors.lightGrey,
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
