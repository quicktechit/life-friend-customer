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
    Key? key,
  }) : super(key: key);

  @override
  State<CustomCommonAppBar> createState() => _CustomCommonAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}

class _CustomCommonAppBarState extends State<CustomCommonAppBar> {
  final NotificationController _notificationController = Get.put(
    NotificationController(),
  );

  @override
  void initState() {
    super.initState();
    _notificationController.getNotification();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor,
            primaryColor.withOpacity(0.9),
            primaryColor.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            widget.title.tr,
            key: ValueKey(widget.title),
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        centerTitle: true,
        leading: _buildLeadingWidget(),
        actions: _buildActionWidgets(),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
    );
  }

  Widget _buildLeadingWidget() {
    if (widget.isReturn == true) {
      return IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        onPressed: () => Navigator.maybePop(context),
        splashRadius: 20,
        tooltip: 'Back',
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => widget.scaffoldKey?.currentState?.openDrawer(),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.2),
            ),
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
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            widget.onFilterPressed?.call();
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) =>
                  Container(
                    decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: CustomBottomSheetWidget(),
                  ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'filter'.tr,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(Icons.filter_alt_rounded, size: 18, color: primaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationButton() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => Get.to(() => const NotificationsPage()),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.2),
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
        ),
        if (widget.showNotificationBadge)
          Positioned(
            top: 8,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              child: Obx(() {
                return Text(
                  _notificationController.notificationData.length > 9
                      ? '9+'
                      : _notificationController.notificationData.length
                      .toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                );
              }),
            ),
          ),
      ],
    );
  }
}
