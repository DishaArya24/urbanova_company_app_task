import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'service_details_screen.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTopBar(),
              _buildHero(),
              _buildIntro(),

              // BUILD
              _buildBuildSection(),

              // DESIGN
              _buildDesignSection(),

              // GROW
              _buildMarketingSection(),

              _buildFinalCTA(),
              _buildFooter(),
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
    return Container(
      color: const Color(0xFF050D24),
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 14,
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(width: 11),

          const Text(
            'URBANOVA',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),

          const Spacer(),

          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 20,
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        24,
        60,
        24,
        65,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF050D24),
            Color(0xFF001B55),
            Color(0xFF003EBE),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOut,
        ),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.08),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Curves.easeOutCubic,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LABEL
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.14),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.auto_awesome_rounded,
                      size: 14,
                      color: AppColors.limeGreen,
                    ),
                    SizedBox(width: 7),
                    Text(
                      'WHAT WE DO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.8,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                'SERVICES',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 4,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Ideas into\nimpact.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 54,
                  height: 0.98,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -2.5,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'From technology and design to marketing and growth, '
                'we help businesses build, launch and grow digitally.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.68),
                  fontSize: 16,
                  height: 1.6,
                ),
              ),

              const SizedBox(height: 35),

              // STATS
              Row(
                children: [
                  _heroStat(
                    '06',
                    'Key services',
                  ),

                  const SizedBox(width: 28),

                  Container(
                    height: 35,
                    width: 1,
                    color: Colors.white24,
                  ),

                  const SizedBox(width: 28),

                  _heroStat(
                    '03',
                    'Core areas',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _heroStat(
    String value,
    String label,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w900,
          ),
        ),

        const SizedBox(height: 3),

        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // INTRO
  // ============================================================

  Widget _buildIntro() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        24,
        60,
        24,
        35,
      ),
      color: const Color(0xFFF5F7FB),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _eyebrow('OUR EXPERTISE'),

          const SizedBox(height: 14),

          const Text(
            'Everything you need\nto move forward.',
            style: TextStyle(
              color: AppColors.navyBlue,
              fontSize: 34,
              height: 1.05,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.3,
            ),
          ),

          const SizedBox(height: 15),

          Text(
            'Explore our services and discover how Urbanova '
            'can help turn your business goals into digital results.',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  Widget _buildBuildSection() {
    final services = [
      _ServiceData(
        title: 'Software Development',
        description:
            'Scalable software solutions built around your business.',
        image: 'assets/images/custom_sw.jpg',
        icon: Icons.code_rounded,
        gradient: AppColors.blueGradient,
        detail:
            'Urbanova helps businesses transform ideas into reliable '
            'software products designed around their real requirements. '
            'From planning and development to deployment, we create '
            'solutions that are scalable, practical and built for growth.',
      ),

      _ServiceData(
        title: 'Web & App Development',
        description:
            'Modern digital experiences across every screen.',
        image: 'assets/images/WebApp.jpg',
        icon: Icons.phone_android_rounded,
        gradient: AppColors.greenGradient,
        detail:
            'Urbanova creates modern websites and mobile applications '
            'that combine clean design, smooth experiences and reliable '
            'technology to help businesses connect with their customers.',
      ),
    ];

    return _buildServiceCategory(
      number: '01',
      title: 'BUILD',
      subtitle: 'Technology & Digital Products',
      description:
          'Turning ideas into useful digital products.',
      services: services,
      dark: false,
    );
  }

  // ============================================================
  // DESIGN
  // ============================================================

  Widget _buildDesignSection() {
    final services = [
      _ServiceData(
        title: 'Brand & Logo Design',
        description:
            'Visual identities that make your brand memorable.',
        image: 'assets/images/logo_brand.jpg',
        icon: Icons.brush_rounded,
        gradient: AppColors.greenGradient,
        detail:
            'Urbanova creates distinctive brand identities that help '
            'businesses communicate their personality and stand out. '
            'We focus on creating visual identities that are simple, '
            'recognizable and memorable.',
      ),

      _ServiceData(
        title: 'Graphic Design',
        description:
            'Creative visuals for your digital presence.',
        image: 'assets/images/graphic.jpg',
        icon: Icons.palette_rounded,
        gradient: AppColors.blueGradient,
        detail:
            'From social media creatives to marketing materials, '
            'Urbanova creates clean and engaging visual designs that '
            'keep your brand consistent across different platforms.',
      ),
    ];

    return _buildServiceCategory(
      number: '02',
      title: 'DESIGN',
      subtitle: 'Brand & Visual Experience',
      description:
          'Making your brand look as good as it performs.',
      services: services,
      dark: true,
    );
  }

  // ============================================================
  // GROW
  // ============================================================

  Widget _buildMarketingSection() {
    final services = [
      _ServiceData(
        title: 'Digital Marketing',
        description:
            'Strategies that turn attention into growth.',
        image: 'assets/images/video.jpg',
        icon: Icons.rocket_launch_rounded,
        gradient: AppColors.blueGradient,
        detail:
            'Urbanova helps businesses reach the right audience through '
            'digital marketing strategies focused on visibility, '
            'engagement and measurable business results.',
      ),

      _ServiceData(
        title: 'Social Media & SEO',
        description:
            'Build visibility and meaningful online connections.',
        image: 'assets/images/img4.jpg',
        icon: Icons.trending_up_rounded,
        gradient: AppColors.greenGradient,
        detail:
            'Urbanova combines social media and SEO strategies to help '
            'businesses get discovered, build a stronger online presence '
            'and create meaningful connections with their audience.',
      ),
    ];

    return _buildServiceCategory(
      number: '03',
      title: 'GROW',
      subtitle: 'Marketing & Growth',
      description:
          'Helping your business reach more people and grow.',
      services: services,
      dark: false,
    );
  }

  // ============================================================
  // SERVICE CATEGORY
  // ============================================================

  Widget _buildServiceCategory({
    required String number,
    required String title,
    required String subtitle,
    required String description,
    required List<_ServiceData> services,
    required bool dark,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        24,
        55,
        24,
        60,
      ),
      color: dark
          ? const Color(0xFF06122E)
          : const Color(0xFFF5F7FB),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ======================================================
          // CATEGORY HEADER
          // ======================================================

          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: title == 'DESIGN'
                      ? AppColors.greenGradient
                      : AppColors.blueGradient,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    number,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 14),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: dark
                          ? Colors.white
                          : AppColors.navyBlue,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    subtitle,
                    style: TextStyle(
                      color: dark
                          ? Colors.white54
                          : Colors.grey.shade600,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          Text(
            description,
            style: TextStyle(
              color: dark
                  ? Colors.white70
                  : Colors.grey.shade600,
              fontSize: 14,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 30),

          // ======================================================
          // TWO SERVICES
          // ======================================================

          ...services.asMap().entries.map(
            (entry) {
              final isLast =
                  entry.key == services.length - 1;

              return _buildTimelineService(
                service: entry.value,
                dark: dark,
                isLast: isLast,
                index: entry.key,
              );
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TIMELINE SERVICE
  // ============================================================

  Widget _buildTimelineService({
    required _ServiceData service,
    required bool dark,
    required bool isLast,
    required int index,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: 0,
        end: 1,
      ),
      duration: Duration(
        milliseconds: 500 + (index * 150),
      ),
      curve: Curves.easeOutCubic,
      builder: (
        context,
        value,
        child,
      ) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(
              0,
              20 * (1 - value),
            ),
            child: child,
          ),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ======================================================
          // DOT + LINE
          // ======================================================

          SizedBox(
            width: 25,
            child: Column(
              children: [
                Container(
                  width: 11,
                  height: 11,
                  decoration: BoxDecoration(
                    gradient: service.gradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.deepBlue
                            .withOpacity(0.20),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),

                if (!isLast)
                  Container(
                    width: 1.5,
                    height: 275,
                    margin: const EdgeInsets.only(
                      top: 8,
                    ),
                    color: dark
                        ? Colors.white12
                        : AppColors.deepBlue
                            .withOpacity(0.12),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // ======================================================
          // SERVICE CONTENT
          // ======================================================

          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ServiceDetailsScreen(
                      title: service.title,
                      description: service.detail,
                      icon: service.icon,
                      gradient: service.gradient,
                      image: service.image,
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(
                  bottom: 25,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    // IMAGE
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(22),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 220,
                            child: Image.asset(
                              service.image,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (
                                context,
                                error,
                                stackTrace,
                              ) {
                                return Container(
                                  color:
                                      const Color(
                                    0xFFE8ECF4,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons
                                          .image_not_supported_outlined,
                                      size: 40,
                                      color:
                                          Colors.grey,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          // IMAGE GRADIENT
                          Positioned.fill(
                            child: DecoratedBox(
                              decoration:
                                  BoxDecoration(
                                gradient:
                                    LinearGradient(
                                  begin:
                                      Alignment.topCenter,
                                  end:
                                      Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black
                                        .withOpacity(
                                      0.65,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // ICON
                          Positioned(
                            top: 15,
                            right: 15,
                            child: Container(
                              width: 42,
                              height: 42,
                              decoration:
                                  BoxDecoration(
                                color: Colors.black
                                    .withOpacity(
                                  0.25,
                                ),
                                shape:
                                    BoxShape.circle,
                                border:
                                    Border.all(
                                  color: Colors
                                      .white
                                      .withOpacity(
                                    0.25,
                                  ),
                                ),
                              ),
                              child: Icon(
                                service.icon,
                                color:
                                    Colors.white,
                                size: 20,
                              ),
                            ),
                          ),

                          // IMAGE TITLE
                          Positioned(
                            left: 18,
                            right: 18,
                            bottom: 18,
                            child: Text(
                              service.title,
                              style:
                                  const TextStyle(
                                color:
                                    Colors.white,
                                fontSize: 21,
                                fontWeight:
                                    FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // DESCRIPTION
                    Text(
                      service.description,
                      style: TextStyle(
                        color: dark
                            ? Colors.white60
                            : Colors.grey.shade600,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // VIEW DETAILS
                    Row(
                      children: [
                        Text(
                          'Explore service',
                          style: TextStyle(
                            color:
                                dark
                                    ? AppColors
                                        .limeGreen
                                    : AppColors
                                        .deepBlue,
                            fontSize: 12,
                            fontWeight:
                                FontWeight.w800,
                          ),
                        ),

                        const SizedBox(width: 6),

                        Icon(
                          Icons
                              .arrow_forward_rounded,
                          size: 15,
                          color: dark
                              ? AppColors.limeGreen
                              : AppColors.deepBlue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FINAL CTA
  // ============================================================

  Widget _buildFinalCTA() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.fromLTRB(
        25,
        40,
        25,
        40,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF001465),
            Color(0xFF003EBE),
            Color(0xFF0761DA),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Not sure what\nyou need?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              height: 1,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.5,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            'Tell us about your idea or challenge. '
            'We will help you figure out the right solution.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 25),

          ElevatedButton(
            onPressed: () {
              // Navigate to ContactScreen here.
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  AppColors.limeGreen,
              foregroundColor:
                  AppColors.navyBlue,
              elevation: 0,
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 15,
              ),
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(14),
              ),
            ),
            child: const Row(
              mainAxisSize:
                  MainAxisSize.min,
              children: [
                Text(
                  'Let’s talk',
                  style: TextStyle(
                    fontWeight:
                        FontWeight.w900,
                  ),
                ),

                SizedBox(width: 8),

                Icon(
                  Icons
                      .arrow_forward_rounded,
                  size: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FOOTER
  // ============================================================

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        25,
        35,
        25,
        35,
      ),
      color: const Color(0xFF050D24),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: [
                  Color(0xFF0761DA),
                  Color(0xFF7CD523),
                ],
              ).createShader(bounds);
            },
            child: const Text(
              'URBANOVA',
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.w900,
                letterSpacing: 3,
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Technology • Design • Growth',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 11,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 22),

          const Text(
            '© 2026 Urbanova Technologies Private Limited',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white30,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // EYEBROW
  // ============================================================

  Widget _eyebrow(String text) {
    return Row(
      children: [
        Container(
          width: 23,
          height: 3,
          decoration: BoxDecoration(
            color: AppColors.limeGreen,
            borderRadius:
                BorderRadius.circular(10),
          ),
        ),

        const SizedBox(width: 8),

        Text(
          text,
          style: const TextStyle(
            color: AppColors.deepBlue,
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// SERVICE DATA MODEL
// ============================================================

class _ServiceData {
  final String title;
  final String description;
  final String detail;
  final String image;
  final IconData icon;
  final LinearGradient gradient;

  const _ServiceData({
    required this.title,
    required this.description,
    required this.detail,
    required this.image,
    required this.icon,
    required this.gradient,
  });
}