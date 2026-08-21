import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../core/app_colors.dart';
import '../models/service_model.dart';
import '../services/services_data_service.dart';
import 'service_details_screen.dart';
import 'contact_screen.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Future<List<ServiceModel>> _servicesFuture;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _servicesFuture = ServiceData.loadServices();

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
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: FutureBuilder<List<ServiceModel>>(
          future: _servicesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.deepBlue,
                ),
              );
            }

            if (snapshot.hasError) {
              return _buildError(snapshot.error.toString());
            }

            final services = snapshot.data ?? [];

            if (services.isEmpty) {
              return _buildError(
                'No services found in the JSON file.',
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildTopBar(),

                  // NEW HERO ONLY
                  _buildHero(services),

                  // EVERYTHING BELOW REMAINS THE SAME
                  _buildIntro(),

                  _buildCategory(
                    services
                        .where(
                          (service) =>
                              service.category.toUpperCase() == 'BUILD',
                        )
                        .toList(),
                    number: '01',
                    title: 'BUILD',
                    dark: false,
                  ),

                  _buildCategory(
                    services
                        .where(
                          (service) =>
                              service.category.toUpperCase() == 'DESIGN',
                        )
                        .toList(),
                    number: '02',
                    title: 'DESIGN',
                    dark: true,
                  ),

                  _buildCategory(
                    services
                        .where(
                          (service) =>
                              service.category.toUpperCase() == 'GROW',
                        )
                        .toList(),
                    number: '03',
                    title: 'GROW',
                    dark: false,
                  ),

                  _buildFinalCTA(),

                  _buildFooter(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // ERROR
  // ============================================================

  Widget _buildError(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 50,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 15),
            const Text(
              'Unable to load services',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.navyBlue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _servicesFuture = ServiceData.loadServices();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.deepBlue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Try Again'),
            ),
          ],
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
              errorBuilder: (_, __, ___) {
                return const Icon(
                  Icons.business_rounded,
                  color: Colors.white,
                );
              },
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
            onTap: () {
              Navigator.pop(context);
            },
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
  // NEW HERO
  // ============================================================

  Widget _buildHero(List<ServiceModel> services) {
    return Container(
      width: double.infinity,
      height: 350,
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
      child: Stack(
        children: [
          // ------------------------------------------------------
          // BACKGROUND GLOW 1
          // ------------------------------------------------------

          Positioned(
            top: -80,
            right: -70,
            child: _glowingCircle(
              size: 230,
              opacity: 0.12,
            ),
          ),

          // ------------------------------------------------------
          // BACKGROUND GLOW 2
          // ------------------------------------------------------

          Positioned(
            bottom: -100,
            left: -80,
            child: _glowingCircle(
              size: 260,
              opacity: 0.10,
            ),
          ),

          // ------------------------------------------------------
          // ANIMATED SERVICE ICONS
          // ------------------------------------------------------

          ..._buildFloatingIcons(services),

          // ------------------------------------------------------
          // MAIN CONTENT
          // ------------------------------------------------------

          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 38,
              ),
              child: FadeTransition(
                opacity: CurvedAnimation(
                  parent: _controller,
                  curve: Curves.easeOut,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                          color: Colors.white.withOpacity(0.15),
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

                    const SizedBox(height: 20),

                    const Text(
                      'SERVICES',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 3.5,
                      ),
                    ),

                    const SizedBox(height: 7),

                    const Text(
                      'We create.\nYou grow.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 43,
                        height: 0.98,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.8,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      'Technology • Design • Growth',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.65),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ------------------------------------------------------
          // BOTTOM DECORATIVE LINE
          // ------------------------------------------------------

          Positioned(
            bottom: 22,
            left: 24,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  width: 90 * _controller.value,
                  height: 3,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.skyBlue,
                        AppColors.limeGreen,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // GLOWING CIRCLE
  // ============================================================

  Widget _glowingCircle({
    required double size,
    required double opacity,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.skyBlue.withOpacity(opacity),
        boxShadow: [
          BoxShadow(
            color: AppColors.skyBlue.withOpacity(opacity),
            blurRadius: 70,
            spreadRadius: 20,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FLOATING SERVICE ICONS
  // ============================================================

  List<Widget> _buildFloatingIcons(
    List<ServiceModel> services,
  ) {
    final positions = [
      const Offset(285, 55),
      const Offset(315, 145),
      const Offset(265, 250),
      const Offset(185, 285),
    ];

    final widgets = <Widget>[];

    final count = services.length > 4 ? 4 : services.length;

    for (int i = 0; i < count; i++) {
      widgets.add(
        _animatedServiceIcon(
          service: services[i],
          position: positions[i],
          delay: i * 120,
        ),
      );
    }

    return widgets;
  }

  // ============================================================
  // ANIMATED SERVICE ICON
  // ============================================================

  Widget _animatedServiceIcon({
    required ServiceModel service,
    required Offset position,
    required int delay,
  }) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final animationValue = Curves.easeOutBack.transform(
            ((_controller.value * 1.4) - (delay / 1000))
                .clamp(0.0, 1.0),
          );

          return Opacity(
            opacity: animationValue.clamp(0.0, 1.0),
            child: Transform.scale(
              scale: animationValue,
              child: Transform.translate(
                offset: Offset(
                  0,
                  -8 * animationValue,
                ),
                child: child,
              ),
            ),
          );
        },
        child: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withOpacity(0.15),
            ),
            boxShadow: [
              BoxShadow(
                color: service.gradientData.colors.first
                    .withOpacity(0.25),
                blurRadius: 18,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              gradient: service.gradientData,
              shape: BoxShape.circle,
            ),
            child: Icon(
              service.iconData,
              color: Colors.white,
              size: 22,
            ),
          ),
        ),
      ),
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
              letterSpacing: -1.2,
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
  // CATEGORY
  // ============================================================

  Widget _buildCategory(
    List<ServiceModel> services, {
    required String number,
    required String title,
    required bool dark,
  }) {
    if (services.isEmpty) {
      return const SizedBox.shrink();
    }

    final first = services.first;

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
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: first.gradientData,
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

              Expanded(
                child: Column(
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
                      first.categorySubtitle,
                      style: TextStyle(
                        color: dark
                            ? Colors.white54
                            : Colors.grey.shade600,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          ...services.map(
            (service) => _buildServiceCard(
              service,
              dark,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SERVICE CARD
  // ============================================================

  Widget _buildServiceCard(
    ServiceModel service,
    bool dark,
  ) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: 0,
        end: 1,
      ),
      duration: const Duration(milliseconds: 650),
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
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ServiceDetailsScreen(
                title: service.title,
                icon: service.iconData,
                description: service.description,
                detail: service.detail,
                gradient: service.gradientData,
                image: service.image,
                features: service.features,
              ),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(
            bottom: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 220,
                      child: Image.asset(
                        service.image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Container(
                            color: const Color(0xFFE8ECF4),
                            child: const Center(
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                size: 40,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    Positioned.fill(
                      child: DecoratedBox(
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

                    Positioned(
                      top: 15,
                      right: 15,
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          gradient: service.gradientData,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Icon(
                          service.iconData,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),

                    Positioned(
                      left: 18,
                      right: 18,
                      bottom: 18,
                      child: Text(
                        service.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

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

              Row(
                children: [
                  Text(
                    'Explore service',
                    style: TextStyle(
                      color: dark
                          ? AppColors.limeGreen
                          : AppColors.deepBlue,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(width: 6),

                  Icon(
                    Icons.arrow_forward_rounded,
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
        gradient: AppColors.blueGradient,
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

          const Text(
            'Tell us about your idea or challenge. '
            'We will help you figure out the right solution.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 25),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ContactScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.limeGreen,
              foregroundColor: AppColors.navyBlue,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 15,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Let’s talk',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
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
                  AppColors.skyBlue,
                  AppColors.limeGreen,
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
            borderRadius: BorderRadius.circular(10),
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