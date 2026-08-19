import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'about_us_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _isButtonHovered = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ---------------------------------------------------------
      // DRAWER
      // ---------------------------------------------------------

      endDrawer: _buildMobileDrawer(),

      // ---------------------------------------------------------
      // BODY
      // ---------------------------------------------------------

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 700;

            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildNavbar(isMobile),
                  _buildHero(isMobile),
                  _buildServices(isMobile),
                  _buildWhoWeAre(isMobile),
                  _buildWhyUrbanova(isMobile),
                  _buildCTA(isMobile),
                  _buildFooter(isMobile),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // NAVBAR
  // ============================================================

  Widget _buildNavbar(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 16,
      ),
      child: Row(
        children: [
          // LOGO
          Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 38,
                height: 38,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 10),

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
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const Spacer(),

          if (!isMobile) ...[
            _buildNavText('Home'),
            _buildNavText('Services'),
            _buildNavText('About Us'),
            _buildNavText('Contact'),
          ],

          // HAMBURGER
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu_rounded,
                  size: 28,
                ),
                color: AppColors.navyBlue,
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.navyBlue,
        ),
      ),
    );
  }

  // ============================================================
  // HERO
  // ============================================================

  Widget _buildHero(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        isMobile ? 24 : 70,
        isMobile ? 45 : 80,
        isMobile ? 24 : 70,
        isMobile ? 50 : 80,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFF4F8FF),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: isMobile
          ? _buildMobileHero()
          : _buildDesktopHero(),
    );
  }

  Widget _buildDesktopHero() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // LEFT
        Expanded(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _smallLabel('DIGITAL PARTNER'),

                  const SizedBox(height: 22),

                  const Text(
                    'Build experiences\nthat move business\nforward.',
                    style: TextStyle(
                      fontSize: 54,
                      height: 1.05,
                      fontWeight: FontWeight.w800,
                      color: AppColors.navyBlue,
                      letterSpacing: -2,
                    ),
                  ),

                  const SizedBox(height: 22),

                  Text(
                    'We combine technology, creative thinking, '
                    'and strategic execution to help businesses '
                    'turn ideas into meaningful digital experiences.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.6,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 30),

                  _buildPrimaryButton(),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 60),

        // RIGHT IMAGE
        Expanded(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Image.asset(
                'assets/images/hero.jpg',
                height: 430,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileHero() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _smallLabel('DIGITAL PARTNER'),

            const SizedBox(height: 20),

            const Text(
              'Build experiences\nthat move business\nforward.',
              style: TextStyle(
                fontSize: 40,
                height: 1.05,
                fontWeight: FontWeight.w800,
                color: AppColors.navyBlue,
                letterSpacing: -1.5,
              ),
            ),

            const SizedBox(height: 18),

            Text(
              'We turn ideas into meaningful digital experiences.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 25),

            _buildPrimaryButton(),

            const SizedBox(height: 35),

            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image.asset(
                'assets/images/hero.jpg',
                width: double.infinity,
                height: 230,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _smallLabel(String text) {
    return Row(
      children: [
        Container(
          width: 28,
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

  Widget _buildPrimaryButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _isButtonHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isButtonHovered = false;
        });
      },
      child: AnimatedScale(
        scale: _isButtonHovered ? 1.03 : 1,
        duration: const Duration(milliseconds: 180),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.deepBlue,
            foregroundColor: Colors.white,
            elevation: 3,
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Explore Our Services',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_rounded,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SERVICES
  // ============================================================

  Widget _buildServices(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 70,
        vertical: 75,
      ),
      child: Column(
        children: [
          _smallLabel('WHAT WE DO'),

          const SizedBox(height: 18),

          const Text(
            'Solutions built around\nyour business.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 34,
              height: 1.15,
              fontWeight: FontWeight.w800,
              color: AppColors.navyBlue,
            ),
          ),

          const SizedBox(height: 45),

          isMobile
              ? Column(
                  children: [
                    _serviceCard(
                      Icons.code_rounded,
                      'Software Development',
                      'Digital products built to solve real business problems.',
                    ),
                    const SizedBox(height: 18),
                    _serviceCard(
                      Icons.auto_awesome_rounded,
                      'Brand Design',
                      'Visual identities that make businesses memorable.',
                    ),
                    const SizedBox(height: 18),
                    _serviceCard(
                      Icons.trending_up_rounded,
                      'Performance Marketing',
                      'Strategies designed to turn attention into growth.',
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _serviceCard(
                        Icons.code_rounded,
                        'Software Development',
                        'Digital products built to solve real business problems.',
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _serviceCard(
                        Icons.auto_awesome_rounded,
                        'Brand Design',
                        'Visual identities that make businesses memorable.',
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _serviceCard(
                        Icons.trending_up_rounded,
                        'Performance Marketing',
                        'Strategies designed to turn attention into growth.',
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _serviceCard(
    IconData icon,
    String title,
    String description,
  ) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FD),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE7ECF5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF003EBE),
                  Color(0xFF00AEEF),
                ],
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 25,
            ),
          ),

          const SizedBox(height: 22),

          Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: AppColors.navyBlue,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // WHO WE ARE
  // ============================================================

  Widget _buildWhoWeAre(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 70,
        vertical: 75,
      ),
      color: const Color(0xFFF4F8FF),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _aboutImage(),
                const SizedBox(height: 35),
                _aboutText(),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: _aboutImage(),
                ),
                const SizedBox(width: 70),
                Expanded(
                  child: _aboutText(),
                ),
              ],
            ),
    );
  }

  Widget _aboutImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: Image.asset(
        'assets/images/team.jpg',
        height: 360,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _aboutText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _smallLabel('WHO WE ARE'),

        const SizedBox(height: 20),

        const Text(
          'One technology\npartner for your\nbusiness.',
          style: TextStyle(
            fontSize: 38,
            height: 1.1,
            fontWeight: FontWeight.w800,
            color: AppColors.navyBlue,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          'Urbanova brings software development, '
          'brand design, and performance marketing '
          'together under one team.',
          style: TextStyle(
            fontSize: 16,
            height: 1.6,
            color: Colors.grey.shade600,
          ),
        ),

        const SizedBox(height: 25),

        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AboutUsScreen(),
              ),
            );
          },
          child: const Text(
            'Learn more →',
            style: TextStyle(
              color: AppColors.deepBlue,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // WHY URBANOVA
  // ============================================================

  Widget _buildWhyUrbanova(bool isMobile) {
    final items = [
      [
        Icons.people_alt_outlined,
        'Direct communication',
        'Work directly with the people doing the work.',
      ],
      [
        Icons.workspace_premium_outlined,
        'Experienced thinking',
        'Focused solutions instead of unnecessary complexity.',
      ],
      [
        Icons.sync_rounded,
        'One connected team',
        'Product, design and growth working toward one goal.',
      ],
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 70,
        vertical: 75,
      ),
      child: Column(
        children: [
          const Text(
            'WHY URBANOVA',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
              color: AppColors.deepBlue,
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            'A simpler way to build.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: AppColors.navyBlue,
            ),
          ),

          const SizedBox(height: 40),

          isMobile
              ? Column(
                  children: items
                      .map(
                        (item) => _whyCard(
                          item[0] as IconData,
                          item[1] as String,
                          item[2] as String,
                        ),
                      )
                      .toList(),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: items
                      .map(
                        (item) => Expanded(
                          child: _whyCard(
                            item[0] as IconData,
                            item[1] as String,
                            item[2] as String,
                          ),
                        ),
                      )
                      .toList(),
                ),
        ],
      ),
    );
  }

  Widget _whyCard(
    IconData icon,
    String title,
    String description,
  ) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(22),
      child: Column(
        children: [
          Icon(
            icon,
            size: 32,
            color: AppColors.deepBlue,
          ),

          const SizedBox(height: 16),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.navyBlue,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CTA
  // ============================================================

  Widget _buildCTA(bool isMobile) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 30,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 25 : 60,
        vertical: 55,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF003EBE),
            Color(0xFF006FD6),
            Color(0xFF00AEEF),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          const Text(
            'Have an idea?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Let’s turn it into something meaningful.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 25),

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.deepBlue,
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 15,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Contact Us',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FOOTER
  // ============================================================

  Widget _buildFooter(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isMobile ? 25 : 60,
      ),
      color: const Color(0xFF07152F),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: [
                  Color(0xFF00AEEF),
                  Color(0xFF7AC943),
                ],
              ).createShader(bounds);
            },
            child: const Text(
              'URBANOVA',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Building digital experiences that matter.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white60,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            '© 2026 Urbanova Technologies Private Limited',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white38,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MOBILE DRAWER
  // ============================================================

  Widget _buildMobileDrawer() {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: ShaderMask(
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
                  'URBANOVA TECHNOLOGIES',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const Divider(),

            _buildDrawerItem('Home'),

            _buildDrawerItem('Services'),

            _buildDrawerItem(
              'About Us',
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUsScreen(),
                  ),
                );
              },
            ),

            _buildDrawerItem('Contact Us'),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    String title, {
    VoidCallback? onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.navyBlue,
        ),
      ),
      onTap: onTap ??
          () {
            Navigator.pop(context);
          },
    );
  }
}