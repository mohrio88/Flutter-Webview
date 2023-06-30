import 'dart:async';
import 'dart:io';

import 'package:aitools/Common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {

  String webUrl;
  String title;

  WebViewPage(this.webUrl, this.title);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

const int maxFailedLoadAttempts = 3;
class _WebViewPageState extends State<WebViewPage> {

  var controller = WebViewController();
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  int _rewardedScore = 0;
  bool isDispose = false;
  int _numInterstitialLoadAttempts = 0;


  static final bannerListener = BannerAdListener(
      onAdFailedToLoad: (ad, error) {
        ad.dispose();
      },
      onAdOpened: (ad) => debugPrint('aaaa ===> Ad opened')
  );

  @override
  void initState() {
    super.initState();

    callWebView();

    _createBannerAd();
    _createInterstitialAd();

    scheduleTimeout();
  }

  void callWebView(){

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.webUrl));

  }

  @override
  void dispose() {
    isDispose = true;
    super.dispose();
  }

  Timer scheduleTimeout() => Timer(Duration(seconds: 300), handleTimeout);

  void handleTimeout() {  // callback function
    if (!isDispose){
      scheduleTimeout();
    }
    _showInterstitialAd();
  }


  void _createBannerAd(){
    _bannerAd = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: "$bannerAdUnitId",
        listener: bannerListener,
        request: const AdRequest()
    )..load();
  }

  void _createInterstitialAd(){
    InterstitialAd.load(
        adUnitId: "$interstitialAdUnitId",
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad) {
              _interstitialAd = ad;
              _numInterstitialLoadAttempts = 0;
              _interstitialAd!.setImmersiveMode(true);
            },
            onAdFailedToLoad: (LoadAdError error) {
              _numInterstitialLoadAttempts += 1;
              _interstitialAd = null;
              if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
                _createInterstitialAd();
              }
            },
        ),
    );
  }

  static String? get bannerAdUnitId{

    if(Platform.isAndroid){
      return "ca-app-pub-9490809633066321/8732629154";
    }
    else if(Platform.isIOS){
      return "ca-app-pub-9490809633066321/2263423726";
    }
    return null;
  }

  static String? get interstitialAdUnitId{

    if(Platform.isAndroid){
      return "ca-app-pub-9490809633066321/7515750401";
    }
    else if(Platform.isIOS){
      return "ca-app-pub-9490809633066321/9399414386";
    }
    return null;
  }


  void _showInterstitialAd(){

    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error){
        ad.dispose();
        _createInterstitialAd();
      },
      onAdShowedFullScreenContent: (InterstitialAd ad) => print('bbbb ===>  onAdShowedFullScreenContent.'),
    );

    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void _createRewardedAd(){

    RewardedAd.load(
        adUnitId: "$interstitialAdUnitId",
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (ad) => setState(() => _rewardedAd = ad),
            onAdFailedToLoad: (error) => setState(() => _rewardedAd = null),
        ),
    );
  }

  void _showRewardedAd(){

    if(_rewardedAd != null){
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad){
          ad.dispose();
          _createRewardedAd();
        },

        onAdFailedToShowFullScreenContent: (ad, error){
          ad.dispose();
          _createRewardedAd();
        }
      );

      _rewardedAd!.show(
          onUserEarnedReward: (ad, reward) => setState(() => _rewardedScore++)
      );

      _rewardedAd = null;

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text(widget.title),
        leading: BackButton(
          onPressed: (){
            controller.goBack();
          },
        ),
        actions: <Widget>[
          IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ))
        ],
      ),
      body: WebViewWidget(controller: controller),

      bottomNavigationBar:  _bannerAd == null
          ? Container(
        child: Text('No Ads', style: TextStyle(color: Colors.black, fontSize: 20),),)
          : Container(
        alignment: Alignment.center,
        height: 52,
        child: AdWidget(
          ad: _bannerAd!,),
      ),
    );
  }
}
