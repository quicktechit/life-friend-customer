import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/pages/home/homePage.dart';
import 'package:pickup_load_update/src/widgets/button/primaryButton.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentIndex = 0;
  PageController? _controller;








  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }


  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  final numberTextC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: paddingH10V10,
          child: Column(
            children: [
              sizeH40,
              Image.asset(
                'assets/images/logo.png',
                scale: 2,
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: 4,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (_, i) {
                    return Padding(
                      padding: EdgeInsets.all(40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'fgg',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'dfgd',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    7,
                    (index) => buildDot(index, context),
                  ),
                ),
              ),
              sizeH30,
              SizedBox(
                height: 55,
                child: TextFormField(
                  controller: numberTextC,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: grey.shade300,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: grey.shade300,
                      ),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            sizeW10,
                            Image.asset(
                              'assets/images/bdFlag.png',
                              width: 35,
                            ),
                            sizeW10,
                            KText(
                              text: '+880',
                              color: black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                    contentPadding: EdgeInsets.only(left: 5),
                    hintText: 'enterPhoneNumber'.tr,
                    hintStyle: TextStyle(
                      color: black45,
                    ),
                  ),
                ),
              ),
              sizeH20,
              primaryButton(
                buttonName: 'continue'.tr,
                onTap: () => Get.to(HomePage()),
              ),
              sizeH10,
            ],
          ),
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        border: Border.all(color: currentIndex != index ? grey : transparent),
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? primaryColor : null,
      ),
    );
  }
}
