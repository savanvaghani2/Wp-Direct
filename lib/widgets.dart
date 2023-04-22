import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

class Down_share extends GetxController {
  String? dir;
  RxList imageList = [].obs;
  RxList vidieoList = [].obs;
  Future shareImage(paths) async {
    XFile d = XFile(paths);
    await Share.shareXFiles([d], text: "Image Shared From Wp-Direct");
  }

  Future getPermission() async {
    await Permission.manageExternalStorage.request();
    if (await Permission.manageExternalStorage.isGranted) {}
  }

  Future get_Dir() async {
    dir = Directory('/storage/emulated/0/Wp-Direct').path;
    if (!(await Directory('/storage/emulated/0/Wp-Direct').exists())) {
      Directory('/storage/emulated/0/Wp-Direct').create(recursive: false);
      Directory('/storage/emulated/0/Wp-Direct/Images')
          .create(recursive: false);
      Directory('/storage/emulated/0/Wp-Direct/Videos')
          .create(recursive: false);
    }
  }

  Future downloadimage(File? file) async {
    final fileExp = File(
        "/storage/emulated/0/Wp-Direct/images/${file?.path.toString().split('/').last}");
    await GallerySaver.saveImage(file!.path);

    await fileExp
        .writeAsBytes(File(file.path).readAsBytesSync(), mode: FileMode.write)
        .whenComplete(() => Fluttertoast.showToast(
            msg: "Downloaded Successfully",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black.withOpacity(.7),
            textColor: Colors.white,
            fontSize: 12.sp));
  }

  Future downloadvideo(String? file) async {
    final f =
        File("/storage/emulated/0/Wp-Direct/Videos/${file?.split('/').last}");
    await f
        .writeAsBytes((File(file.toString()).readAsBytesSync()),
            mode: FileMode.write)
        .whenComplete(() => Fluttertoast.showToast(
            msg: "Downloaded Successfully",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black.withOpacity(.7),
            textColor: Colors.white,
            fontSize: 12.sp));
  }

  Future shareVidieo(paths) async {
    XFile d = XFile(paths);
    await Share.shareXFiles([d], text: "Video Shared From Wp-Direct");
  }

  bool getfile() {
    try {
      final Directory photoDir = Directory(
          '/storage/emulated/0/Android/media/com.whatsapp/Whatsapp/Media/.Statuses/');
      vidieoList.value = photoDir
          .listSync()
          .map((item) => item.path)
          .where((item) => item.endsWith(".mp4"))
          .toList(growable: false);
      imageList.value = photoDir
          .listSync()
          .map((item) => item.path)
          .where((item) => item.endsWith(".jpg"))
          .toList(growable: false);
      return true;
    } catch (e) {
      return false;
    }
  }
}
