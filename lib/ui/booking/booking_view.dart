import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../common/no_network_inline_widget.dart';
import '../../common/server_error_view.dart';
import '../../utils/colors.dart';
import '../../utils/common_widget.dart';
import '../../utils/images.dart';
import '../../utils/strings.dart';
import '../../utils/text_sizes.dart';
import '../../utils/utils.dart';
import 'booking_view_model.dart';

class BookingDetailsView extends StatefulWidget {
  const BookingDetailsView({Key? key}) : super(key: key);

  @override
  State<BookingDetailsView> createState() => _BookingDetailsViewState();
}

class _BookingDetailsViewState extends State<BookingDetailsView>{
  BookingDetailsViewViewModel? viewModel;

  @override
  Widget build(BuildContext context) {
    if (viewModel == null) {
      viewModel = Provider.of<BookingDetailsViewViewModel>(context);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        viewModel?.getConfirmationDetails();
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      body: SafeArea(top: false, bottom: false, child: _loadConfirmationDetailsView(context)),
    );
  }

  Widget _loadConfirmationDetailsView(context) {
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
                            child: Row(
                              children: [
                                Material(
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
                                Expanded(
                                  child: Center(
                                    child: Text(Strings.confirmation,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.bold,
                                            fontSize: TextSize.setSp(18),
                                            color: AppColors.black)),
                                  ),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: InkWell(
                                      onTap: () {

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
                                          child: Icon(Icons.search,
                                              color: AppColors.black
                                                  .withOpacity(0.7),
                                              size: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),),
                    ),
                    Expanded(
                      child: Container(
                          color: AppColors.white,
                          padding: const EdgeInsets.only(bottom: 15),
                          child: _appointmentDetails()
                      )
                    ),
                  ],
                ),
              );
      }
    }
  }

  Widget _appointmentDetails(){
    return (viewModel?.bookingDetails?.length != null &&
        viewModel?.bookingDetails.isNotEmpty == true) ? ListView.builder(
        itemCount: viewModel?.bookingDetails?.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Wrap(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Space.sp(15),vertical: Space.sp(5)),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Text("${viewModel!.bookingDetails[index]?.appointmentDate}, ${viewModel!.bookingDetails[index]?.appointmentTime}",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontSize: TextSize.setSp(16),
                                    color: AppColors.black)),
                          ),
                          Divider(
                              height: 20.0,
                              thickness: 1.0,
                              indent: Space.sp(10),
                              endIndent: Space.sp(10)),
                          Wrap(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  left: Space.sp(10),
                                  top: Space.sp(5),
                                  right: Space.sp(10),
                                  bottom: Space.sp(5),
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
                                                  left: Space.sp(5),
                                                  top: Space.sp(2)),
                                              child: Text(
                                                (viewModel?.bookingDetails![index]?.doctorName).toString(),
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: TextSize.setSp(18),
                                                    color: AppColors.black),
                                              ),
                                            ),
                                            Wrap(children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(vertical: Space.sp(10)),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      // needed
                                                      child: Padding(
                                                          padding: EdgeInsets.only(
                                                              left: Space.sp(1),),
                                                          child: const Icon(Icons.location_on,color: AppColors.colorPrimary,size: 20)
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.only(
                                                            left: Space.sp(2)),
                                                        child: Text(
                                                          (viewModel?.bookingDetails![index]?.location).toString(),
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
                                              )
                                            ]),
                                            Wrap(children: [
                                              Row(
                                                children: [
                                                  InkWell(
                                                    // needed
                                                    child: Padding(
                                                        padding: EdgeInsets.only(
                                                            left: Space.sp(2),
                                                            top: Space.sp(5)),
                                                        child: const Icon(Icons.book_online_rounded,color: AppColors.colorPrimary,size: 20)
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: Space.sp(2),
                                                          left: Space.sp(2)),
                                                      child: Row(
                                                        children: [
                                                          Text("Booking ID: ",
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            textAlign: TextAlign.start,
                                                            style: GoogleFonts.roboto(
                                                                fontWeight: FontWeight.w600,
                                                                fontSize:
                                                                TextSize.setSp(16),
                                                                color: AppColors.black),
                                                          ),
                                                          Text((viewModel?.bookingDetails![index]?.bookingId).toString(),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            textAlign: TextAlign.start,
                                                            style: GoogleFonts.roboto(
                                                                fontWeight: FontWeight.w600,
                                                                fontSize:
                                                                TextSize.setSp(16),
                                                                color: AppColors.colorPrimary),
                                                          ),
                                                        ],
                                                      ),
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
                            ],
                          ),
                          Divider(
                              height: 20.0,
                              thickness: 1.0,
                              indent: Space.sp(10),
                              endIndent: Space.sp(10)),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                      },
                                      onDoubleTap: () {},
                                      child: Container(
                                          margin: EdgeInsets.symmetric(vertical: Space.sp(5),horizontal: Space.sp(5)),
                                          height: Space.sp(45),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(Space.sp(33))),
                                              color: AppColors.lightGreen),
                                          child: Center(
                                            child: Center(
                                              child: Text(
                                                "Cancel",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: TextSize.setSp(15),
                                                    color: AppColors.colorPrimary),
                                              ),
                                            ),
                                          )),
                                    ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                    },
                                    onDoubleTap: () {},
                                    child: Container(
                                        margin: EdgeInsets.symmetric(vertical: Space.sp(5),horizontal: Space.sp(5)),
                                        height: Space.sp(45),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(Space.sp(33))),
                                            color: AppColors.colorPrimary),
                                        child: Center(
                                          child: Center(
                                            child: Text(
                                              "Reschedule",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: TextSize.setSp(15),
                                                  color: AppColors.white.withOpacity(0.8)),
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ]
          );
        }
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

  Widget _getResourceImage(index) {
    return Stack(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
                width: 100, height: 100,
                child: Image.network('https://hireforekam.s3.ap-south-1.amazonaws.com/doctors/1-Doctor.png'))),
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
    Navigator.pop(context);
    exit(0);
  }

}
