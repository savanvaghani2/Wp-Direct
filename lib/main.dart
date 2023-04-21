import 'dart:async';
import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:wp_direct/internet_check.dart';
import 'package:wp_direct/directMsg_Screen.dart';

import 'Controller/Ad_Controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool? permissionGranted;
  StreamSubscription? subscription;
  Ad_Controller ad_controller = Ad_Controller();

  @override
  dispose() {
    super.dispose();
    subscription!.cancel();
  }

  Future _getStoragePermission(BuildContext context) async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
      String version = androidInfo.version.release;
      String v = version.split('.').first;
      int vs = int.parse(v);
      if (vs >= 11) {
        await Permission.manageExternalStorage.request();
        print(
            "Check == ${await Permission.manageExternalStorage.request().isGranted}");
        if (await Permission.manageExternalStorage.request().isGranted) {
          setState(() {
            permissionGranted = true;
          });
        } else if (await Permission.manageExternalStorage
            .request()
            .isPermanentlyDenied) {
          await openAppSettings();
        } else if (await Permission.manageExternalStorage.request().isDenied) {
          setState(() {
            permissionGranted = false;
          });
        }
      } else if (vs < 11) {
        var status = await Permission.storage.status;
        if (status != PermissionStatus.granted) {
          status = await Permission.storage.request();
        }
        if (status == PermissionStatus.denied) {
          // ignore: use_build_context_synchronously
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Permission required'),
              content: const Text(
                  'This app needs to access storage to save images.'),
              actions: [
                MaterialButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Text('Cancel'),
                ),
                const MaterialButton(
                  onPressed: openAppSettings,
                  child: Text('Settings'),
                ),
              ],
            ),
          );
        }
      }
    }
  }

  @override
  void initState() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.bluetooth:
          Get.back();
          break;
        case ConnectivityResult.wifi:
          Get.back();
          break;
        case ConnectivityResult.ethernet:
          Get.back();
          break;
        case ConnectivityResult.mobile:
          Get.back();
          break;
        case ConnectivityResult.none:
          Get.to(() => Internet_Check());
          break;
        case ConnectivityResult.vpn:
          Get.back();
          break;
        case ConnectivityResult.other:
          Get.back();
          break;
      }
    });

    _getStoragePermission(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: "Rubik", useMaterial3: true),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.dark,
          home: AnimatedSplashScreen.withScreenFunction(
            centered: true,
            curve: Curves.easeIn,
            splashIconSize: 200,
            splashTransition: SplashTransition.fadeTransition,
            splash: 'assets/play_store_512.png',
            duration: 2,
            screenFunction: () async {
              return const directMsg_Screen();
            },
          ));
    });
  }
}
