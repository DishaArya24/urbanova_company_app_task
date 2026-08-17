import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Keeps track of which splash page the user is viewing.
  final PageController _pageController = PageController();

  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [

            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  right: 20,
                ),
                child: TextButton(
                  onPressed: () {
                    // Home navigation will be added later.
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

            // Swipeable pages
            Expanded(
              child: PageView(
                controller: _pageController,

                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },

                children: [

                  // ---------------- PAGE 1 ----------------
                  _buildPage(
                    image: 'assets/images/un_logo.jpg',
                    title: 'Welcome to Urbanova',
                    subtitle: 'Swipe to explore',
                  ),

                  // ---------------- PAGE 2 ----------------
                  _buildPage(
                    title:
                        'We build the tech, the brand, and the growth — together.',
                    subtitle: 'Turning ideas into meaningful digital experiences.',
                  ),

                  // ---------------- PAGE 3 ----------------
                  _buildPage(
                    title: 'Let’s create something amazing.',
                    subtitle: 'Your digital journey starts here.',
                    showButton: true,
                  ),
                ],
              ),
            ),

            // Page indicators
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDot(isActive: _currentPage == 0),
                  _buildDot(isActive: _currentPage == 1),
                  _buildDot(isActive: _currentPage == 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable splash page
  Widget _buildPage({
    String? image,
    required String title,
    required String subtitle,
    bool showButton =false,

  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            if (image != null) ...[
              Image.asset(
                image,
                width: 180,
              ),

              const SizedBox(height: 30),
            ],

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF001465),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            if (showButton) ...[
  const SizedBox(height: 35),

  ElevatedButton(
    onPressed: () {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => const HomeScreen(),
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
],
          ],
        ),
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 4),
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