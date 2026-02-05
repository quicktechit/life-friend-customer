import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';

import '../auth/AuthStartVerifyPage.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<CarOnboardingPage> _pages = [
    CarOnboardingPage(
      title: 'Discover Luxury',
      description:
          'Explore our collection of premium luxury vehicles with cutting-edge technology and superior comfort.',
      carImage:
          'https://images.unsplash.com/photo-1568068158767-9463ba730cf6?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      icon: Icons.auto_awesome,
      color: Colors.amber,
    ),
    CarOnboardingPage(
      title: 'Sports Performance',
      description:
          'Experience adrenaline with our high-performance sports cars engineered for speed and agility.',
      carImage:
          'https://images.unsplash.com/photo-1728060703475-d17c93c0b430?q=80&w=626&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      icon: Icons.speed,
      color: primaryColor,
    ),
    CarOnboardingPage(
      title: 'Electric Future',
      description:
          'Join the sustainable revolution with our range of fully electric vehicles and advanced charging solutions.',
      carImage:
          'https://images.unsplash.com/photo-1485291571150-772bcfc10da5?q=80&w=1228&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      icon: Icons.electric_car,
      color: Colors.green,
    ),
    CarOnboardingPage(
      title: 'SUV Adventure',
      description:
          'Conquer any terrain with our rugged yet luxurious SUVs designed for adventure and family comfort.',
      carImage:
          'https://images.unsplash.com/photo-1678952967835-c0141cd511e4?q=80&w=627&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      icon: Icons.landscape,
      color: Colors.blue,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Header with Skip button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Page indicator
                  Row(
                    children: List.generate(_pages.length, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 30 : 10,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? _pages[index].color
                              : Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),

                  // Skip button
                  if (_currentPage < _pages.length - 1)
                    const Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    // Title and Icon
                    sizeH20,
                    Row(
                      children: [
                        // Container(
                        //   width: 50,
                        //   height: 50,
                        //   decoration: BoxDecoration(
                        //     color: _pages[_currentPage].color.withOpacity(0.1),
                        //     borderRadius: BorderRadius.circular(15),
                        //   ),
                        //   child: Icon(
                        //     _pages[_currentPage].icon,
                        //     color: _pages[_currentPage].color,
                        //     size: 30,
                        //   ),
                        // ),
                        // const SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            _pages[_currentPage].title,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Description
                    Text(
                      _pages[_currentPage].description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: _pages.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return _buildCarPage(_pages[index]);
                    },
                  ),
                  Positioned(
                    left: 12,
                    right: 12,
                    bottom: 12,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentPage < _pages.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          _goToHomeScreen();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                        shadowColor: primaryColor.withAlpha(120),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _currentPage < _pages.length - 1
                                ? 'Continue'
                                : 'Get Started',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            _currentPage < _pages.length - 1
                                ? Icons.arrow_forward
                                : Icons.directions_car,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildCarPage(CarOnboardingPage page) {
    return Stack(
      children: [
        // Car Image
        Image.network(
          page.carImage,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                    : null,
                color: page.color,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[800],
              child: const Center(
                child: Icon(Icons.error_outline, color: Colors.white, size: 50),
              ),
            );
          },
        ),

        // Gradient Overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
              stops: const [0.5, 1.0],
            ),
          ),
        ),

        // Car Badge
        Positioned(
          top: 20,
          left: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: page.color.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(page.icon, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  page.title.split(' ').first,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Page Number
        Positioned(
          top: 20,
          right: 20,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                '${_pages.indexOf(page) + 1}',
                style: TextStyle(
                  color: page.color,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _goToHomeScreen() {
    Get.to(() => AuthStartPage());
  }
}

class CarOnboardingPage {
  final String title;
  final String description;
  final String carImage;
  final IconData icon;
  final Color color;

  CarOnboardingPage({
    required this.title,
    required this.description,
    required this.carImage,
    required this.icon,
    required this.color,
  });
}
