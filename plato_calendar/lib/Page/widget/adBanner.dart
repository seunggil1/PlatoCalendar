import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


// 빌드전 android\app\src\main\AndroidManifest.xml에서
// com.google.android.gms.ads.APPLICATION_ID 값 변경

BannerAdListener listener = BannerAdListener(
  onAdLoaded: (Ad ad) => print('Ad loaded.'),
  onAdFailedToLoad: (Ad ad, LoadAdError error) {
    ad.dispose();
    print('Ad failed to load: $error');
  },
  onAdOpened: (Ad ad) => print('Ad opened.'),
  onAdClosed: (Ad ad) => print('Ad closed.'),
  onAdImpression: (Ad ad) => print('Ad impression.'),
);
BannerAd adBanner1 = BannerAd(
  adUnitId: 'ca-app-pub-9612248828148882/3280746521',
  size: AdSize.banner,
  request: AdRequest(),
  listener: listener,
)..load();

BannerAd adBanner2 = BannerAd(
  adUnitId: 'ca-app-pub-9612248828148882/8029799884',
  size: AdSize.banner,
  request: AdRequest(),
  listener: listener,
)..load();

class AdBanner extends StatelessWidget{
  final int bannerLocation;
  AdBanner({@required this.bannerLocation});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: bannerLocation == 1 ? AdWidget(ad: adBanner1) : AdWidget(ad: adBanner2),
      height: adBanner1.size.height.toDouble() * 1.45,
    );
  }
}