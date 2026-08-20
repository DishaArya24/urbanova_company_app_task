

import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // ============================================================
  // PAGE CONTROLLER
  // ============================================================

  final PageController _pageController = PageController();

  int _currentPage = 0;

  Timer? _autoSlideTimer;

  // ============================================================
  // ANIMATION CONTROLLER
  // ============================================================

  late AnimationController _animationController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  late Animation<Offset> _titleSlideAnimation;
  late Animation<Offset> _subtitleSlideAnimation;
  late Animation<Offset> _buttonSlideAnimation;

  // ============================================================
  // INIT STATE
  // ============================================================

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // ------------------------------------------------------------
    // FADE
    // ------------------------------------------------------------

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.0,
        0.75,
        curve: Curves.easeOut,
      ),
    );

    // ------------------------------------------------------------
    // SCALE
    // ------------------------------------------------------------

    _scaleAnimation = Tween<double>(
      begin: 0.75,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.0,
          0.55,
          curve: Curves.easeOutBack,
        ),
      ),
    );

    // ------------------------------------------------------------
    // TITLE SLIDE
    // ------------------------------------------------------------

    _titleSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.35),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.15,
          0.70,
          curve: Curves.easeOutCubic,
        ),
      ),
    );

    // ------------------------------------------------------------
    // SUBTITLE SLIDE
    // ------------------------------------------------------------

    _subtitleSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.35,
          0.82,
          curve: Curves.easeOutCubic,
        ),
      ),
    );

    // ------------------------------------------------------------
    // BUTTON SLIDE
    // ------------------------------------------------------------

    _buttonSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.30),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.55,
          1.0,
          curve: Curves.easeOutBack,
        ),
      ),
    );

    // Start first page animation
    _animationController.forward();

    // Start automatic page sliding
    _startAutoSlide();
  }

  // ============================================================
  // AUTOMATIC SLIDE
  // ============================================================

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(
      const Duration(seconds: 4),
      (timer) {
        if (!mounted || !_pageController.hasClients) {
          return;
        }

        int nextPage = _currentPage + 1;

        if (nextPage > 2) {
          nextPage = 0;
        }

        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOutCubic,
        );
      },
    );
  }

  // ============================================================
  // PAGE CHANGED
  // ============================================================

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });

    // Restart animation every time a new page appears
    _animationController.reset();

    Future.delayed(
      const Duration(milliseconds: 80),
      () {
        if (mounted) {
          _animationController.forward();
        }
      },
    );
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    _animationController.dispose();

    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,

        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _getBackgroundGradient(),
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [
              // ==================================================
              // SKIP BUTTON
              // ==================================================

              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    right: 20,
                  ),
                  child: TextButton(
                    onPressed: _goToHome,
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF003EBE),
                      ),
                    ),
                  ),
                ),
              ),

              // ==================================================
              // PAGE VIEW
              // ==================================================

              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,

                  children: [
                    // ==================================================
                    // PAGE 1
                    // ==================================================

                    _buildPage(
                      image: 'assets/images/un_logo.jpg',
                      title: 'Welcome to Urbanova',
                      subtitle: 'Swipe to explore',
                    ),

                    // ==================================================
                    // PAGE 2
                    // ==================================================

                    _buildPage(
                      title:
                          'We build the tech, the brand, and the growth — together.',
                      subtitle:
                          'Turning ideas into meaningful digital experiences.',
                    ),

                    // ==================================================
                    // PAGE 3
                    // ==================================================

                    _buildPage(
                      title: 'Let’s create something amazing.',
                      subtitle:
                          'Your digital journey starts here.',
                      showButton: true,
                    ),
                  ],
                ),
              ),

              // ==================================================
              // PAGE INDICATORS
              // ==================================================

              Padding(
                padding: const EdgeInsets.only(
                  bottom: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDot(
                      isActive: _currentPage == 0,
                    ),
                    _buildDot(
                      isActive: _currentPage == 1,
                    ),
                    _buildDot(
                      isActive: _currentPage == 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BACKGROUND GRADIENT
  // ============================================================

  List<Color> _getBackgroundGradient() {
    switch (_currentPage) {
      case 0:
        return const [
          Color(0xFFFFFFFF),
          Color(0xFFF1F6FF),
          Color(0xFFE6F1FF),
        ];

      case 1:
        return const [
          Color(0xFFF8FBFF),
          Color(0xFFEAF4FF),
          Color(0xFFE9F8F5),
        ];

      case 2:
        return const [
          Color(0xFFFFFFFF),
          Color(0xFFF0F7FF),
          Color(0xFFEAF8F0),
        ];

      default:
        return const [
          Colors.white,
          Color(0xFFF1F6FF),
          Color(0xFFE6F1FF),
        ];
    }
  }

  // ============================================================
  // REUSABLE SPLASH PAGE
  // ============================================================

  Widget _buildPage({
    String? image,
    required String title,
    required String subtitle,
    bool showButton = false,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ==================================================
            // IMAGE / LOGO
            // ==================================================

            if (image != null) ...[
              FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 25,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        image,
                        width: 160,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],

            // ==================================================
            // TITLE
            // ==================================================

            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _titleSlideAnimation,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    height: 1.2,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF001465),
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // ==================================================
            // SUBTITLE
            // ==================================================

            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _subtitleSlideAnimation,
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ),

            // ==================================================
            // GET STARTED
            // ==================================================

            if (showButton) ...[
              const SizedBox(height: 35),

              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _buttonSlideAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: ElevatedButton(
                      onPressed: _goToHome,

                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF003EBE),
                        foregroundColor: Colors.white,
                        elevation: 6,

                        padding: const EdgeInsets.symmetric(
                          horizontal: 45,
                          vertical: 16,
                        ),

                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30),
                        ),
                      ),

                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 16,
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
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ANIMATED PAGE DOT
  // ============================================================

  Widget _buildDot({
    required bool isActive,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutBack,

      margin: const EdgeInsets.symmetric(
        horizontal: 4,
      ),

      width: isActive ? 28 : 8,
      height: 8,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

        color: isActive
            ? const Color(0xFF003EBE)
            : Colors.grey.shade300,
      ),
    );
  }

  // ============================================================
  // GO TO HOME
  // ============================================================

  void _goToHome() {
    _autoSlideTimer?.cancel();

    Navigator.pushReplacement(
      context,

      PageRouteBuilder(
        transitionDuration:
            const Duration(milliseconds: 700),

        pageBuilder: (
          context,
          animation,
          secondaryAnimation,
        ) {
          return const HomeScreen();
        },

        transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
        ) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
            child: child,
          );
        },
      ),
    );
  }
}

