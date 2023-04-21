import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sizer/sizer.dart';
import 'package:wp_direct/Controller/Ad_Controller.dart';
import 'package:wp_direct/widgets.dart';
import 'image_gride.dart';
import 'vidieo_gride.dart';

class status_dn extends StatefulWidget {
  const status_dn({Key? key}) : super(key: key);

  @override
  State<status_dn> createState() => _status_dnState();
}

class _status_dnState extends State<status_dn> {
  final Down_share _controller = Get.put(Down_share());
  @override
  void initState() {
    _controller.getPermission();
    loadDetailsAD();
    super.initState();
  }

  @override
  void dispose() {
    myDetailsBanner!.dispose();
    super.dispose();
  }

  bool isAdLoad = false;
  BannerAd? myDetailsBanner;
  void loadDetailsAD() {
    myDetailsBanner = BannerAd(
      adUnitId: Ad_Controller.DetailspageBanner(),
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(onAdClosed: (ad) {
        ad.dispose();
        setState(() {
          isAdLoad = false;
        });
      }, onAdLoaded: (ad) {
        log("Ad Is Loaded");
        setState(() {
          isAdLoad = true;
        });
      }, onAdFailedToLoad: (ad, er) {
        log(er.toString());
        setState(() {
          isAdLoad = false;
        });
      }),
    );
    myDetailsBanner!.load();

    setState(() {});
  }

  @override
  Widget build(BuildContext text) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            bottomNavigationBar: isAdLoad == true
                ? SizedBox(
                    height: AdSize.banner.height.toDouble(),
                    child: AdWidget(ad: myDetailsBanner!))
                : const SizedBox(),
            appBar: AppBar(
              elevation: 5,
              title: Text("Whatsapp Statuses",
                  style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w500, fontSize: 13.sp)),
              centerTitle: true,
              shape: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              bottom: TabBar(
                automaticIndicatorColorAdjustment: true,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 1.5,
                splashBorderRadius: BorderRadius.circular(10),
                enableFeedback: true,
                indicatorPadding: EdgeInsets.symmetric(horizontal: 17),
                tabs: const [
                  Tab(
                    icon: Icon(Icons.image_outlined),
                  ),
                  Tab(
                    icon: Icon(Icons.video_library_outlined),
                  ),
                ],
              ),
            ),
            body: const SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                children: [image_gride(), Vidieo_gride()],
              ),
            )),
      ),
    );
  }
}
