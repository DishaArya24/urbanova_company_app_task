import 'package:flutter/material.dart';

class ServiceModel {
  final int id;
  final String category;
  final String categorySubtitle;
  final String title;
  final String description;
  final String detail;
  final String image;
  final String icon;
  final String gradient;
  final List<String> features;

  const ServiceModel({
    required this.id,
    required this.category,
    required this.categorySubtitle,
    required this.title,
    required this.description,
    required this.detail,
    required this.image,
    required this.icon,
    required this.gradient,
    required this.features,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] ?? 0,
      category: json['category'] ?? '',
      categorySubtitle: json['categorySubtitle'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      detail: json['detail'] ?? '',
      image: json['image'] ?? '',
      icon: json['icon'] ?? '',
      gradient: json['gradient'] ?? 'blue',
      features: List<String>.from(
        json['features'] ?? [],
      ),
    );
  }

  // ============================================================
  // ICON
  // ============================================================

  IconData get iconData {
    switch (icon) {
      case 'code':
        return Icons.code_rounded;

      case 'phone_android':
        return Icons.phone_android_rounded;

      case 'brush':
        return Icons.brush_rounded;

      case 'palette':
        return Icons.palette_rounded;

      case 'rocket':
        return Icons.rocket_launch_rounded;

      case 'trending_up':
        return Icons.trending_up_rounded;

      default:
        return Icons.miscellaneous_services_rounded;
    }
  }

  // ============================================================
  // GRADIENT
  // ============================================================

  LinearGradient get gradientData {
    switch (gradient) {
      case 'green':
        return const LinearGradient(
          colors: [
            Color(0xFF7CD523),
            Color(0xFF089934),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );

      case 'blue':
      default:
        return const LinearGradient(
          colors: [
            Color(0xFF001465),
            Color(0xFF003EBE),
            Color(0xFF0761DA),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }
}