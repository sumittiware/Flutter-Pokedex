import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pokedex/Data/generations.dart';
import 'package:pokedex/Models/generation.dart';
import 'package:pokedex/ad_helper.dart';
import 'package:pokedex/styles/typegradient.dart';
import 'package:pokedex/views/Search/searchscreen.dart';
import 'package:pokedex/views/home/extras.dart';
import 'package:pokedex/views/home/widgets/generationcard.dart';
import '../../styles/context.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final scaffoldState = GlobalKey<ScaffoldState>();
  AnimationController _animationController;
  bool _drawrOpen = false;
  BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  bool _addFailed = false;

  _addInit() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print("Unable to display ad : ${err.message}");
          _isBannerAdReady = false;
          _addFailed = true;
          setState(() {});
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
  }

  @override
  void initState() {
    super.initState();
    _addInit();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldState,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: kToolbarHeight + 40,
              ),
              Expanded(
                  child: ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: context.responsive(20),
                  bottom: context.responsive(20) + context.padding.bottom,
                ),
                children: [
                  _buildGenerationCard(generations[0], size),
                  _buildGenerationCard(generations[1], size),
                  _buildGenerationCard(generations[2], size),
                  (_isBannerAdReady) ? _buildAdCard(size) : Container(),
                  _buildGenerationCard(generations[3], size),
                  _buildGenerationCard(generations[4], size),
                  _buildGenerationCard(generations[5], size),
                  (_isBannerAdReady) ? _buildAdCard(size) : Container(),
                  _buildGenerationCard(generations[6], size),
                  _buildGenerationCard(generations[7], size),
                ],
              ))
            ],
          ),
          // Appbar
          AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
              height: kToolbarHeight + ((!_drawrOpen) ? 40 : 240),
              padding: EdgeInsets.only(
                  top: kToolbarHeight - 20, left: 16, right: 16),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: CustomColors.fight,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _drawrOpen = !_drawrOpen;
                              _drawrOpen
                                  ? _animationController.forward()
                                  : _animationController.reverse();
                            });
                            // _bottomSheet(context);
                          },
                          icon: AnimatedIcon(
                            icon: AnimatedIcons.menu_close,
                            progress: _animationController,
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
                  ),
                  if (_drawrOpen)
                    Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.star,
                            color: Colors.white,
                          ),
                          title: Text(
                            "Rate app",
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: rateUs,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.share_rounded,
                            color: Colors.white,
                          ),
                          title: Text(
                            "Share app",
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: share,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.info_outline_rounded,
                            color: Colors.white,
                          ),
                          title: Text(
                            "About Me",
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: aboutMe,
                        ),
                      ],
                    )
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildGenerationCard(Generation generation, Size size) {
    return Container(
        padding: EdgeInsets.all(8),
        height: size.height * 0.15,
        child: GenerationCard(generation));
  }

  Widget _buildAdCard(Size size) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: _bannerAd.size.width.toDouble(),
        height: _bannerAd.size.height.toDouble(),
        child: AdWidget(ad: _bannerAd),
      ),
    );
  }
}
