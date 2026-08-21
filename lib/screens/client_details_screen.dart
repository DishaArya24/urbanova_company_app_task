import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class ClientDetailsScreen extends StatelessWidget {
  final String clientName;
  final String category;
  final String image;
  final String description;

  const ClientDetailsScreen({
    super.key,
    required this.clientName,
    required this.category,
    required this.image,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      // ============================================================
      // APP BAR
      // ============================================================

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,

        iconTheme: const IconThemeData(
          color: AppColors.navyBlue,
        ),

        title: const Text(
          'Client',
          style: TextStyle(
            color: AppColors.navyBlue,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      // ============================================================
      // BODY
      // ============================================================

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroImage(),

            _buildClientContent(),

            _buildProjectSection(),

            _buildBottomCTA(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HERO IMAGE
  // ============================================================

  Widget _buildHeroImage() {
    return SizedBox(
      width: double.infinity,
      height: 280,
      child: Stack(
        children: [
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
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.navyBlue,
                        AppColors.deepBlue,
                        AppColors.skyBlue,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.business_rounded,
                      color: Colors.white,
                      size: 70,
                    ),
                  ),
                );
              },
            ),
          ),

          // DARK OVERLAY
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.72),
                  ],
                ),
              ),
            ),
          ),

          // CLIENT NAME
          Positioned(
            left: 24,
            right: 24,
            bottom: 25,
            child: Text(
              clientName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                height: 1.05,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CLIENT CONTENT
  // ============================================================

  Widget _buildClientContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        25,
        30,
        25,
        10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CATEGORY
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              gradient: AppColors.blueGradient,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              category,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // TITLE
          Text(
            clientName,
            style: const TextStyle(
              fontSize: 31,
              height: 1.1,
              fontWeight: FontWeight.w900,
              color: AppColors.navyBlue,
            ),
          ),

          const SizedBox(height: 18),

          // DESCRIPTION
          Text(
            description,
            style: TextStyle(
              fontSize: 15,
              height: 1.7,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PROJECT SECTION
  // ============================================================

  Widget _buildProjectSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        25,
        35,
        25,
        20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel('PROJECT'),

          const SizedBox(height: 15),

          const Text(
            'About the project',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              color: AppColors.navyBlue,
            ),
          ),

          const SizedBox(height: 14),

          Text(
            'Urbanova works with businesses to create meaningful '
            'digital experiences through technology, design and '
            'creative thinking.',
            style: TextStyle(
              fontSize: 15,
              height: 1.7,
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 25),

          _buildProjectCard(
            icon: Icons.lightbulb_outline_rounded,
            title: 'Digital Solutions',
            description:
                'Creating practical digital experiences designed '
                'around real business needs.',
          ),

          _buildProjectCard(
            icon: Icons.palette_outlined,
            title: 'Creative Experience',
            description:
                'Combining design and technology to create '
                'memorable customer experiences.',
          ),

          _buildProjectCard(
            icon: Icons.trending_up_rounded,
            title: 'Business Growth',
            description:
                'Helping businesses strengthen their digital '
                'presence and connect with their audience.',
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PROJECT CARD
  // ============================================================

  Widget _buildProjectCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE5EAF2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: AppColors.blueGradient,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 22,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.navyBlue,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BOTTOM CTA
  // ============================================================

  Widget _buildBottomCTA() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(
        20,
        30,
        20,
        30,
      ),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: AppColors.blueGradient,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Have a similar\nproject in mind?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 27,
              height: 1.1,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Let’s create something meaningful together.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: AppColors.limeGreen,
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Work with us',
                  style: TextStyle(
                    color: AppColors.navyBlue,
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                  ),
                ),
                SizedBox(width: 7),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.navyBlue,
                  size: 17,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION LABEL
  // ============================================================

  Widget _sectionLabel(String text) {
    return Row(
      children: [
        Container(
          width: 25,
          height: 3,
          decoration: BoxDecoration(
            color: AppColors.limeGreen,
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        const SizedBox(width: 9),

        Text(
          text,
          style: const TextStyle(
            color: AppColors.deepBlue,
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.8,
          ),
        ),
      ],
    );
  }
}