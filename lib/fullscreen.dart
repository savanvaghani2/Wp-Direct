import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:wp_direct/widgets.dart';

class Full_img_screen extends StatefulWidget {
  Full_img_screen({Key? key, this.path, this.index}) : super(key: key);
  final File? path;
  var index;

  @override
  State<Full_img_screen> createState() => _Full_img_screenState();
}

class _Full_img_screenState extends State<Full_img_screen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        title: Text(
                          "Download Confirmation",
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.w600, fontSize: 16.sp),
                        ),
                        content: Text(
                            "Are you sure you want to download this file ?",
                            style: GoogleFonts.rubik(fontSize: 13.sp)),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("Cancel", style: GoogleFonts.rubik()),
                          ),
                          TextButton(
                            onPressed: () {
                              Down_share().downloadimage(widget.path);
                              Get.back();
                              Get.back();
                            },
                            child: Text("Download", style: GoogleFonts.rubik()),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.download_outlined)),
          )
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Down_share().shareImage(widget.path!.path);
          },
          backgroundColor: Colors.black,
          child: Icon(
            Icons.share,
            color: Colors.white,
          ),
        ),
        body: Hero(
          tag: "tagimage${widget.index}",
          child: Stack(
            children: [
              Container(
                height: Get.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  image: DecorationImage(
                      image: FileImage(widget.path!), fit: BoxFit.contain),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
