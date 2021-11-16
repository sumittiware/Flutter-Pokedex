import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pokedex/Data/type.dart';
import 'package:pokedex/Provider/pokemon_provider.dart';
import 'package:pokedex/ad_helper.dart';
import 'package:pokedex/styles/typegradient.dart';
import 'package:pokedex/views/PokemonDetails/WIdgets/PokemonPanel.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PokeInfo extends StatefulWidget {
  final bool isSearched;
  PokeInfo({this.isSearched = false});
  @override
  _PokeInfoState createState() => _PokeInfoState();
}

class _PokeInfoState extends State<PokeInfo> {
  FlutterTts flutterTts = FlutterTts();
  bool _showImage = true;
  bool _speaking = false;
  var _controller = PanelController();
  PokemonProvider pokemon;
  PageController _pagecontroller;

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
  }

  String getDetail() {
    return (widget.isSearched)
        ? "${pokemon.searchedPokemon[pokemon.currentIndex].name}, a ${pokemon.searchedPokemon[pokemon.currentIndex].type[0]} pokemon, ${pokemon.searchedPokemon[pokemon.currentIndex].description}"
        : "${pokemon.generationPokemon[pokemon.currentIndex].name}, a ${pokemon.generationPokemon[pokemon.currentIndex].type[0]} pokemon, ${pokemon.generationPokemon[pokemon.currentIndex].description}";
  }

  Future _speak() async {
    setState(() {
      _speaking = true;
    });
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(getDetail());
    setState(() {
      _speaking = false;
    });
  }

  Future _stop() async {
    final result = await flutterTts.stop();
    if (result == 1) {
      setState(() {
        _speaking = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    setState(() {
      _speaking = false;
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    flutterTts.stop();
    _pagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final devicePadding = MediaQuery.of(context).padding;
    pokemon = Provider.of<PokemonProvider>(context);
    final currentPokemon = (!widget.isSearched)
        ? pokemon.generationPokemon[pokemon.currentIndex]
        : pokemon.searchedPokemon[pokemon.currentIndex];
    _pagecontroller = PageController(
        initialPage: pokemon.currentIndex, viewportFraction: 0.6);
    return Scaffold(
      body: Stack(
        // alignment: Alignment.center,
        children: [
          Container(
            height: deviceSize.height,
            width: deviceSize.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: getTypeColor(currentPokemon.type) ??
                        CustomColors.fire)),
          ),
          SlidingUpPanel(
              controller: _controller,
              onPanelOpened: () {
                setState(() {
                  _showImage = false;
                });
              },
              onPanelSlide: (_) {
                setState(() {
                  _showImage = false;
                });
              },
              onPanelClosed: () {
                setState(() {
                  _showImage = true;
                });
              },
              padding: EdgeInsets.only(top: 18, left: 18, right: 18),
              maxHeight: deviceSize.height * 0.9,
              minHeight: deviceSize.height * 0.65,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              panel: PokemonPanel(currentPokemon)),
          if (_showImage)
            Positioned(
              bottom: deviceSize.height * 0.6,
              child: SizedBox(
                height: deviceSize.height * 0.3,
                width: deviceSize.width,
                child: PageView(
                  physics: BouncingScrollPhysics(),
                  controller: _pagecontroller,
                  children: List.generate(
                      (!widget.isSearched)
                          ? pokemon.generationPokemon.length
                          : pokemon.searchedPokemon.length, (index) {
                    final selected = pokemon.currentIndex == index;
                    return AnimatedPadding(
                      duration: Duration(milliseconds: 600),
                      curve: Curves.easeOutQuint,
                      padding: EdgeInsets.only(
                        top: selected ? 0 : deviceSize.height * 0.06,
                        bottom: selected ? 0 : deviceSize.height * 0.06,
                      ),
                      child: Image(
                        image: CachedNetworkImageProvider((widget.isSearched)
                            ? pokemon.searchedPokemon[index].imageUrl
                            : pokemon.generationPokemon[index].imageUrl),
                        color: selected ? null : Colors.black26,
                      ),
                    );
                  }),
                  onPageChanged: (index) {
                    pokemon.setCurrentIndex(index);
                    flutterTts.stop();
                  },
                ),
              ),
            ),
          Positioned(
            top: 0 + devicePadding.top,
            child: SizedBox(
              width: deviceSize.width,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new_rounded)),
                  SizedBox(
                    width: deviceSize.width * 0.3,
                  ),
                  Text(
                    currentPokemon.name,
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: (_isBannerAdReady)
          ? Container(
              height: _bannerAd.size.height.toDouble(),
              width: _bannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bannerAd),
            )
          : Container(
              height: 0.1,
              color: Colors.transparent,
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: getTypeColor(currentPokemon.type)[0],
        child: Icon(
            (_speaking) ? Icons.volume_off_rounded : Icons.volume_up_rounded),
        onPressed: (_speaking) ? () => _stop() : () => _speak(),
      ),
    );
  }
}
