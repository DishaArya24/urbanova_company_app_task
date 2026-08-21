import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../models/service_model.dart';
import '../services/services_data_service.dart';

import 'about_us_screen.dart';
import 'services_screen.dart';
import 'service_details_screen.dart';
import 'contact_screen.dart';
import 'client_details_screen.dart';

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

  // =========================================================
  // SERVICES
  // Loaded from JSON
  // =========================================================

  List<ServiceModel> _services = [];
  bool _isLoadingServices = true;

  // =========================================================
  // CLIENTS
  // =========================================================

  final List<Map<String, String>> _clients = [
    {
      'name': 'Big Bean Cafe',
      'category': 'Cafe & Food',
      'image': 'assets/images/bigbean.jpg',
      'description':
          'A modern digital experience designed to help Big Bean Cafe connect with its customers.',
    },
    {
      'name': 'World Bean Coffee Roasters',
      'category': 'Coffee & Lifestyle',
      'image': 'assets/images/worldbean.jpg',
      'description':
          'A digital presence created to showcase the brand and its coffee experience.',
    },
    {
      'name': 'Vivin Store',
      'category': 'Retail & E-commerce',
      'image': 'assets/images/vivin.jpg',
      'description':
          'A clean and engaging digital experience designed for a modern retail brand.',
    },
  ];

  // =========================================================
  // INIT
  // =========================================================

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

    _loadServices();
  }

  Future<void> _loadServices() async {
    try {
      final services = await ServiceData.loadServices();

      if (!mounted) return;

      setState(() {
        _services = services;
        _isLoadingServices = false;
      });
    } catch (e) {
      debugPrint('Error loading services: $e');

      if (!mounted) return;

      setState(() {
        _isLoadingServices = false;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: _buildMobileDrawer(),
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
                  _buildClients(isMobile),
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

  // =========================================================
  // NAVBAR
  // =========================================================

  Widget _buildNavbar(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 16,
      ),
      child: Row(
        children: [
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
            _buildNavText(
              'Home',
              onTap: () {},
            ),

            _buildNavText(
              'Services',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ServicesScreen(),
                  ),
                );
              },
            ),

            _buildNavText(
              'About Us',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUsScreen(),
                  ),
                );
              },
            ),

            _buildNavText(
              'Contact',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactScreen(),
                  ),
                );
              },
            ),
          ],

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

  Widget _buildNavText(
    String text, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 8,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.navyBlue,
          ),
        ),
      ),
    );
  }

  // =========================================================
  // HERO
  // =========================================================

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
            Colors.white,
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
            gradient: const LinearGradient(
              colors: [
                Color(0xFF003EBE),
                Color(0xFF7AC943),
              ],
            ),
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

  // =========================================================
  // PRIMARY BUTTON
  // =========================================================

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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ServicesScreen(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.deepBlue,
            foregroundColor: Colors.white,
            elevation: 4,
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

  // =========================================================
  // SERVICES
  // =========================================================

  Widget _buildServices(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 70,
        vertical: 70,
      ),
      child: Column(
        children: [
          _smallLabel('WHAT WE DO'),

          const SizedBox(height: 18),

          const Text(
            'Our services',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w800,
              color: AppColors.navyBlue,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            'Simple solutions for modern businesses.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 35),

          if (_isLoadingServices)
            const Padding(
              padding: EdgeInsets.all(30),
              child: CircularProgressIndicator(
                color: AppColors.deepBlue,
              ),
            )
          else if (_services.isEmpty)
            const Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                'Unable to load services.',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            )
          else
            isMobile
                ? Column(
                    children: _services
                        .take(5)
                        .map(
                          (service) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _serviceCard(service),
                          ),
                        )
                        .toList(),
                  )
                : Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: _services.take(5).map((service) {
                      return SizedBox(
                        width: 300,
                        child: _serviceCard(service),
                      );
                    }).toList(),
                  ),

          const SizedBox(height: 25),

          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ServicesScreen(),
                ),
              );
            },
            child: const Text(
              'View all services →',
              style: TextStyle(
                color: AppColors.deepBlue,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _serviceCard(ServiceModel service) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiceDetailsScreen(
              title: service.title,
              icon: _getIcon(service.icon),
              description: service.description,
              gradient: _getGradient(service.gradient),
              image: service.image,
              detail: service.detail,
              features: service.features,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE7ECF5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.06),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                gradient: _getGradient(service.gradient),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                _getIcon(service.icon),
                color: Colors.white,
                size: 25,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.navyBlue,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    service.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: AppColors.deepBlue,
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // ICON / GRADIENT HELPERS
  // =========================================================

  IconData _getIcon(String icon) {
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
        return Icons.apps_rounded;
    }
  }

  LinearGradient _getGradient(String gradient) {
    switch (gradient) {
      case 'green':
        return AppColors.greenGradient;

      case 'blue':
      default:
        return AppColors.blueGradient;
    }
  }

  // =========================================================
  // WHO WE ARE
  // =========================================================

  Widget _buildWhoWeAre(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 70,
        vertical: 70,
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
          'Urbanova brings technology, creativity and '
          'strategy together to help businesses build '
          'meaningful digital experiences.',
          style: TextStyle(
            fontSize: 16,
            height: 1.6,
            color: Colors.grey.shade600,
          ),
        ),

        const SizedBox(height: 20),

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

  // =========================================================
  // WHY URBANOVA
  // =========================================================

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
        vertical: 70,
      ),
      child: Column(
        children: [
          _smallLabel('WHY URBANOVA'),

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

          const SizedBox(height: 12),

          Text(
            'Technology, creativity and strategy working together.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 35),

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
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF003EBE),
                  Color(0xFF7AC943),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 27,
              color: Colors.white,
            ),
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

  // =========================================================
  // CLIENTS
  // =========================================================

  Widget _buildClients(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 70,
        vertical: 70,
      ),
      color: const Color(0xFFF4F8FF),
      child: Column(
        children: [
          _smallLabel('FEATURED CLIENTS'),

          const SizedBox(height: 18),

          const Text(
            'Brands we’ve helped\nmove forward.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 34,
              height: 1.15,
              fontWeight: FontWeight.w800,
              color: AppColors.navyBlue,
            ),
          ),

          const SizedBox(height: 35),

          AspectRatio(
            aspectRatio: isMobile ? 0.95 : 1.55,
            child: PageView.builder(
              controller: PageController(
                viewportFraction: isMobile ? 0.92 : 0.72,
              ),
              itemCount: _clients.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: _buildClientCard(_clients[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClientCard(
    Map<String, String> client,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClientDetailsScreen(
              clientName: client['name']!,
              category: client['category']!,
              image: client['image']!,
              description: client['description']!,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  client['image']!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (
                    context,
                    error,
                    stackTrace,
                  ) {
                    return Container(
                      width: double.infinity,
                      color: const Color(0xFFEAF1FF),
                      child: const Center(
                        child: Icon(
                          Icons.image_outlined,
                          size: 45,
                          color: AppColors.deepBlue,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 14),

            Text(
              client['category']!.toUpperCase(),
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.4,
                color: AppColors.deepBlue,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              client['name']!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                color: AppColors.navyBlue,
              ),
            ),

            const SizedBox(height: 7),

            Expanded(
              flex: 2,
              child: Text(
                client['description']!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.45,
                  color: Colors.grey.shade600,
                ),
              ),
            ),

            const SizedBox(height: 8),

            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'View Project',
                  style: TextStyle(
                    color: AppColors.deepBlue,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(width: 6),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 16,
                  color: AppColors.deepBlue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // CTA
  // =========================================================

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
            Color(0xFF7AC943),
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ContactScreen(),
                ),
              );
            },
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

  // =========================================================
  // FOOTER
  // =========================================================

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

  // =========================================================
  // MOBILE DRAWER
  // =========================================================

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

            _buildDrawerItem(
              'Home',
              onTap: () {
                Navigator.pop(context);
              },
            ),

            _buildDrawerItem(
              'Services',
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ServicesScreen(),
                  ),
                );
              },
            ),

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

            _buildDrawerItem(
              'Contact Us',
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactScreen(),
                  ),
                );
              },
            ),
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