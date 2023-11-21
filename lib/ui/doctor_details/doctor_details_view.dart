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
import '../select_package/select_package_view.dart';
import 'doctor_details_view_model.dart';

class DoctorsDetails extends StatefulWidget {
  const DoctorsDetails({Key? key}) : super(key: key);

  @override
  State<DoctorsDetails> createState() => _DoctorsDetailsState();
}

class _DoctorsDetailsState extends State<DoctorsDetails> {
  DoctorsDetailsViewModel? viewModel;

  @override
  Widget build(BuildContext context) {
    if (viewModel == null) {
      viewModel = Provider.of<DoctorsDetailsViewModel>(context);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        viewModel?.getDoctorDetails();
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      body: SafeArea(top: false, bottom: false, child: _loadDoctorDetails()),
    );
  }

  Widget _loadDoctorDetails() {
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
                padding: EdgeInsets.only(top: Space.sp(10)),
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Space.sp(10)),
                    height: Space.sp(55),
                    color: AppColors.white,
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Text(Strings.bookAppointment,
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
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          width: 2,
                                          color:
                                              AppColors.inputFieldTextColor)),
                                  child: Padding(
                                    padding: EdgeInsets.all(Space.sp(15)),
                                    child: Image.asset(Images.backIcon,
                                        color: AppColors.black.withOpacity(0.7),
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
                      child: _doctorsList())),
            ],
          ),
        );
      }
    }
  }

  Widget _doctorsList() {
    return (viewModel?.doctorList?.length != null &&
            viewModel?.doctorList.isNotEmpty == true)
        ? ListView.builder(
            itemCount: viewModel?.doctorList?.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return Wrap(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: index != 0,
                      child: const Divider(
                        color: AppColors.colorPrimary,
                        height: 20.0,
                        thickness: 5.0,
                      ),
                    ),
                    Wrap(children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: Space.sp(12),
                          top: Space.sp(20),
                          right: Space.sp(12),
                          bottom: Space.sp(12),
                        ),
                        child: Row(
                          children: [
                            _getResourceImage(index),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: Space.sp(15), top: Space.sp(5)),
                                  child: Text(
                                    (viewModel?.doctorList![index]?.doctorName)
                                        .toString(),
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        fontSize: TextSize.setSp(20),
                                        color: AppColors.black),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: Space.sp(15), top: Space.sp(2)),
                                  child: Text(
                                    (viewModel?.doctorList![index]?.speciality)
                                        .toString(),
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        fontSize: TextSize.setSp(16),
                                        color: AppColors.lightGrey),
                                  ),
                                ),
                                Wrap(children: [
                                  Row(
                                    children: [
                                      InkWell(
                                        // needed
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                left: Space.sp(15),
                                                top: Space.sp(15),
                                                bottom: Space.sp(15)),
                                            child: const Icon(Icons.location_on,
                                                color: AppColors.colorPrimary,
                                                size: 20)),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: Space.sp(2)),
                                          child: Text(
                                            (viewModel?.doctorList![index]
                                                    ?.location)
                                                .toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w600,
                                                fontSize: TextSize.setSp(16),
                                                color: AppColors.lightGrey),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        // needed
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                left: Space.sp(5),
                                                top: Space.sp(15),
                                                bottom: Space.sp(15),
                                                right: Space.sp(15)),
                                            child: const Icon(Icons.bar_chart,
                                                color: AppColors.colorPrimary,
                                                size: 20)),
                                      ),
                                    ],
                                  )
                                ])
                              ],
                            ))
                          ],
                        ),
                      ),
                    ]),
                    Divider(
                        height: 20.0,
                        thickness: 1.0,
                        indent: Space.sp(25),
                        endIndent: Space.sp(25)),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: Space.sp(15)),
                                child: ClipOval(
                                  child: Material(
                                    color: AppColors.lightGreen, // Button color
                                    child: InkWell(
                                      onTap: () {},
                                      child: const SizedBox(
                                          width: 60,
                                          height: 60,
                                          child: Icon(
                                            Icons.supervisor_account,
                                            color: AppColors.colorPrimary,
                                            size: 30,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: Space.sp(3), bottom: Space.sp(1)),
                                child: Center(
                                  child: Text(
                                      "${viewModel?.doctorList[index]?.patientsServed}+",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          fontSize: TextSize.setSp(16),
                                          color: AppColors.colorPrimary)),
                                ),
                              ),
                              Center(
                                child: Text(Strings.patients,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.normal,
                                        fontSize: TextSize.setSp(12),
                                        color: AppColors.lightGrey)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: Space.sp(15)),
                                child: ClipOval(
                                  child: Material(
                                    color: AppColors.lightGreen, // Button color
                                    child: InkWell(
                                      onTap: () {},
                                      child: const SizedBox(
                                          width: 60,
                                          height: 60,
                                          child: Icon(
                                            Icons.shopping_bag_outlined,
                                            color: AppColors.colorPrimary,
                                            size: 30,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: Space.sp(3), bottom: Space.sp(1)),
                                child: Center(
                                  child: Text(
                                      "${viewModel?.doctorList![index]?.yearsOfExperience}+",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          fontSize: TextSize.setSp(16),
                                          color: AppColors.colorPrimary)),
                                ),
                              ),
                              Center(
                                child: Text(Strings.yearsOfExp,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.normal,
                                        fontSize: TextSize.setSp(12),
                                        color: AppColors.lightGrey)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: Space.sp(15)),
                                child: ClipOval(
                                  child: Material(
                                    color: AppColors.lightGreen, // Button color
                                    child: InkWell(
                                      onTap: () {},
                                      child: const SizedBox(
                                          width: 60,
                                          height: 60,
                                          child: Icon(
                                            Icons.star,
                                            color: AppColors.colorPrimary,
                                            size: 30,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: Space.sp(3), bottom: Space.sp(1)),
                                child: Center(
                                  child: Text(
                                      "${viewModel?.doctorList![index]?.rating}+",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          fontSize: TextSize.setSp(16),
                                          color: AppColors.colorPrimary)),
                                ),
                              ),
                              Center(
                                child: Text(Strings.rating,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.normal,
                                        fontSize: TextSize.setSp(12),
                                        color: AppColors.lightGrey)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: Space.sp(15)),
                                child: ClipOval(
                                  child: Material(
                                    color: AppColors.lightGreen, // Button color
                                    child: InkWell(
                                      onTap: () {},
                                      child: const SizedBox(
                                          width: 60,
                                          height: 60,
                                          child: Icon(
                                            Icons.message,
                                            color: AppColors.colorPrimary,
                                            size: 30,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: Space.sp(3), bottom: Space.sp(1)),
                                child: Center(
                                  child: Text(
                                      (viewModel?.doctorList![index]!
                                              .numberOfReviews)
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          fontSize: TextSize.setSp(16),
                                          color: AppColors.colorPrimary)),
                                ),
                              ),
                              Center(
                                child: Text(Strings.review,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.normal,
                                        fontSize: TextSize.setSp(12),
                                        color: AppColors.lightGrey)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Space.sp(20), top: Space.sp(20)),
                      child: Text(Strings.bookAppointment.toUpperCase(),
                          textAlign: TextAlign.start,
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              fontSize: TextSize.setSp(16),
                              color: AppColors.lightGreyTextColor)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Space.sp(20), top: Space.sp(20)),
                      child: Text(Strings.day,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontSize: TextSize.setSp(18),
                              color: AppColors.black)),
                    ),
                    GestureDetector(
                      onTap: () {},
                      onDoubleTap: () {},
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Space.sp(15),
                            bottom: Space.sp(15),
                            left: Space.sp(22),
                            right: Space.sp(22)),
                        child: Container(
                            width: Utils.width * 0.27,
                            height: Space.sp(65),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Space.sp(33))),
                                color: AppColors.colorPrimary),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      "Today",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          fontSize: TextSize.setSp(14),
                                          color:
                                              AppColors.white.withOpacity(0.8)),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "25 Sep",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: TextSize.setSp(16),
                                          color: AppColors.white),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Space.sp(20), top: Space.sp(20)),
                      child: Text(Strings.time,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontSize: TextSize.setSp(18),
                              color: AppColors.black)),
                    ),
                    GestureDetector(
                      onTap: () {},
                      onDoubleTap: () {},
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Space.sp(15),
                            bottom: Space.sp(15),
                            left: Space.sp(22),
                            right: Space.sp(22)),
                        child: Container(
                            width: Utils.width * 0.35,
                            height: Space.sp(50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Space.sp(30))),
                                color: AppColors.colorPrimary),
                            child: Center(
                              child: Center(
                                child: Text(
                                  "7:00 PM",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: TextSize.setSp(14),
                                      color: AppColors.white),
                                ),
                              ),
                            )),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                            height: Space.sp(60),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color:
                                        AppColors.lightGrey.withOpacity(0.5)),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ))),
                        Container(
                          margin: EdgeInsets.only(top: Space.sp(8)),
                          height: Space.sp(80),
                          color: AppColors.white,
                          //child: UI.getCommonButton(Strings.makeAppointment,_makeAppointment,isFullWidth: true),
                          child: GestureDetector(
                            onTap: () {
                              _makeAppointment(index);
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
                                    width: Utils.width * 0.80,
                                    height: Space.sp(45),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(Space.sp(25))),
                                        color: AppColors.colorPrimary),
                                    child: Center(
                                      child: Text(
                                        Strings.makeAppointment,
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
                          ),
                        )
                      ],
                    )
                  ],
                )
              ]);
            })
        : Center(
            child: Text(
            Strings.doctorDetailsNotFound,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: TextSize.setSp(15),
                color: AppColors.black),
          ));
  }

  Widget _getResourceImage(index) {
    return Stack(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: SizedBox(
                width: 120,
                height: 120,
                child: Image.network(
                    (viewModel?.doctorList![index]?.image).toString()))),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
            ),
            child: Icon(
              Icons.check_circle,
              color: AppColors.greenColor,
              size: Space.sp(30),
            ),
          ),
        ),
      ],
    );
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
    viewModel?.resetWithoutNotify();
    Navigator.pop(context);
    exit(0);
  }

  void _makeAppointment(index) {
    if (AppConnectivity().isConnected) {
      Navigator.of(context).push(UI.getCustomPageRouteForChild(
          SelectPackage(viewModel!.doctorList[index]!)));
    } else {
      UI.showSnackBar(context, Strings.noNetworkText);
    }
  }
}
