import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/pages/home/homePage.dart';
import 'package:pickup_load_update/src/pages/profile/profilePage.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../pages/Trip History/all trip/quick_tech_all_trip_history.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart'; // assuming you're using getx for .tr

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/notification page/notification_page.dart';

/// Material Design 3 Dashboard with Navigation Rail Style Bottom Bar
/// Features: Modern MD3 design, smooth animations, accessibility
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';

import '../drawer/sidebarComponent.dart';

/// iOS-Style Dashboard with Glassmorphism Effect
/// Features: Blurred background, smooth animations, premium feel
class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with TickerProviderStateMixin {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  int _selectedIndex = 0;
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  static const Color surfaceColor = Color(0xFFF2F2F7);

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      4,
          (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
      ),
    );
    _animations = _controllers
        .map((controller) => Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    ))
        .toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,

      child: Scaffold(
        key: scaffoldKey,
        drawer: Drawer(child: ExampleSidebarX(controller: _controller)),
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: surfaceColor,
        body: Stack(
          children: [
            // Content
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: _buildPage(_selectedIndex),
            ),
            // Bottom Navigation
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildGlassmorphicBottomNav(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassmorphicBottomNav() {
    return Container(
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(150),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withOpacity(0.5),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildGlassNavItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  index: 0,
                ),
                _buildGlassNavItem(
                  icon: Icons.history_rounded,
                  label: 'History',
                  index: 1,
                ),
                _buildGlassNavItem(
                  icon: Icons.person_rounded,
                  label: 'Profile',
                  index: 2,
                ),
                // _buildGlassNavItem(
                //   icon: Icons.settings_rounded,
                //   label: 'Settings',
                //   index: 3,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTapDown: (_) => _controllers[index].forward(),
      onTapUp: (_) {
        _controllers[index].reverse();
        setState(() => _selectedIndex = index);
      },
      onTapCancel: () => _controllers[index].reverse(),
      child: ScaleTransition(
        scale: _animations[index],
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          decoration: BoxDecoration(
            color: isSelected
                ? primaryColor.withAlpha(150)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? white : Colors.grey.shade600,
                size: isSelected ? 26 : 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? white : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const HomePage(key: ValueKey(0));
      case 1:
        return const QuickTechAllTripScreen(key: ValueKey(1));
      case 2:
        return ProfilePage(key: ValueKey(2));
      // case 3:
      //   return const SettingsPage(key: ValueKey(3));
      default:
        return const HomePage(key: ValueKey(0));
    }
  }

  Future<bool> _onWillPop() async {
    if (_selectedIndex != 0) {
      setState(() => _selectedIndex = 0);
      return false;
    }

    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => _buildExitDialog(),
    );

    return shouldExit ?? false;
  }

  Widget _buildExitDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.exit_to_app_rounded,
                color: Colors.red.shade400,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Exit App?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Are you sure you want to exit?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child:  Text('Exit',style:TextStyle(color:white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}