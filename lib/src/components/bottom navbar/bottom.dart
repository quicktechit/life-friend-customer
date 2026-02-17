import 'package:flutter/material.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/pages/home/homePage.dart';
import 'package:pickup_load_update/src/pages/profile/profilePage.dart';
import 'package:sidebarx/sidebarx.dart';
import '../../pages/Trip History/all trip/quick_tech_all_trip_history.dart';
import '../drawer/sidebarComponent.dart';

/// iOS-Style Dashboard with Glassmorphism Effect
/// Features: Blurred background, smooth animations, premium feel
class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  int _selectedIndex = 0;

  static const Color surfaceColor = Color(0xFFF2F2F7);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: scaffoldKey,
        drawer: Drawer(child: ExampleSidebarX(controller: _controller)),
        backgroundColor: surfaceColor,

        // ✅ Normal Bottom Navigation Bar
        bottomNavigationBar: SafeArea(
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: primaryColor,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history_rounded),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: 'Profile',
              ),
            ],
          ),
        ),

        // ✅ Page Content
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: _buildPage(_selectedIndex),
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
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                    child: Text('Exit', style: TextStyle(color: white)),
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
