import 'package:ekam_flutter_assignment/utils/text_sizes.dart';
import 'package:ekam_flutter_assignment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';
import 'images.dart';

class UI {

  static Widget getCommonButton(String text, Function callback,{bool isFullWidth = false}) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      onDoubleTap: () {},
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(
              top: Space.sp(15),
              bottom: Space.sp(15),
              left: Space.sp(22),
              right: Space.sp(22)),
          child: Container(
              width:  isFullWidth ? Utils.width * 0.80 : Utils.width * 0.35,
              height: Space.sp(45),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(Space.sp(25))),
                  color: AppColors.colorPrimary),
              child: Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                      fontSize: TextSize.setSp(17),
                      color: AppColors.whiteTextColor),
                ),
              )),
        ),
      ),
    );
  }

  static showSnackBar(BuildContext context, String message,
      {int duration = 2000}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: TextSize.setSp(13),
              color: AppColors.white),
        ),
        duration: Duration(milliseconds: duration),
        backgroundColor: AppColors.colorPrimary.withOpacity(0.9),
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  static Route getCustomPageRouteForChild(Widget child) {
    return MaterialPageRoute(builder: (context) => child);
  }

  static Widget getDarkBgLoadingUI() {
    return Container(
      color: AppColors.transparent,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(Space.sp(16)),
          child: const CircularProgressIndicator(
              backgroundColor: AppColors.greenColor),
        ),
      ),
    );
  }

  static Widget getCommonButtonWithBorder(String text, Function callback) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      onDoubleTap: () {},
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(
              top: Space.sp(10),
              bottom: Space.sp(10),
              left: Space.sp(10),
              right: Space.sp(10)),
          child: Container(
              // constraints: BoxConstraints(minWidth: Utils.width * 0.35),
              width: Utils.width * 0.35,
              height: Space.sp(45),
              // padding: EdgeInsets.symmetric(horizontal: Space.sp(5)),
              decoration: BoxDecoration(
                border: Border.all(width: 2.0, color: AppColors.white),
                borderRadius: BorderRadius.all(Radius.circular(Space.sp(25))),
              ),
              child: Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                      fontSize: TextSize.setSp(17),
                      color:  AppColors.whiteTextColor),
                ),
              )),
        ),
      ),
    );
  }

  static Widget getCommonToolBar(BuildContext context,  { String heading = "", Function? backIconCallback}){
   return Container(
        height: Space.sp(60),
        color: AppColors.colorPrimary,
        child: Padding(
          padding:  EdgeInsets.all(Space.sp(7)),
          child: Row(
            children: <Widget>[
              getBackIcon(context, backIconCallback: backIconCallback),
              Expanded(
                child: Text(heading,
                   maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: TextSize.setSp(16),
                        color: AppColors.whiteTextColor)),
              ),
              //getLogOutIcon(context,logoutCallBack)
            ],
          ),
        ));
  }

  static  Widget getBackIcon(BuildContext context, {Function? backIconCallback}) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if(backIconCallback == null){
              Navigator.pop(context);
            }else{
              backIconCallback();
            }

          },
          onDoubleTap: () {}, // needed
          child: Padding(
            padding: EdgeInsets.all(Space.sp(12)),
            child: Image.asset(Images.backIcon, color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
