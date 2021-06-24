import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdBanner extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AdBanner();
}

class _AdBanner extends State<AdBanner>{

  BannerAdListener listener;
  BannerAd myBanner;

  @override
  void initState() {
    listener = BannerAdListener(
      onAdLoaded: (Ad ad) => print('Ad loaded.'),
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
        print('Ad failed to load: $error');
      },
      onAdOpened: (Ad ad) => print('Ad opened.'),
      onAdClosed: (Ad ad) => print('Ad closed.'),
      onAdImpression: (Ad ad) => print('Ad impression.'),
    );

    myBanner = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/8865242552',
      size: AdSize.banner,
      request: AdRequest(),
      listener: listener,
    )..load();
    super.initState();
  }

  @override
  void dispose() {
    myBanner.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: AdWidget(ad: myBanner),
      height: myBanner.size.height.toDouble() * 1.45,
    );
  }
}