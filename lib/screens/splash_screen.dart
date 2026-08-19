import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // Page controller
  final PageController _pageController = PageController();

  int _currentPage = 0;

  // Animation controller
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Main animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Fade animation
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    // Slide animation
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Start animation
    _animationController.forward();
  }

  @override
  void dispose() {
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
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            // ====================================================
            // SKIP BUTTON
            // ====================================================

            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  right: 20,
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF003EBE),
                    ),
                  ),
                ),
              ),
            ),

            // ====================================================
            // SWIPEABLE SPLASH PAGES
            // ====================================================

            Expanded(
              child: PageView(
                controller: _pageController,

                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },

                children: [
                  // ------------------------------------------------
                  // PAGE 1
                  // ------------------------------------------------

                  _buildPage(
                    image: 'assets/images/un_logo.jpg',
                    title: 'Welcome to Urbanova',
                    subtitle: 'Swipe to explore',
                  ),

                  // ------------------------------------------------
                  // PAGE 2
                  // ------------------------------------------------

                  _buildPage(
                    title:
                        'We build the tech, the brand, and the growth — together.',
                    subtitle:
                        'Turning ideas into meaningful digital experiences.',
                  ),

                  // ------------------------------------------------
                  // PAGE 3
                  // ------------------------------------------------

                  _buildPage(
                    title: 'Let’s create something amazing.',
                    subtitle: 'Your digital journey starts here.',
                    showButton: true,
                  ),
                ],
              ),
            ),

            // ====================================================
            // PAGE INDICATORS
            // ====================================================

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
    );
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
            // ====================================================
            // LOGO
            // ====================================================

            if (image != null) ...[
              FadeTransition(
                opacity: _fadeAnimation,
                child: Image.asset(
                  image,
                  width: 180,
                ),
              ),

              const SizedBox(height: 30),
            ],

            // ====================================================
            // TITLE
            // ====================================================

            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF001465),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ====================================================
            // SUBTITLE
            // ====================================================

            FadeTransition(
              opacity: _fadeAnimation,
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ),

            // ====================================================
            // GET STARTED BUTTON
            // ====================================================

            if (showButton) ...[
              const SizedBox(height: 35),

              FadeTransition(
                opacity: _fadeAnimation,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF003EBE),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 45,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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
  // PAGE DOT
  // ============================================================

  Widget _buildDot({
    required bool isActive,
  }) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 250,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 4,
      ),
      width: isActive ? 10 : 8,
      height: isActive ? 10 : 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? const Color(0xFF003EBE)
            : Colors.grey.shade300,
      ),
    );
  }
}