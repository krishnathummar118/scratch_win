
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scratch_win/routes/AppRoutes.dart';

import '../utils/constants.dart';
import '../utils/widget_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _one = GlobalKey();

  final scrollController = ScrollController();
  RxInt numberSelected = 0.obs;
  TextEditingController txtController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    initScreenSize(context);
    int crossAxisCount = 2;
    double spacingVal = 12.h;
    double itemWidth = (Get.width / crossAxisCount) - (spacingVal * 2);
    double itemHeight = itemWidth;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              10.verticalSpace,
              buildInputContainer(spacingVal, context),
              buildOutputContainer(crossAxisCount, itemWidth, itemHeight, spacingVal)
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildOutputContainer(int crossAxisCount, double itemWidth, double itemHeight, double spacingVal) {
    return Expanded(
              flex: 1,
              child: ObxValue((p0) {
                return (numberSelected.value > 0)
                    ? GridView.count(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: itemWidth / itemHeight,
                  mainAxisSpacing: spacingVal,
                  crossAxisSpacing: spacingVal,
                  padding: EdgeInsets.all(spacingVal),
                  children:
                  List.generate(numberSelected.value, (index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.getScratchCardRoute(index));

                        // Get.to(ScratchScreen(item: index));

                      },
                      child: Hero(
                        tag: 'item_$index',
                        child: Container(
                          // decoration: BoxDecoration(
                          //     color: Colors.purple,
                          //     borderRadius:
                          //         BorderRadius.all(Radius.circular(10.h)),
                          //     ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.2), // Shadow color
                                offset: Offset(
                                    4, 4), // Offset of the shadow
                                blurRadius: 10, // Spread of the shadow
                                spreadRadius: 0, // Amount of spread
                              ),
                            ],
                            gradient: LinearGradient(
                              colors: [
                                getColors(index + 1),
                                getColors(index + 1).withOpacity(0.8)
                              ],
                              // colors: [Colors.purple, Colors.purple.shade400],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          width: double.infinity,
                          height: double.infinity,
                          child: Stack(
                            children: [
                              // getAssetImage("overlay2.png",
                              //     width: double.infinity,
                              //     height: double.infinity,
                              //     fit: BoxFit.cover)
                              Opacity(
                                opacity: 0.2,
                                child: getAssetImage("overlay2.png",
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    getCustomText("Scratch\nNow",
                                        txtColor: Colors.white,
                                        txtSize: 30.sp,
                                        fonts: scratchFontFamily,
                                        txtAlign: TextAlign.center,
                                        shadow: [
                                          Shadow(
                                            color: Colors.black
                                                .withOpacity(0.5),
                                            // Dark shadow color
                                            offset: Offset(2, 2),
                                            // Dark shadow offset
                                            blurRadius:
                                            2, // Dark shadow blur radius
                                          ),
                                          // Shadow(
                                          //   color: Colors.white.withOpacity(0.5),
                                          //   // Light shadow color
                                          //   offset: Offset(-2, -2),
                                          //   // Light shadow offset
                                          //   blurRadius:
                                          //       2, // Light shadow blur radius
                                          // ),
                                        ])
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                )
                // GridView.builder(
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //       mainAxisSpacing: 12.h,
                //       crossAxisCount: 2,
                //       childAspectRatio: itemWidth / itemHeight,
                //       crossAxisSpacing: 12.h),
                //   itemBuilder: (context, index) {
                //     return Container(color: Colors.purple,
                //       width: double.infinity, height: double.infinity,);
                //   },
                // )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getAssetImage("empty-box.png",
                        width: 95.h, height: 95.h, fit: BoxFit.fill),
                    12.verticalSpace,
                    getCustomText("Scratch cards not available",
                        txtColor: Colors.black,
                        txtSize: 16.sp,
                        txtAlign: TextAlign.center),
                    3.verticalSpace,
                    getCustomText(
                        "Submit a number of scratch cards to get a list",
                        txtColor: Colors.black54,
                        txtSize: 13.sp,
                        txtAlign: TextAlign.center),
                  ],
                );
              }, numberSelected),
            );
  }

  Container buildInputContainer(double spacingVal, BuildContext context) {
    return Container(
              margin: EdgeInsets.all(spacingVal),
              padding: EdgeInsets.all(spacingVal),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Shadow color
                    offset: Offset(4, 4), // Offset of the shadow
                    blurRadius: 10, // Spread of the shadow
                    spreadRadius: 0, // Amount of spread
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // SizedBox(
                    //   height: getButtonHeight(),
                    //   child:
                    TextFormField(
                      controller: txtController,
                      style: getCustomTextStyle(13.sp, Colors.black),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        // Allow only digits (0-9)
                      ],
                      maxLength: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Can\'t be empty';
                        }
                        if ((int.parse(value)) <= 0) {
                          return 'Number should be greater than 0';
                        }
                        if ((int.parse(value)) > 100) {
                          return 'Number should be less than 100';
                        }
                        return null;
                        // if (value == null && (value as int) <= 0) {
                        //   return "Number should be greater than 0";
                        // }
                        // return null;
                      },
                      decoration: InputDecoration(
                          counter: SizedBox(),
                          hintText: "Number of cards",
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 3.w),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.h))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.h)),
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                          hintStyle: getCustomTextStyle(13.sp, Colors.grey)),
                    ),
                    // ),
                    18.verticalSpace,
                    TextButton(
                        style: TextButton.styleFrom(
                            maximumSize: Size(200.h, getButtonHeight()),
                            // Size(double.infinity, getButtonHeight()),
                            // maximumSize: Size(double.maxFinite, getButtonHeight()),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(13.h))),
                            backgroundColor: Theme.of(context).primaryColor),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // on success, notify the parent widget

                            numberSelected.value =
                                int.parse(txtController.text);
                            txtController.clear();
                          }
                          //
                          // if (txtController.text.isNotEmpty) {
                          //   int vals =
                          //       txtController.text.toString() as int;
                          // }
                        },
                        child: Center(
                          child: getCustomText("Submit",
                              txtSize: 13.sp, txtColor: Colors.white),
                        ))
                  ],
                ),
              ),
            );
  }
}
