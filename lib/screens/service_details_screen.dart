
import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'contact_screen.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final LinearGradient gradient;
  final String image;

  const ServiceDetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.gradient,
    required this.image,
  });

  @override
  State<ServiceDetailsScreen> createState() =>
      _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState
    extends State<ServiceDetailsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool _imageHovered = false;
  bool _buttonHovered = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
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
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTopBar(context),
              _buildHero(isMobile),
              _buildContent(isMobile),
              _buildCTA(isMobile),
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

  Widget _buildTopBar(BuildContext context) {
    return Container(
      color: const Color(0xFF050D24),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
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
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                color: Colors.white.withOpacity(0.12),
              ),
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
              fontSize: 17,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              color: Colors.white,
            ),
          ),

          const Spacer(),

          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
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

  Widget _buildHero(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 25 : 70,
        vertical: isMobile ? 55 : 80,
      ),
      decoration: BoxDecoration(
        gradient: widget.gradient,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -100,
            top: -100,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),

          Positioned(
            left: -100,
            bottom: -150,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.limeGreen.withOpacity(0.10),
              ),
            ),
          ),

          FadeTransition(
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
              child: isMobile
                  ? _buildMobileHero()
                  : _buildDesktopHero(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileHero() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeroImage(),
        const SizedBox(height: 35),
        _buildHeroText(),
      ],
    );
  }

  Widget _buildDesktopHero() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: _buildHeroText(),
        ),

        const SizedBox(width: 50),

        Expanded(
          flex: 4,
          child: _buildHeroImage(),
        ),
      ],
    );
  }

  Widget _buildHeroText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.10),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withOpacity(0.18),
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
              SizedBox(width: 8),
              Text(
                'SERVICE DETAILS',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 46,
            height: 1.02,
            fontWeight: FontWeight.w900,
            letterSpacing: -2,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          widget.description,
          style: TextStyle(
            fontSize: 16,
            height: 1.65,
            color: Colors.white.withOpacity(0.75),
          ),
        ),

        const SizedBox(height: 28),

        Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                widget.icon,
                color: Colors.white,
                size: 23,
              ),
            ),

            const SizedBox(width: 13),

            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'URBANOVA',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Technology • Design • Growth',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // HERO IMAGE
  // ============================================================

  Widget _buildHeroImage() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,

      onEnter: (_) {
        setState(() {
          _imageHovered = true;
        });
      },

      onExit: (_) {
        setState(() {
          _imageHovered = false;
        });
      },

      child: AnimatedScale(
        scale: _imageHovered ? 1.04 : 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),

          transform: Matrix4.translationValues(
            0,
            _imageHovered ? -8 : 0,
            0,
          ),

          child: Container(
            height: 300,
            width: double.infinity,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(
                    _imageHovered ? 0.25 : 0.18,
                  ),
                  blurRadius: _imageHovered ? 45 : 30,
                  offset: const Offset(0, 18),
                ),
              ],
            ),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),

              child: Stack(
                fit: StackFit.expand,

                children: [
                  Image.asset(
                    widget.image,
                    fit: BoxFit.cover,
                  ),

                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.55),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    left: 20,
                    bottom: 20,

                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 9,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.30),
                        borderRadius: BorderRadius.circular(20),

                        border: Border.all(
                          color: Colors.white.withOpacity(0.15),
                        ),
                      ),

                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            color: AppColors.limeGreen,
                            size: 14,
                          ),

                          SizedBox(width: 7),

                          Text(
                            'CREATIVE SOLUTIONS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    right: 18,
                    top: 18,

                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),

                      width: 44,
                      height: 44,

                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.13),
                        shape: BoxShape.circle,

                        border: Border.all(
                          color: Colors.white.withOpacity(0.15),
                        ),
                      ),

                      child: const Icon(
                        Icons.arrow_outward_rounded,
                        color: Colors.white,
                        size: 19,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // CONTENT
  // ============================================================

  Widget _buildContent(bool isMobile) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 25 : 70,
        vertical: 75,
      ),

      color: const Color(0xFFF5F7FC),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          _sectionLabel('WHAT WE DELIVER'),

          const SizedBox(height: 16),

          Text(
            'More than a service.\nA complete solution.',

            style: TextStyle(
              fontSize: isMobile ? 34 : 46,
              height: 1.05,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.8,
              color: AppColors.navyBlue,
            ),
          ),

          const SizedBox(height: 18),

          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 650,
            ),

            child: Text(
              'We combine strategy, creativity and technology '
              'to create solutions that are built around your '
              'actual business goals.',

              style: TextStyle(
                fontSize: 15,
                height: 1.65,
                color: Colors.grey.shade600,
              ),
            ),
          ),

          const SizedBox(height: 40),

          _buildFeatureGrid(isMobile),
        ],
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 3,

          decoration: BoxDecoration(
            gradient: AppColors.greenGradient,
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        const SizedBox(width: 10),

        Text(
          text,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            color: AppColors.deepBlue,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // FEATURE GRID
  // ============================================================

  Widget _buildFeatureGrid(bool isMobile) {
    final features = [
      [
        Icons.lightbulb_outline_rounded,
        'Strategy',
        'Understand the problem and create the right approach.',
      ],

      [
        Icons.design_services_outlined,
        'Experience',
        'Create intuitive and engaging digital experiences.',
      ],

      [
        Icons.rocket_launch_outlined,
        'Execution',
        'Turn ideas into scalable and reliable solutions.',
      ],

      [
        Icons.analytics_outlined,
        'Growth',
        'Measure results and continuously improve performance.',
      ],
    ];

    if (isMobile) {
      return Column(
        children: features
            .asMap()
            .entries
            .map(
              (entry) => _featureCard(
                icon: entry.value[0] as IconData,
                title: entry.value[1] as String,
                description: entry.value[2] as String,
                index: entry.key,
              ),
            )
            .toList(),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),

      itemCount: features.length,

      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1.7,
      ),

      itemBuilder: (context, index) {
        return _featureCard(
          icon: features[index][0] as IconData,
          title: features[index][1] as String,
          description: features[index][2] as String,
          index: index,
        );
      },
    );
  }

  // ============================================================
  // FEATURE CARD
  // ============================================================

  Widget _featureCard({
    required IconData icon,
    required String title,
    required String description,
    required int index,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(
        begin: 0,
        end: 1,
      ),

      duration: Duration(
        milliseconds: 500 + (index * 120),
      ),

      curve: Curves.easeOutCubic,

      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(
            0,
            25 * (1 - value),
          ),

          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },

      child: _HoverFeatureCard(
        icon: icon,
        title: title,
        description: description,
        gradient: widget.gradient,
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
        vertical: 20,
      ),

      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 25 : 65,
        vertical: 55,
      ),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF050D24),
            Color(0xFF002B80),
            Color(0xFF0060D8),
          ],

          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        borderRadius: BorderRadius.circular(32),

        boxShadow: [
          BoxShadow(
            color: AppColors.deepBlue.withOpacity(0.20),
            blurRadius: 35,
            offset: const Offset(0, 18),
          ),
        ],
      ),

      child: Stack(
        children: [
          Positioned(
            right: -80,
            top: -100,

            child: Container(
              width: 230,
              height: 230,

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.limeGreen.withOpacity(0.12),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),

                decoration: BoxDecoration(
                  color: AppColors.limeGreen.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),

                child: const Text(
                  'LET\'S CREATE',
                  style: TextStyle(
                    color: AppColors.limeGreen,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.8,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Text(
                'Ready to build\nsomething great?',

                style: TextStyle(
                  fontSize: isMobile ? 36 : 48,
                  height: 1,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -2,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 18),

              Text(
                'Tell us what you are trying to solve. '
                'We will help you find the right way forward.',

                style: TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: Colors.white.withOpacity(0.68),
                ),
              ),

              const SizedBox(height: 28),

              MouseRegion(
                cursor: SystemMouseCursors.click,

                onEnter: (_) {
                  setState(() {
                    _buttonHovered = true;
                  });
                },

                onExit: (_) {
                  setState(() {
                    _buttonHovered = false;
                  });
                },

                child: AnimatedScale(
                  scale: _buttonHovered ? 1.04 : 1,

                  duration: const Duration(
                    milliseconds: 180,
                  ),

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const ContactScreen(),
                        ),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          AppColors.limeGreen,

                      foregroundColor:
                          AppColors.navyBlue,

                      elevation: 0,

                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                    ),

                    child: const Row(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        Text(
                          'Let’s Talk',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        ),

                        SizedBox(width: 9),

                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
        45,
        25,
        35,
      ),

      color: const Color(0xFF050D24),

      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) {
              return AppColors.greenGradient
                  .createShader(bounds);
            },

            child: const Text(
              'URBANOVA',

              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                letterSpacing: 3,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Technology • Design • Growth',

            style: TextStyle(
              color: Colors.white54,
              fontSize: 12,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 25),

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
}

// ============================================================
// HOVER FEATURE CARD
// ============================================================

class _HoverFeatureCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final LinearGradient gradient;

  const _HoverFeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.gradient,
  });

  @override
  State<_HoverFeatureCard> createState() =>
      _HoverFeatureCardState();
}

class _HoverFeatureCardState
    extends State<_HoverFeatureCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,

      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },

      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,

        transform: Matrix4.translationValues(
          0,
          isHovered ? -8 : 0,
          0,
        ),

        padding: const EdgeInsets.all(22),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(24),

          border: Border.all(
            color: isHovered
                ? AppColors.deepBlue.withOpacity(0.15)
                : const Color(0xFFE7EBF3),
          ),

          boxShadow: [
            BoxShadow(
              color: AppColors.navyBlue.withOpacity(
                isHovered ? 0.13 : 0.05,
              ),

              blurRadius: isHovered ? 35 : 20,

              offset: Offset(
                0,
                isHovered ? 18 : 8,
              ),
            ),
          ],
        ),

        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),

              width: isHovered ? 54 : 48,
              height: isHovered ? 54 : 48,

              decoration: BoxDecoration(
                gradient: widget.gradient,
                borderRadius: BorderRadius.circular(15),
              ),

              child: Icon(
                widget.icon,
                color: Colors.white,
                size: 23,
              ),
            ),

            const SizedBox(width: 17),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Text(
                    widget.title,

                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: AppColors.navyBlue,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    widget.description,

                    style: TextStyle(
                      fontSize: 12,
                      height: 1.45,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            AnimatedRotation(
              turns: isHovered ? 0.08 : 0,

              duration:
                  const Duration(milliseconds: 220),

              child: Icon(
                Icons.arrow_outward_rounded,

                size: 20,

                color: isHovered
                    ? AppColors.deepBlue
                    : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
