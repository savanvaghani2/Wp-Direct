// import 'dart:html';

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:wp_direct/Controller/Ad_Controller.dart';
import 'package:wp_direct/status_download.dart';
import 'package:wp_direct/widgets.dart';

class directMsg_Screen extends StatefulWidget {
  const directMsg_Screen({Key? key}) : super(key: key);

  @override
  State<directMsg_Screen> createState() => _directMsg_ScreenState();
}

class _directMsg_ScreenState extends State<directMsg_Screen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController number = TextEditingController();

  final Down_share _controller = Get.put(Down_share());
  _whatsApp() async {
    final url = 'https://wa.me/+91${number.text}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    number.clear();
    loadHomeAD();
    super.initState();
  }

  Dio dio = Dio();

  bool isAdLoad = false;
  BannerAd? myHomeAd;
  void loadHomeAD() {
    myHomeAd = BannerAd(
      adUnitId: Ad_Controller.HomepageBanner(),
      size: AdSize.banner,
      request: const AdRequest(),
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
    myHomeAd!.load();
  }

  // bool isOpenAdLoad = false;
  // BannerAd? myOpenHomeAd;
  // void loadOpenAD() {
  //   myOpenHomeAd = BannerAd(
  //     adUnitId: Ad_Controller.AppOpenBanner(),
  //     size: AdSize.fullBanner,
  //     request: AdRequest(),
  //     listener: BannerAdListener(onAdClosed: (ad) {
  //       ad.dispose();
  //       setState(() {
  //         isOpenAdLoad = false;
  //       });
  //     }, onAdLoaded: (ad) {
  //       log("Ad Is Loaded");
  //       setState(() {
  //         isOpenAdLoad = true;
  //       });
  //     }, onAdFailedToLoad: (ad, er) {
  //       log(er.toString());
  //       setState(() {
  //         isOpenAdLoad = false;
  //       });
  //     }),
  //   );
  //   myOpenHomeAd!.load();
  // }

  @override
  void dispose() {
    number.dispose();
    myHomeAd!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: isAdLoad
                ? MediaQuery.of(context).size.height / 1.1
                : MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    opacity: .4,
                    image: AssetImage("assets/wpbg.jpg"),
                    fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.h, left: 5.w),
                  child: Text(
                    "Welcome To Whatsapp Direct",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.h, left: 5.w),
                  child: SizedBox(
                      width: 80.w,
                      child: Text(
                        "We can help you for saving time and less number of contacts",
                        style: GoogleFonts.rubik(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(.8)),
                      )),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        const Icon(Icons.add_ic_call_rounded, size: 28),
                        SizedBox(
                          width: 4.w,
                        ),
                        Form(
                          key: _formKey,
                          child: SizedBox(
                            width: 75.w,
                            child: TextFormField(
                              validator: (v) {
                                if (v == null || v.isEmpty || v.length != 10) {
                                  return "Please Enter Valid Number";
                                } else {
                                  return null;
                                }
                              },
                              maxLength: 10,
                              controller: number,
                              onFieldSubmitted: (v) {
                                if (_formKey.currentState!.validate()) {
                                  _whatsApp();
                                } else {
                                  null;
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: "Ex: 9158200054",
                              ),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp,
                                  letterSpacing: 1),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: MaterialButton(
                      color: Colors.greenAccent.withOpacity(.5),
                      minWidth: 90.w,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _whatsApp();
                        } else {
                          null;
                        }
                      },
                      child: Text(
                        "Send a Messages",
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w500, wordSpacing: 2),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: "Not interested ! ",
                            style: GoogleFonts.rubik(
                                color: Colors.white.withOpacity(.8),
                                fontWeight: FontWeight.w400))),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      child: MaterialButton(
                          color: Colors.greenAccent.withOpacity(.5),
                          // minWidth: 90.w,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () async {
                            final playStoreUrl = Uri.parse(
                                "https://play.google.com/store/apps/details?id=com.whatsapp");
                            if (_controller.getfile() == true) {
                              Get.to(() => const status_dn(),
                                  duration: const Duration(milliseconds: 700));
                            } else {
                              if (await canLaunchUrl(playStoreUrl)) {
                                await launchUrl(playStoreUrl,
                                    mode: LaunchMode
                                        .externalNonBrowserApplication);
                              } else {
                                throw "Couldn't launch the Play Store.";
                              }
                            }
                          },
                          child: Row(
                            children: [
                              Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40)),
                                child: Image.asset(
                                  "assets/play_store_512.png",
                                  height: 4.h,
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                "Download Statuses",
                                style: GoogleFonts.rubik(
                                    fontWeight: FontWeight.w500,
                                    wordSpacing: 2),
                              ),
                            ],
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: isAdLoad == true
          ? SizedBox(
              height: AdSize.banner.height.toDouble(),
              child: AdWidget(ad: myHomeAd!))
          : const SizedBox(),
    );
  }
}
