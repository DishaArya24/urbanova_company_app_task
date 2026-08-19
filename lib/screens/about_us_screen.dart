import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(),

              _buildHero(),

              _buildWhyUrbanova(),

              _buildMission(),

              _buildHowWeWork(),

              _buildCollaboration(),

              _buildCompanyInfo(),

              _buildBottom(),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // TOP BAR
  // ============================================================

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 10,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.deepBlue,
            ),
          ),

          const Spacer(),

          ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: [
                  Color(0xFF003EBE),
                  Color(0xFF00AEEF),
                  Color(0xFF7AC943),
                ],
              ).createShader(bounds);
            },
            child: const Text(
              'Urbanova',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HERO
  // ============================================================

  Widget _buildHero() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            28,
            50,
            28,
            35,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('ABOUT US'),

              const SizedBox(height: 22),

              const Text(
                'Built to be your\none technology partner.',
                style: TextStyle(
                  fontSize: 39,
                  height: 1.05,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.6,
                  color: AppColors.navyBlue,
                ),
              ),

              const SizedBox(height: 22),

              Text(
                'Software development, brand design, '
                'and performance marketing — together '
                'under one team.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.65,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 30),

              Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.limeGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // WHY URBANOVA
  // ============================================================

  Widget _buildWhyUrbanova() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImagePlaceholder(
          imagePath: 'assets/images/bnglr.jpg',
          height: 230,
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(
            28,
            35,
            28,
            20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('WHY URBANOVA'),

              const SizedBox(height: 18),

              const Text(
                'Everything works better\ntogether.',
                style: TextStyle(
                  fontSize: 29,
                  height: 1.15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.navyBlue,
                ),
              ),

              const SizedBox(height: 17),

              Text(
                'We started Urbanova because businesses were '
                'tired of stitching their product, their brand, '
                'and their growth together across three separate '
                'vendors who never talked to each other.',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.7,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // MISSION
  // ============================================================

  Widget _buildMission() {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        24,
        35,
        24,
        25,
      ),
      padding: const EdgeInsets.all(27),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF003EBE),
            Color(0xFF0058D4),
            Color(0xFF008BD0),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color:Color(0xFFDCE7F5),
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'OUR MISSION',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            'Three capabilities.\nOne team.',
            style: TextStyle(
              fontSize: 31,
              height: 1.12,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 18),

          Text(
            'Give growing businesses access to product, '
            'design, and marketing expertise that usually '
            'only comes from three separate specialist '
            'agencies — coordinated as one team, working '
            'toward the same outcome.',
            style: TextStyle(
              fontSize: 15,
              height: 1.7,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 25),

          Row(
            children: [
              _missionItem('01', 'Product'),
              _missionItem('02', 'Design'),
              _missionItem('03', 'Marketing'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _missionItem(String number, String title) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: Color(0xFFB8F34A),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // =======================-
  
  // HOW WE WORK
  // ============================================================

  Widget _buildHowWeWork() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        28,
        55,
        28,
        30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('HOW WE WORK'),

          const SizedBox(height: 20),

          const Text(
            'Small, senior team.',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: AppColors.navyBlue,
            ),
          ),

          const SizedBox(height: 15),

          Text(
            "Direct communication. We'd rather ship a working "
            "version and iterate with you than disappear for "
            "months behind a spec document.",
            style: TextStyle(
              fontSize: 15,
              height: 1.7,
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 28),

          _buildImagePlaceholder(
            imagePath: 'assets/images/tech.jpg',
            height: 210,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // COLLABORATION
  // ============================================================

  Widget _buildCollaboration() {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      padding: const EdgeInsets.fromLTRB(
        28,
        45,
        28,
        50,
      ),
      color: const Color(0xFFF5F8FC),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('HOW WE COLLABORATE'),

          const SizedBox(height: 20),

          const Text(
            'Direct access to the\npeople doing the work.',
            style: TextStyle(
              fontSize: 29,
              height: 1.15,
              fontWeight: FontWeight.w800,
              color: AppColors.navyBlue,
            ),
          ),

          const SizedBox(height: 17),

          Text(
            'You talk to the person building your software '
            'or running your campaign — not a rotating cast '
            'of account managers relaying messages back and forth.',
            style: TextStyle(
              fontSize: 15,
              height: 1.7,
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 28),

          _buildImagePlaceholder(
            imagePath: 'assets/images/senior.jpg',
            height: 220,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // COMPANY INFORMATION
  // ============================================================

  Widget _buildCompanyInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        28,
        55,
        28,
        45,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('COMPANY INFORMATION'),

          const SizedBox(height: 28),

          _infoItem(
            'LEGAL NAME',
            'Urbanova Technologies Private Limited',
          ),

          _infoDivider(),

          _infoItem(
            'CIN',
            'U62099KA2026PTC224243',
          ),

          _infoDivider(),

          _infoItem(
            'REGISTERED OFFICE',
            'No.28, St Bed 80ft Road, Koramangala, '
            'Bangalore South, Bangalore, Karnataka, India, 560034',
          ),
        ],
      ),
    );
  }

  Widget _infoItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.3,
            color: AppColors.emeraldGreen,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            height: 1.5,
            fontWeight: FontWeight.w600,
            color: AppColors.navyBlue,
          ),
        ),
      ],
    );
  }

  Widget _infoDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Divider(
        color: Colors.grey.shade200,
        height: 1,
      ),
    );
  }

  // ============================================================
  // BOTTOM
  // ============================================================

  Widget _buildBottom() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 28,
        vertical: 55,
      ),
      color: AppColors.navyBlue,
      child: Column(
        children: [
          const Text(
            'URBANOVA TECHNOLOGIES',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.8,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            'Technology.\nBranding. Growth.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 27,
              height: 1.15,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 22),

          Container(
            width: 42,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.limeGreen,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // IMAGE
  // ============================================================

  Widget _buildImagePlaceholder({
    required String imagePath,
    required double height,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          imagePath,
          width: double.infinity,
          height: height,
          fit: BoxFit.cover,

          // If you haven't added the image yet,
          // the app won't crash.
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: height,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFEAF1FF),
                    Color(0xFFF5F8FC),
                  ],
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.image_outlined,
                  size: 55,
                  color: AppColors.deepBlue,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // LABEL
  // ============================================================

  Widget _label(String text) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.limeGreen,
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        const SizedBox(width: 10),

        Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
            color: AppColors.deepBlue,
          ),
        ),
      ],
    );
  }
}