import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../Data/privateKey.dart';

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
  adUnitId: PrivateKey.adUnitId1,
  size: AdSize.banner,
  request: AdRequest(),
  listener: BannerAdListener(),
);

BannerAd adBanner2 = BannerAd(
  adUnitId: PrivateKey.adUnitId2,
  size: AdSize.banner,
  request: AdRequest(),
  listener: BannerAdListener(),
);

class AdBanner extends StatelessWidget{
  final int bannerLocation;
  AdBanner({@required this.bannerLocation});
  @override
  Widget build(BuildContext context) {
    if(bannerLocation == 1)
      if(adBanner1.responseInfo == null)
        return Container();
      else{
        return Container(
          alignment: Alignment.center,
          child: AdWidget(ad: adBanner1),
          height: adBanner1.size.height.toDouble() * 1.45);
      }
    else
      if(adBanner2.responseInfo == null)
        return Container();
      else{
        return Container(
          alignment: Alignment.center,
          child: AdWidget(ad: adBanner2),
          height: adBanner2.size.height.toDouble() * 1.45);
      }
  }
}