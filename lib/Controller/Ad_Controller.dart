import 'dart:io';
import 'package:get/get.dart';

class Ad_Controller extends GetxController {
  static String HomepageBanner() {
    if (Platform.isAndroid) {
      return "ca-app-pub-9503114916918866/4334126947";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9503114916918866/6388664394";
    } else {
      return "";
    }
  }

  static String DetailspageBanner() {
    if (Platform.isAndroid) {
      return "ca-app-pub-9503114916918866/2617720596";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9503114916918866/8309649521";
    } else {
      return "";
    }
  }

  static String FullpageBanner() {
    if (Platform.isAndroid) {
      return "ca-app-pub-9503114916918866/7255803758";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9503114916918866/6996567853";
    } else {
      return "";
    }
  }

  static String AppOpenBanner() {
    if (Platform.isAndroid) {
      return "ca-app-pub-9503114916918866/9397972081";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9503114916918866/6996567853";
    } else {
      return "";
    }
  }
}
