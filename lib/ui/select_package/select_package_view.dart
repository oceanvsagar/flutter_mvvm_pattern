import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../api/api_io.dart';
import '../../common/no_network_inline_widget.dart';
import '../../common/server_error_view.dart';
import '../../utils/app_connectivity.dart';
import '../../utils/colors.dart';
import '../../utils/common_widget.dart';
import '../../utils/images.dart';
import '../../utils/strings.dart';
import '../../utils/text_sizes.dart';
import '../../utils/utils.dart';
import '../review_summary/review_summary.dart';
import 'select_package_view_model.dart';

class SelectPackage extends StatefulWidget {
  final Doctor doctorList;
  const SelectPackage(this.doctorList,{Key? key}) : super(key: key);

  @override
  State<SelectPackage> createState() => _SelectPackageState();
}

class _SelectPackageState extends State<SelectPackage> {
  SelectPackageViewModel? viewModel;
  String? selectedDuration;
  int selectedValue = 1;
  int selectedIndexValue = 1;

  @override
  Widget build(BuildContext context) {
    if (viewModel == null) {
      viewModel = Provider.of<SelectPackageViewModel>(context);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        viewModel?.getPackageDetails();
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      body: SafeArea(top: false, bottom: false, child: _loadSelectPackageDetails(context)),
    );
  }

  Widget _loadSelectPackageDetails(context) {
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
                                  child: Text(Strings.selectPackage,
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
                          child: _displayPackageDetails()
                      )
                    ),
                  ],
                ),
              );
      }
    }
  }

  Widget _displayPackageDetails(){
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: Space.sp(15), horizontal: Space.sp(15)),
            child: Text(Strings.selectDuration,
                textAlign: TextAlign.start,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: TextSize.setSp(18),
                    color: AppColors.black)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: Space.sp(5), horizontal: Space.sp(15)),
            child: Container(
              height: 50,
              width: Utils.width,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: AppColors.inputFieldTextColor, // Set border color
                    width: 2), // Set border width
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                    value: (selectedDuration == "" || selectedDuration == null) ? viewModel?.serviceOptions.duration.first : selectedDuration,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                    ),
                    icon: Image.asset(Images.dropdown,
                      width: 16,
                      height: 16,
                      color: AppColors.colorPrimary,
                    ),
                    items: viewModel?.serviceOptions.duration.map((String duration) {
                      return DropdownMenuItem<String>(
                        value: duration,
                        child: Text(
                          duration.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDuration = value;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: Space.sp(15), horizontal: Space.sp(15)),
            child: Text(Strings.selectPackage,
                textAlign: TextAlign.start,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: TextSize.setSp(18),
                    color: AppColors.black)),
          ),
          Expanded(child: _bindPackageData()),
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
                //child: UI.getCommonButton(Strings.next,_nextClick,isFullWidth: true),
                child: GestureDetector(
                  onTap: () {
                    _nextClick();
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
                          width:  Utils.width * 0.80,
                          height: Space.sp(45),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(Space.sp(25))),
                              color: AppColors.colorPrimary),
                          child: Center(
                            child: Text(
                              Strings.next,
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
          
        ]
    );
  }

  Widget _bindPackageData(){
    return viewModel!.serviceOptions.package.isNotEmpty ? ListView.builder(
        itemCount: viewModel!.serviceOptions.package.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Wrap(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Space.sp(15)),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Row(
                                children: [
                                  ClipOval(
                                    child: Material(
                                      color: AppColors.lightGreen, // Button color
                                      child: InkWell(
                                        onTap: () {},
                                        child: SizedBox(width: 60, height: 60, child:
                                        Icon( index == 0 ? Icons.message : index == 1 ? Icons.call : index == 2 ? Icons.video_call : Icons.person,
                                          color: AppColors.colorPrimary,size: 30,)),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: Space.sp(15),
                                                top: Space.sp(2)),
                                            child: Text((viewModel!.serviceOptions.package.elementAt(index)).toString(),
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: TextSize.setSp(16),
                                                  color: AppColors.black),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: Space.sp(15),
                                                top: Space.sp(2)),
                                            child: Text(index == 0 ? "Chat with Doctor" : index == 1 ? "Voice Call" : index == 2 ? "Video Call" : "In Person visit with doctor",
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: TextSize.setSp(14),
                                                  color: AppColors.lightGrey),
                                            ),
                                          ),
                                        ],
                                      )
                                  )
                                ],
                              )
                          ),
                          Radio<int>(
                            value: index+1,
                            groupValue: selectedValue,
                            activeColor: AppColors.colorPrimary,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value!;
                                selectedIndexValue= index+1;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]
          );
        }
    ) : Center(
      child: Text("No package",
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              fontSize: TextSize.setSp(18),
              color: AppColors.black)),
    );
  }

  void _nextClick() {
    if (AppConnectivity().isConnected) {
      Navigator.of(context)
          .push(UI.getCustomPageRouteForChild(ReviewSummary(widget.doctorList, (selectedDuration == "" || selectedDuration == null) ? (viewModel?.serviceOptions.duration.first).toString() : selectedDuration as String ,selectedValue.toString())));
    } else {
      UI.showSnackBar(context, Strings.noNetworkText);
    }
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
}
