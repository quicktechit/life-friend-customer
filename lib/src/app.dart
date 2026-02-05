import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appTheme.dart';
import 'package:pickup_load_update/src/pages/home/rental/rentalListPage.dart';
import 'package:pickup_load_update/src/pages/welcome%20screen/welcome_screen.dart';
import 'controllers/language/langController.dart';
import 'localization/translation.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final langController = Get.put(LangController());
    langController.getDefaultLang();
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) {
          return GetMaterialApp(
            translations: Translation(),
            theme: AppTheme.appTheme,
            locale: langController.selectedLang.value,
            fallbackLocale: const Locale('en', 'US'),
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            defaultTransition: Transition.fadeIn,
            getPages: [
              GetPage(
                name: '/',
                page: () => WelcomeScreen(),
                transition: Transition.zoom,
                transitionDuration: Duration(milliseconds: 300),
              ),
              GetPage(
                name: '/rental',
                page: () => RentalListPage(tripType: 'car',),
                transition: Transition.rightToLeft,
                transitionDuration: Duration(milliseconds: 500),
              ),

            ],
          );
        });
  }
}
