import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:wp_direct/widgets.dart';
import 'full_vidieo.dart';

class Vidieo_gride extends StatefulWidget {
  const Vidieo_gride({
    Key? key,
  }) : super(key: key);

  @override
  Vidieo_grideState createState() => Vidieo_grideState();
}

class Vidieo_grideState extends State<Vidieo_gride> {
  final Down_share _controller = Get.put(Down_share());
  bool _isloading = false;

  @override
  void initState() {
    // TODO: implement initState
    _isloading = true;
    super.initState();
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        _isloading = false;
      });
    });
  }

  Future<String?> genThumbnailFile({String? path}) async {
    return await VideoThumbnail.thumbnailFile(
        thumbnailPath: (await getTemporaryDirectory()).path,
        video: path!,
        imageFormat: ImageFormat.PNG,
        quality: 30);
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
            child: Obx(
              () => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _controller.vidieoList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2 / 3,
                      crossAxisCount: 3,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4),
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                      future:
                          genThumbnailFile(path: _controller.vidieoList[index]),
                      builder: (BuildContext context,
                          AsyncSnapshot<String?> snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data);
                          return InkWell(
                            onTap: () {
                              Get.to(
                                () => Full_vidieo(
                                    index: index,
                                    vidiopath: _controller.vidieoList[index]),
                              );
                            },
                            child: Hero(
                              tag: "vidieo$index",
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(File(snapshot.data!)),
                                        fit: BoxFit.cover),
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10)),
                                height: Get.height / 2,
                                width: Get.width / 2,
                              ),
                            ),
                          );
                        } else {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(.5),
                            highlightColor: Colors.grey,
                            child: Container(
                              height: 220,
                              width: 200,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          );
  }
}
