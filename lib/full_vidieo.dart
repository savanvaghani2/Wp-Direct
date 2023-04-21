import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';
import 'package:wp_direct/widgets.dart';

class Full_vidieo extends StatefulWidget {
  Full_vidieo({Key? key, this.vidiopath, this.index}) : super(key: key);
  final vidiopath;
  var index;

  @override
  State<Full_vidieo> createState() => _Full_vidieoState();
}

class _Full_vidieoState extends State<Full_vidieo> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.file(File(widget.vidiopath));
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      showOptions: true,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Scaffold(
      appBar: AppBar(actions: [
        Padding(
          padding: const EdgeInsets.all(5.0),
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
                            Down_share().downloadvideo(widget.vidiopath);
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
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: IconButton(
            onPressed: () {
              Down_share().shareVidieo(widget.vidiopath);
            },
            icon: Icon(
              Icons.share,
              color: Colors.white,
            ),
          ),
        )
      ]),
      body: SizedBox(
        height: Get.height / 1.13,
        child: Hero(
          tag: "vidieo${widget.index}",
          child: Material(
            child: Chewie(controller: _chewieController!),
          ),
        ),
      ),
    )));
  }
}

class Shimmy extends StatefulWidget {
  const Shimmy({Key? key, this.height, this.width}) : super(key: key);
  final height;
  final width;

  @override
  State<Shimmy> createState() => _ShimmyState();
}

class _ShimmyState extends State<Shimmy> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(.5),
      highlightColor: Colors.grey,
      child: Container(
        height: 220,
        width: 200,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
