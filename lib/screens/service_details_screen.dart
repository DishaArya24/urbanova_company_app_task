import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;
  final String detail;
  final LinearGradient gradient;
  final String image;
  final List<String> features;

  const ServiceDetailsScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
    required this.detail,
    required this.gradient,
    required this.image,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      // =========================================================
      // APP BAR
      // =========================================================

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: AppColors.navyBlue,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.navyBlue,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      // =========================================================
      // BODY
      // =========================================================

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHero(),

            Padding(
              padding: const EdgeInsets.fromLTRB(
                24,
                32,
                24,
                40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // =====================================================
                  // OVERVIEW
                  // =====================================================

                  const Text(
                    'Overview',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: AppColors.navyBlue,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.7,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // =====================================================
                  // DETAILS
                  // =====================================================

                  Text(
                    detail,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.7,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 35),

                  // =====================================================
                  // WHAT WE OFFER
                  // =====================================================

                  const Text(
                    'What we offer',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: AppColors.navyBlue,
                    ),
                  ),

                  const SizedBox(height: 18),

                  if (features.isEmpty)
                    Text(
                      'No features available.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    )
                  else
                    ...features.map(
                      (feature) => _buildFeature(feature),
                    ),

                  const SizedBox(height: 25),

                  // =====================================================
                  // BACK BUTTON
                  // =====================================================

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.deepBlue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          vertical: 17,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        'Back to Services',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
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

  // =========================================================
  // HERO
  // =========================================================

  Widget _buildHero() {
    return SizedBox(
      width: double.infinity,
      height: 350,
      child: Stack(
        children: [
          // ---------------------------------------------------------
          // BACKGROUND IMAGE
          // ---------------------------------------------------------

          Positioned.fill(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              errorBuilder: (
                context,
                error,
                stackTrace,
              ) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: gradient,
                  ),
                );
              },
            ),
          ),

          // ---------------------------------------------------------
          // DARK OVERLAY
          // ---------------------------------------------------------

          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.15),
                    Colors.black.withOpacity(0.78),
                  ],
                ),
              ),
            ),
          ),

          // ---------------------------------------------------------
          // HERO CONTENT
          // ---------------------------------------------------------

          Positioned(
            left: 24,
            right: 24,
            bottom: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    gradient: gradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 28,
                  ),
                ),

                const SizedBox(height: 18),

                // Title
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    height: 1.05,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // FEATURE CARD
  // =========================================================

  Widget _buildFeature(String feature) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE8ECF4),
        ),
      ),
      child: Row(
        children: [
          // ---------------------------------------------------------
          // CHECK ICON
          // ---------------------------------------------------------

          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              gradient: gradient,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 19,
            ),
          ),

          const SizedBox(width: 12),

          // ---------------------------------------------------------
          // FEATURE TEXT
          // ---------------------------------------------------------

          Expanded(
            child: Text(
              feature,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.navyBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
