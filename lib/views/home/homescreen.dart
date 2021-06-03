import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pokedex/Data/generations.dart';
import 'package:pokedex/Models/generation.dart';
import 'package:pokedex/styles/colors.dart';
import 'package:pokedex/styles/typegradient.dart';
import 'package:pokedex/views/Search/searchscreen.dart';
import 'package:pokedex/views/home/extras.dart';
import 'package:pokedex/views/home/widgets/generationcard.dart';
import '../../styles/context.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  _bottomSheet(BuildContext context) {
    scaffoldState.currentState.showBottomSheet((context) {
      return Container(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          height: 200,
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.star,
                  color: AppColors.red,
                ),
                title: Text("Rate app"),
                onTap: rateUs,
              ),
              ListTile(
                leading: Icon(
                  Icons.share_rounded,
                  color: AppColors.red,
                ),
                title: Text("Share app"),
                onTap: share,
              ),
              ListTile(
                leading: Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.red,
                ),
                title: Text("About Me"),
                onTap: aboutMe,
              ),
            ],
          ));
    },
        elevation: 5,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldState,
      body: Column(
        children: [
          Container(
            height: kToolbarHeight + 40,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: CustomColors.fight,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
            child: Column(
              children: [
                SizedBox(
                  height: kToolbarHeight - 40,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 80,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              _bottomSheet(context);
                            },
                            icon: Icon(
                              Icons.menu_rounded,
                              color: Colors.white,
                            )),
                        Text(
                          "Pokedex",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return ScearchScreen();
                              }));
                            },
                            icon: Icon(
                              Icons.search_rounded,
                              color: Colors.white,
                            ))
                      ],
                    )),
              ],
            ),
          ),
          _buildGenerations(context, deviceSize)
        ],
      ),
    );
  }

  Widget _buildGenerations(BuildContext context, Size size) {
    return Expanded(
        child: ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: context.responsive(20),
        bottom: context.responsive(20) + context.padding.bottom,
      ),
      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: 2,
      //   childAspectRatio: 1.55,
      //   crossAxisSpacing: 10,
      //   mainAxisSpacing: context.responsive(10),
      // ),
      children: List.generate(
        generations.length,
        (index) => _buildGenerationCard(generations[index], size),
      ),
    ));
  }

  Widget _buildGenerationCard(Generation generation, Size size) {
    return Container(
        padding: EdgeInsets.all(8),
        height: size.height * 0.15,
        child: GenerationCard(generation));
  }
}
