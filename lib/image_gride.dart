import 'dart:io';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wp_direct/widgets.dart';

import 'fullscreen.dart';

class image_gride extends StatefulWidget {
  const image_gride({Key? key}) : super(key: key);

  @override
  State<image_gride> createState() => _image_grideState();
}

class _image_grideState extends State<image_gride> {
  final Down_share _controller = Get.put(Down_share());
  late bool _isloading = false;
  Future _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    _controller.getfile();
  }

  @override
  void initState() {
    _isloading = true;
    super.initState();
    print("=================${_controller.imageList.length}");
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isloading = false;
      });
    });
  }

  @override
  void dispose() {
    _isloading = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isloading
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 15,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 2 / 3,
                  crossAxisCount: 3,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4),
              itemBuilder: (context, i) {
                return Shimmy(
                  height: Get.height / 2,
                  width: Get.width / 2,
                );
              },
            ),
          )
        : SizedBox(
            height: Get.height,
            child: WarpIndicator(
              starsCount: 50,
              onRefresh: _refreshData,
              child: Obx(
                () => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _controller.imageList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 2 / 3,
                            crossAxisCount: 3,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4),
                    itemBuilder: (context, index) {
                      File file = File('${_controller.imageList[index]}');
                      return FutureBuilder(builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        return InkWell(
                          onTap: () {
                            Get.to(
                              () => Full_img_screen(
                                path: file,
                                index: index,
                              ),
                            );
                          },
                          child: Hero(
                            tag: "tagimage$index",
                            transitionOnUserGestures: false,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(file),
                                      fit: BoxFit.cover),
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10)),
                              height: Get.height / 2,
                              width: Get.width / 2,
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ),
              ),
            ));
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
