import 'package:ekam_flutter_assignment/ui/booking/booking_view.dart';
import 'package:ekam_flutter_assignment/ui/select_package/select_package_view.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/common_widget.dart';
import '../utils/images.dart';
import '../utils/utils.dart';
import 'doctor_details/doctor_details_view.dart';
import 'package:ekam_flutter_assignment/ui/confirmation/confirmation_view.dart';
import 'package:ekam_flutter_assignment/ui/booking/booking_view.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {


  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      if(mounted) {
        Navigator.of(context)
            .pushReplacement(UI.getCustomPageRouteForChild(const DoctorsDetails()));
      }
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    Utils.init(context);

    return Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
            top: false,
            bottom: false,
            child: Container(
                width: Utils.width,
                constraints: const BoxConstraints.expand(),
               color: AppColors.whiteTextColor,
              child: Center(
                child: SizedBox(
                  width: Utils.width * 0.40,
                  child: Image.asset(
                    Images.logo,
                  ),
                ),
              ),
            )
        )
    );
  }
}
