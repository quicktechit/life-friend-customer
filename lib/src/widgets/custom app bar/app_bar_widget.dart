import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/controllers/notification%20controller/notification_controller.dart';
import 'package:pickup_load_update/src/pages/notification%20page/notification_page.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

import '../return_trip_filter_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool? isReturn;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final VoidCallback? onFilterPressed;
  final bool showNotificationBadge;

  const CustomCommonAppBar({
    required this.title,
    this.isReturn,
    this.scaffoldKey,
    this.onFilterPressed,
    this.showNotificationBadge = true,
    super.key,
  });

  @override
  State<CustomCommonAppBar> createState() => _CustomCommonAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 15);
}

class _CustomCommonAppBarState extends State<CustomCommonAppBar>
    with SingleTickerProviderStateMixin {
  final NotificationController _notificationController = Get.put(
    NotificationController(),
  );

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _notificationController.getNotification();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: primaryColor,

      iconTheme: const IconThemeData(color: Colors.white),
      title: ScaleTransition(
        scale: _scaleAnimation,
        child: Text(
          widget.title.tr,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 19.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      centerTitle: true,
      leading: _buildLeadingWidget(),
      actions: _buildActionWidgets(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(13),
          bottomRight: Radius.circular(13),
        ),
      ),
    );
  }

  Widget _buildLeadingWidget() {
    if (widget.isReturn == true) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => Navigator.maybePop(context),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white.withAlpha(80),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => widget.scaffoldKey?.currentState?.openDrawer(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white.withOpacity(0.2),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              "assets/images/app.png",
              width: 24,
              height: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildActionWidgets() {
    if (widget.isReturn == true) {
      return [_buildFilterButton(), const SizedBox(width: 12)];
    }

    return [_buildNotificationButton(), const SizedBox(width: 12)];
  }

  Widget _buildFilterButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            widget.onFilterPressed?.call();
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(100),
                      blurRadius: 20,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    CustomBottomSheetWidget(),
                  ],
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.tune_rounded, size: 18, color: primaryColor),
                const SizedBox(width: 6),
                Text(
                  'filter'.tr,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => Get.to(() => const NotificationsPage()),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white.withAlpha(50),
                  border: Border.all(
                    color: Colors.white.withAlpha(70),
                    width: 1,
                  ),
                ),
                child: Image.asset(
                  "assets/images/notification.png",
                  width: 22,
                  height: 22,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          if (widget.showNotificationBadge)
            Positioned(
              top: -4,
              right: -4,
              child: Obx(() {
                final count = _notificationController.notificationData.length;
                if (count == 0) return const SizedBox.shrink();
                return Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFef4444), Color(0xFFdc2626)],
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.5),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                  child: Text(
                    count > 9 ? '9+' : count.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }),
            ),
        ],
      ),
    );
  }
}
