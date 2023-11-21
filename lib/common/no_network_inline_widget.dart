import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ekam_flutter_assignment/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../utils/text_sizes.dart';
import '../../../../utils/utils.dart';
import '../../../utils/app_connectivity.dart';
import '../../../utils/strings.dart';
import '../../utils/common_widget.dart';
import '../../utils/images.dart';

class NoNetworkWidget extends StatefulWidget {
  final Function? onConnect;
  final String buttonText;
  final Function? onOkClick;

  const NoNetworkWidget(this.buttonText,this.onConnect,this.onOkClick, {Key? key}) : super(key: key);

  @override
  State<NoNetworkWidget> createState() => _NoNetworkWidgetState();
}

class _NoNetworkWidgetState extends State<NoNetworkWidget> {
  final Connectivity _connectivity = Connectivity();

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
  }

  Future<void> initConnectivityCheck() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on Exception catch (e) {
      Utils.printCrashError("Couldn't check connectivity status $e");
      return;
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.transparent,
      child: Padding(
        padding:  EdgeInsets.only(top: Space.sp(16), bottom: Space.sp(16)),
        child: Center(
          child: Wrap(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: Utils.height * 0.2,
                    width: Utils.width * 0.9,
                    child: Image.asset(
                      Images.noNetwork,
                      color: AppColors.greenColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: Space.sp(20), top: Space.sp(20)),
                    child: Text(
                      Strings.noNetworkText,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          fontSize: TextSize.setSp(16),
                          color: AppColors.greenColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  UI.getCommonButton(widget.buttonText, _retryNetwork)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _retryNetwork() async {
    if(widget.buttonText == Strings.okText){
      if(widget.onOkClick != null){
        widget.onOkClick!();
      }
    }else{
      if (AppConnectivity().isConnected){
        if(widget.onConnect != null){
          widget.onConnect!();
        }
      }
    }

  }
}
