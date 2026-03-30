// Enhanced Quick Services with better icons and descriptions

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

final List<ServiceItem> quickServices = [
  ServiceItem(
    title: 'private'.tr,
    subtitle: 'pService'.tr,
    icon: '🚗',
    gradient: [Color(0xFF1E3C72), Color(0xFF4076D3)],
    onTap: 'carRental',
  ),
  ServiceItem(
    title: 'microbus'.tr,
    subtitle: 'microbusService'.tr,
    icon: '🚐',
    gradient: [Color(0xFF11998E), Color(0xFF38EF7D)],
    onTap: 'carRental',
  ),
  ServiceItem(
    title: 'ambulance'.tr,
    subtitle: 'emergencyService'.tr,
    icon: '🚑',
    gradient: [Color(0xFFCB2D3E), Color(0xFFEF473A)],
    onTap: 'ambulance',
  ),
  ServiceItem(
    title: 'funeral'.tr,
    subtitle: 'funeralTransport'.tr,
    icon: '⚰️',
    gradient: [Color(0xFF474747), Color(0xFF989898)],
    onTap: 'ambulance',
  ),
  ServiceItem(
    title: 'returnTrip'.tr,
    subtitle: 'returnJourney'.tr,
    icon: '🔁',
    gradient: [Color(0xFF654EA3), Color(0xFFEAafc8)],
    onTap: 'returnTruck',
  ),
  ServiceItem(
    title: 'truck'.tr,
    subtitle: 'truckTransport'.tr,
    icon: '🚚',
    gradient: [Color(0xFFF2994A), Color(0xFFF2C94C)],
    onTap: 'truckRental',
  ),
  ServiceItem(
    title: 'airport'.tr,
    subtitle: 'pickupDrop'.tr,
    icon: '✈️',
    gradient: [Color(0xFF2F80ED), Color(0xFF56CCF2)],
    onTap: 'airport',
  ),
];

// Enhanced Featured Services
final List<FeatureCard> featuredServices = [
  FeatureCard(
    name: 'truckRental'.tr,
    tagline: 'heavyLoads'.tr,
    image: 'assets/new_image/truck.jpg',
    type: 'truckRental',
    icon: Icons.local_shipping,
    color: Color(0xFF3B82F6),
    rating: 4.7,
  ),
  FeatureCard(
    name: 'returnTruck'.tr,
    tagline: 'roundTrip'.tr,
    image: 'assets/new_image/truck2.jpeg',
    type: 'returnTruck',
    icon: Icons.swap_horiz,
    color: Color(0xFF10B981),
    rating: 4.8,
  ),
  FeatureCard(
    name: 'airports'.tr,
    tagline: 'pickupDrop'.tr,
    image: 'assets/new_image/airport_image.jpg',
    type: 'airport',
    icon: Icons.airplanemode_active,
    color: Color(0xFFFFA500),
    rating: 4.8,
  ),
  FeatureCard(
    name: 'luxury'.tr,
    tagline: 'premiumExperience'.tr,
    image: 'assets/images/luxury.jpeg',
    type: 'luxury',
    icon: Icons.directions_car_filled,
    color: Color(0xFF8B5CF6),
    rating: 4.9,
  ),
];

class FeatureCard {
  final String name;
  final String tagline;
  final String image;
  final String type;
  final IconData icon;
  final Color color;
  final double rating;

  FeatureCard({
    required this.name,
    required this.tagline,
    required this.image,
    required this.type,
    required this.icon,
    required this.color,
    this.rating = 4.5,
  });
}

// Enhanced Helper Classes
class ServiceItem {
  final String title;
  final String subtitle;
  final String icon;
  final List<Color> gradient;
  final String onTap;

  ServiceItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.onTap,
  });
}
