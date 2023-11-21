import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/common_widget.dart';
import '../../utils/images.dart';
import '../../utils/strings.dart';
import '../../utils/text_sizes.dart';
import '../../utils/utils.dart';
import '../utils/colors.dart';

class ServerErrorView extends StatefulWidget {
  final Function? onClick;

  const ServerErrorView({this.onClick,  Key? key}) : super(key: key);

  @override
  State<ServerErrorView> createState() => _ServerErrorViewState();
}

class _ServerErrorViewState extends State<ServerErrorView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.transparent,
      child: Center(
        child: Wrap(
          children: [
            Column(
              children: [
                SizedBox(
                  height: Utils.height * 0.2,
                  width: Utils.width * 0.9,
                  child: Image.asset(
                    Images.serverError,
                    color: AppColors.black,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: Space.sp(20), top: Space.sp(10)),
                  child: Text(
                    Strings.somethingWentWrongText,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: TextSize.setSp(16),
                        color: AppColors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                UI.getCommonButton(
                    Strings.closeText, widget.onClick ?? commonClick)
              ],
            ),
          ],
        ),
      ),
    );
  }

  void commonClick() {
    Navigator.pop(context);
  }
}
