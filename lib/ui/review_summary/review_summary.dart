import 'dart:io';
import 'package:ekam_flutter_assignment/ui/confirmation/confirmation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../api/api_io.dart';
import '../../utils/app_connectivity.dart';
import '../../utils/colors.dart';
import '../../utils/common_widget.dart';
import '../../utils/images.dart';
import '../../utils/strings.dart';
import '../../utils/text_sizes.dart';

class ReviewSummary extends StatefulWidget {
  final Doctor doctorList;
  final String duration;
  final String package;
  const ReviewSummary(this.doctorList,this.duration, this.package,{Key? key}) : super(key: key);

  @override
  State<ReviewSummary> createState() => _ReviewSummaryState();
}

class _ReviewSummaryState extends State<ReviewSummary>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      body: SafeArea(top: false, bottom: false, child: _loadDoctorDetails()),
    );
  }

  Widget _loadDoctorDetails() {
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
                        child: Text(Strings.reviewSummary,
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
                child: _doctorsList()
            )
          ),
        ],
      ),
    );
  }

  Widget _doctorsList(){
      return Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          _getResourceImage(widget.doctorList.image),
                          Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: Space.sp(15),
                                        top: Space.sp(5)),
                                    child: Text(
                                      (widget.doctorList.doctorName).toString(),
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          fontSize: TextSize.setSp(20),
                                          color: AppColors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: Space.sp(15),
                                        top: Space.sp(2),),
                                    child: Text(
                                      (widget.doctorList.speciality).toString(),
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
                                            child: const Icon(Icons.location_on,color: AppColors.colorPrimary,size: 20)
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: Space.sp(2)),
                                            child: Text(
                                              (widget.doctorList.location).toString(),
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
                                        InkWell(
                                          // needed
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: Space.sp(5),
                                                top: Space.sp(15),
                                                bottom: Space.sp(15),
                                                right: Space.sp(15)),
                                            child: const Icon(Icons.bar_chart,color: AppColors.colorPrimary,size: 20)
                                          ),
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: Space.sp(15),
                                top: Space.sp(10)),
                            child: Text(
                              "Date & Hour",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: TextSize.setSp(16),
                                  color: AppColors.lightGrey),
                            ),
                          ),
                          Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: Space.sp(15),
                                    top: Space.sp(10),
                                    right: Space.sp(10),
                                    ),
                                child: Text(
                                  "September 25,2023 | 10:00 AM",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      fontSize: TextSize.setSp(16),
                                      color: AppColors.black),
                                ),
                              ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: Space.sp(15),
                                top: Space.sp(5)),
                            child: Text(
                              "Package",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: TextSize.setSp(16),
                                  color: AppColors.lightGrey),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: Space.sp(15),
                                  top: Space.sp(5),
                                right: Space.sp(10),),
                              child: Text(
                                widget.package == 1 ? "Messaging" : widget.package == 2 ? "Voice Call" :widget.package == 3 ? "Video Call" : "In Person",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold,
                                    fontSize: TextSize.setSp(16),
                                    color: AppColors.black),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: Space.sp(15),
                                top: Space.sp(5)),
                            child: Text(
                              "Duration",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: TextSize.setSp(16),
                                  color: AppColors.lightGrey),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: Space.sp(15),
                                  top: Space.sp(5),
                                right: Space.sp(10),),
                              child: Text(
                                widget.duration,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold,
                                    fontSize: TextSize.setSp(16),
                                    color: AppColors.black),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: Space.sp(15),
                                top: Space.sp(5)),
                            child: Text(
                              "Booking for",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: TextSize.setSp(16),
                                  color: AppColors.lightGrey),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: Space.sp(15),
                                  top: Space.sp(5),
                                right: Space.sp(10),),
                              child: Text(
                                "Self",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold,
                                    fontSize: TextSize.setSp(16),
                                    color: AppColors.black),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                    height: Space.sp(60),
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
                  height: Space.sp(80),
                  color: AppColors.white,
                  child: UI.getCommonButton(Strings.confirm,_confirmClick,isFullWidth: true),
                )
              ],
            )
          ]
      );
  }

  Widget _getResourceImage(url) {
    return Stack(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: SizedBox(
              width: 120, height: 120,
              child: Image.network((url).toString()))),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _closeClick(context) {
    Navigator.pop(context);
  }

  void _confirmClick() {
    if (AppConnectivity().isConnected) {
      if(mounted) {
        Navigator.of(context)
            .push(UI.getCustomPageRouteForChild(const ConfirmationDetailsView()));
      }
    } else {
      UI.showSnackBar(context, Strings.noNetworkText);
    }
  }
}
