import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class Internet_Check extends StatefulWidget {
  const Internet_Check({Key? key}) : super(key: key);

  @override
  State<Internet_Check> createState() => _Internet_CheckState();
}

class _Internet_CheckState extends State<Internet_Check> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 18.h,
            ),
            Container(
              height: 45.h,
              width: 60.w,
              child: Lottie.asset("assets/Animation/error_connection.json"),
            ),
            Text(
              "Oops!",
              style: GoogleFonts.rubik(
                  fontWeight: FontWeight.bold, fontSize: 22.sp),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Text(
                "There is no internet connection\nPlease check your internet connection",
                style: GoogleFonts.rubik(
                    height: 1.3, fontWeight: FontWeight.bold, fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: Colors.grey)),
              onPressed: () {
                Get.snackbar("Internet Not Found",
                    "Make sure your Internet connection is turned on",
                    backgroundColor: Colors.red.withOpacity(.2),
                    icon: Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 30,
                    ));
              },
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.5.h),
                child: Text(
                  "Try Again",
                  style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w500, fontSize: 14.sp),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
