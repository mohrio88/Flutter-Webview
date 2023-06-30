

import 'dart:io';

import 'package:aitools/WebViewPage.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  BannerAd? _bannerAd;

  static final bannerListener = BannerAdListener(
    onAdLoaded: (ad) => print('aaaa ===> Ad loaded'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
    },
    onAdOpened: (ad) => debugPrint('aaaa ===> Ad opened')
  );

  @override
  void initState() {
    super.initState();
    _createBannerAd();
  }

  void _createBannerAd(){
    _bannerAd = BannerAd(
        size: AdSize.fullBanner,
        //adUnitId: "ca-app-pub-9490809633066321/8732629154",
        adUnitId: "$bannerAdUnitId",
        listener: bannerListener,
        request: const AdRequest()
    )..load();
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

  void openWebPage(BuildContext context, String url, String title){
    Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewPage(url, title)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('AI tools'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap:(){
                    openWebPage(context, 'https://www.google.com/', 'Button - 1');
                  },
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // posion the everything to the bottom
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // place here your image
                          Image.asset('assets/image/default_img.png', width: 50, height: 50,),
                          SizedBox(height: 5,),
                          Text("Button - 1", style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 50,),
                GestureDetector(
                  onTap:(){
                    openWebPage(context, 'https://www.google.com/', 'Button - 2');
                  },
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // posion the everything to the bottom
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // place here your image
                          Image.asset('assets/image/default_img.png', width: 50, height: 50,),
                          SizedBox(height: 5,),
                          Text("Button - 2", style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap:(){
                    openWebPage(context, 'https://www.google.com/', 'Button - 3');
                  },
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // posion the everything to the bottom
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // place here your image
                          Image.asset('assets/image/default_img.png', width: 50, height: 50,),
                          SizedBox(height: 5,),
                          Text("Button - 3", style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 50,),
                GestureDetector(
                  onTap:(){
                    openWebPage(context, 'https://www.google.com/', 'Button - 4');
                  },
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // posion the everything to the bottom
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // place here your image
                          Image.asset('assets/image/default_img.png', width: 50, height: 50,),
                          SizedBox(height: 5,),
                          Text("Button - 4", style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap:(){
                    openWebPage(context, 'https://www.google.com/', 'Button - 5');
                  },
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // posion the everything to the bottom
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // place here your image
                          Image.asset('assets/image/default_img.png', width: 50, height: 50,),
                          SizedBox(height: 5,),
                          Text("Button - 5", style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 50,),
                GestureDetector(
                  onTap:(){
                    openWebPage(context, 'https://www.google.com/', 'Button - 6');
                  },
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // posion the everything to the bottom
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // place here your image
                          Image.asset('assets/image/default_img.png', width: 50, height: 50,),
                          SizedBox(height: 5,),
                          Text("Button - 6", style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap:(){
                    openWebPage(context, 'https://www.google.com/', 'Button - 7');
                  },
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // posion the everything to the bottom
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // place here your image
                          Image.asset('assets/image/default_img.png', width: 50, height: 50,),
                          SizedBox(height: 5,),
                          Text("Button - 7", style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 50,),
                GestureDetector(
                  onTap:(){
                    openWebPage(context, 'https://www.google.com/', 'Button - 8');
                  },
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // posion the everything to the bottom
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // place here your image
                          Image.asset('assets/image/default_img.png', width: 50, height: 50,),
                          SizedBox(height: 5,),
                          Text("Button - 8", style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      bottomNavigationBar:  _bannerAd == null
          ? Container(
        child: Text('No Ads', style: TextStyle(color: Colors.black, fontSize: 20),),)
          : Container(
        //alignment: Alignment.center,
        height: 52,
        child: AdWidget(
          ad: _bannerAd!,),
      ),
    );
  }
}


