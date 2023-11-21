import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../common/no_network_inline_widget.dart';
import '../../common/server_error_view.dart';
import '../../utils/app_connectivity.dart';
import '../../utils/colors.dart';
import '../../utils/common_widget.dart';
import '../../utils/images.dart';
import '../../utils/strings.dart';
import '../../utils/text_sizes.dart';
import '../../utils/utils.dart';
import 'confirmation_view_model.dart';

class ConfirmationDetailsView extends StatefulWidget {
  const ConfirmationDetailsView({Key? key}) : super(key: key);

  @override
  State<ConfirmationDetailsView> createState() => _ConfirmationDetailsViewState();
}

class _ConfirmationDetailsViewState extends State<ConfirmationDetailsView>{
  ConfirmationDetailsViewViewModel? viewModel;

  @override
  Widget build(BuildContext context) {
    if (viewModel == null) {
      viewModel = Provider.of<ConfirmationDetailsViewViewModel>(context);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        viewModel?.getConfirmationDetails();
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      body: SafeArea(top: false, bottom: false, child: _loadConfirmationDetailsView()),
    );
  }

  Widget _loadConfirmationDetailsView() {
    if (viewModel?.networkAvailable == false) {
      return NoNetworkWidget(Strings.okText, null, _onOkClick);
    } else if (viewModel?.serverError == true) {
      return ServerErrorView(
        onClick: _serverErrorClick,
      );
    } else {
      if (viewModel?.loading == true) {
        return Center(
          child: SizedBox(
              height: Utils.height * 0.4, child: UI.getDarkBgLoadingUI()),
        );
      } else {
        return SafeArea(
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                            top: Space.sp(10)),
                        child: Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: Space.sp(10)),
                            height: Space.sp(55),
                            color: AppColors.white,
                            child: Stack(
                              children: <Widget>[
                                Center(
                                  child: Text(Strings.confirmation,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          fontSize: TextSize.setSp(18),
                                          color: AppColors.black)),
                                ),
                                Positioned(
                                  top: 0.0,
                                  left: 0.0,
                                  bottom: 0.0,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: InkWell(
                                        onTap: () {
                                          _closeClick(context);
                                        },
                                        onDoubleTap: () {}, // needed
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(100),
                                              border: Border.all(
                                                  width: 2,
                                                  color: AppColors
                                                      .inputFieldTextColor)),
                                          child: Padding(
                                            padding:
                                            EdgeInsets.all(Space.sp(15)),
                                            child: Image.asset(Images.backIcon,
                                                color: AppColors.black
                                                    .withOpacity(0.7),
                                                width: Space.sp(17),
                                                height: Space.sp(17)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                    ),
                    Expanded(
                      child: Container(
                          color: AppColors.white,
                          padding: const EdgeInsets.only(bottom: 15),
                          child: _confirmationDetailsView()
                      )
                    ),
                  ],
                ),
              );
      }
    }
  }

  Widget _confirmationDetailsView(){
    return (viewModel?.confirmationDetails.appointmentTime.isNotEmpty == true)
        ? Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                      EdgeInsets.all(Space.sp(15)),
                      child: Image.asset(Images.confirm,
                          width: Space.sp(120),
                          height: Space.sp(120)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: Space.sp(5), top: Space.sp(5)),
                      child: Text(
                        Strings.appConfirmed,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: TextSize.setSp(16),
                            color: AppColors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: Space.sp(5), top: Space.sp(5)),
                      child: Text(
                        "You have successfully booked appointment with",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            fontSize: TextSize.setSp(14),
                            color: AppColors.lightGrey),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: Space.sp(5), top: Space.sp(5)),
                      child: Text(
                        (viewModel?.confirmationDetails.doctorName).toString(),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: TextSize.setSp(14),
                            color: AppColors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: Space.sp(15)),
                      child: Row(
                        children: [
                          InkWell(
                            // needed
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: Space.sp(15),
                                    top: Space.sp(15),
                                    bottom: Space.sp(15)),
                                child: const Icon(Icons.person,color: AppColors.colorPrimary,size: 30)
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: Space.sp(5)),
                              child: Text(
                                "Esther Howard",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                    TextSize.setSp(16),
                                    color: AppColors.lightGrey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Row(
                            children: [
                              InkWell(
                                // needed
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: Space.sp(15),
                                        top: Space.sp(15),
                                        bottom: Space.sp(15)),
                                    child: const Icon(Icons.calendar_month,color: AppColors.colorPrimary,size: 30)
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Space.sp(5)),
                                  child: Text(
                                    viewModel!.confirmationDetails.appointmentDate.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                        TextSize.setSp(16),
                                        color: AppColors.lightGrey),
                                  ),
                                ),
                              ),
                            ],
                        )),
                        Expanded(
                            child: Row(
                              children: [
                                InkWell(
                                  // needed
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: Space.sp(15),
                                          top: Space.sp(15),
                                          bottom: Space.sp(15)),
                                      child: const Icon(Icons.timer,color: AppColors.colorPrimary,size: 30)
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: Space.sp(5),
                                        right: Space.sp(5)),
                                    child: Text(
                                      viewModel!.confirmationDetails.appointmentTime.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                          TextSize.setSp(16),
                                          color: AppColors.lightGrey),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                    height: Space.sp(115),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: AppColors.lightGrey.withOpacity(0.5)
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                        )
                    )
                ),
                Container(
                  margin: EdgeInsets.only(top: Space.sp(8)),
                  height: Space.sp(110),
                  color: AppColors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UI.getCommonButton(Strings.confirm,_viewAppiontment,isFullWidth: true),
                      Center(
                        child: Text(
                          "Book Another",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: TextSize.setSp(14),
                          color: AppColors.colorPrimary),
                      )),
                    ],
                  )
                )
              ],
            )
          ],
        )
        : Center(
        child: Text(
          "No Data",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: TextSize.setSp(15),
              color: AppColors.black),
        ));
  }

  @override
  void dispose() {
    viewModel?.resetWithoutNotify();
    super.dispose();
  }

  void _onOkClick() {
    viewModel?.setNetworkStatus = true;
  }

  void _serverErrorClick() {
    SystemNavigator.pop(animated: true);
    exit(0);
  }

  void _closeClick(context) {
    Navigator.pop(context);
  }

  void _viewAppiontment() {
    if (AppConnectivity().isConnected) {
      UI.showSnackBar(context, "Need to implement!");
    } else {
      UI.showSnackBar(context, Strings.noNetworkText);
    }
  }
}
