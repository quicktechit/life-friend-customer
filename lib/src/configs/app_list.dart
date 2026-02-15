// Enhanced Quick Services with better icons and descriptions

import 'package:flutter/material.dart';

final List<ServiceItem> quickServices = [
  ServiceItem(
    title: 'প্রাইভেট',
    subtitle: 'Private Car Service',
    icon: '🚗',
    // Premium Blue
    gradient: [Color(0xFF1E3C72), Color(0xFF4076D3)],
    onTap: 'carRental',
  ),
  ServiceItem(
    title: 'মাইক্রোবাস',
    subtitle: 'Microbus Service',
    icon: '🚐',
    // Fresh Teal (Group/Family vibe)
    gradient: [Color(0xFF11998E), Color(0xFF38EF7D)],
    onTap: 'carRental',
  ),
  ServiceItem(
    title: 'এ্যাম্বুলেন্স',
    subtitle: 'Emergency Service',
    icon: '🚑',
    // Emergency Red
    gradient: [Color(0xFFCB2D3E), Color(0xFFEF473A)],
    onTap: 'ambulance',
  ),
  ServiceItem(
    title: 'লাশবাহী',
    subtitle: 'Funeral Transport',
    icon: '⚰️',
    // Calm Grey-Blue (Respectful tone)
    gradient: [Color(0xFF474747), Color(0xFF989898)],
    onTap: 'ambulance',
  ),
  ServiceItem(
    title: 'রিটার্ন ট্রিপ',
    subtitle: 'Return Journey',
    icon: '🔁',
    gradient: [Color(0xFF654EA3), Color(0xFFEAafc8)],
    onTap: 'returnTruck',
  ),
  ServiceItem(
    title: 'ট্রাক',
    subtitle: 'Truck Transport',
    icon: '🚚',
    // Industrial Orange
    gradient: [Color(0xFFF2994A), Color(0xFFF2C94C)],
    onTap: 'truckRental',
  ),
  ServiceItem(
    title: 'এয়ারপোর্ট',
    subtitle: 'Pickup/Drop',
    icon: '✈️',
    // Sky Blue (Air/Travel feeling)
    gradient: [Color(0xFF2F80ED), Color(0xFF56CCF2)],
    onTap: 'airport',
  ),
];

// Enhanced Featured Services
final List<FeatureCard> featuredServices = [
  FeatureCard(
    name: "Truck Rental",
    tagline: "Heavy Loads",
    image: 'assets/new_image/truck.jpg',
    type: 'truckRental',
    icon: Icons.local_shipping,
    color: Color(0xFF3B82F6),
    rating: 4.7,
  ),
  FeatureCard(
    name: "Return Truck",
    tagline: "Round Trip",
    image: 'assets/new_image/truck2.jpeg',
    type: 'returnTruck',
    icon: Icons.swap_horiz,
    color: Color(0xFF10B981),
    rating: 4.8,
  ),
  FeatureCard(
    name: "Airport Service",
    tagline: "Pickup & Drop",
    image: 'assets/new_image/airport_image.jpg',
    // make sure you have this image
    type: 'airport',
    icon: Icons.airplanemode_active,
    color: Color(0xFFFFA500),
    // Orange for travel
    rating: 4.8,
  ),
  FeatureCard(
    name: "Luxury Cars",
    tagline: "Premium Experience",
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
