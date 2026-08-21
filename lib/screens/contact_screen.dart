import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController =
      TextEditingController();

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _phoneController =
      TextEditingController();

  final TextEditingController _messageController =
      TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTopBar(context),

              // NEW CLEAN HERO CARD
              _buildHero(isMobile),

              _buildContactSection(isMobile),

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
              fontSize: 17,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              color: Colors.white,
            ),
          ),

          const Spacer(),

          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HERO - GRADIENT CARD
  // ============================================================

  Widget _buildHero(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        isMobile ? 20 : 70,
        25,
        isMobile ? 20 : 70,
        10,
      ),
      color: const Color(0xFFF5F7FC),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 25 : 55,
          vertical: isMobile ? 32 : 42,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF003EBE),
              Color(0xFF0761DA),
              Color(0xFF089934),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppColors.deepBlue.withOpacity(0.18),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Stack(
          children: [
            // --------------------------------------------------
            // DECORATIVE CIRCLE
            // --------------------------------------------------

            Positioned(
              right: -35,
              top: -45,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
            ),

            Positioned(
              right: 30,
              bottom: -70,
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.08),
                    width: 20,
                  ),
                ),
              ),
            ),

            // --------------------------------------------------
            // CONTENT
            // --------------------------------------------------

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LABEL
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.18),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.mail_outline_rounded,
                        size: 15,
                        color: AppColors.limeGreen,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'GET IN TOUCH',
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

                const SizedBox(height: 20),

                // TITLE
                Text(
                  'Let’s build\nsomething great.',
                  style: TextStyle(
                    fontSize: isMobile ? 34 : 48,
                    height: 1,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -2,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 14),

                // SHORT DESCRIPTION
                Text(
                  'Have an idea? Let’s talk.',
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.78),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // CONTACT SECTION
  // ============================================================

  Widget _buildContactSection(bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 70,
        vertical: 60,
      ),
      child: isMobile
          ? Column(
              children: [
                _buildInfo(),
                const SizedBox(height: 35),
                _buildForm(),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: _buildInfo(),
                ),
                const SizedBox(width: 60),
                Expanded(
                  flex: 6,
                  child: _buildForm(),
                ),
              ],
            ),
    );
  }

  // ============================================================
  // CONTACT INFO
  // ============================================================

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Let’s talk.',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: AppColors.navyBlue,
          ),
        ),

        const SizedBox(height: 14),

        Text(
          'Whether you have a question, a project idea, '
          'or simply want to know more about what we do, '
          'we would love to hear from you.',
          style: TextStyle(
            fontSize: 14,
            height: 1.6,
            color: Colors.grey.shade600,
          ),
        ),

        const SizedBox(height: 35),

        _infoCard(
          Icons.email_outlined,
          'Email',
          'hello@urbanova.com',
        ),

        _infoCard(
          Icons.phone_outlined,
          'Phone',
          '+91 00000 00000',
        ),

        _infoCard(
          Icons.location_on_outlined,
          'Location',
          'Bangalore, India',
        ),
      ],
    );
  }

  // ============================================================
  // INFO CARD
  // ============================================================

  Widget _infoCard(
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE7EBF3),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              gradient: AppColors.greenGradient,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 21,
            ),
          ),

          const SizedBox(width: 14),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: AppColors.navyBlue,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FORM
  // ============================================================

  Widget _buildForm() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: const Color(0xFFE7EBF3),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.navyBlue.withOpacity(0.06),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tell us about your project',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: AppColors.navyBlue,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Fill in the details below and we’ll get back to you.',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 25),

            _textField(
              controller: _nameController,
              label: 'Your Name',
              hint: 'Enter your name',
              icon: Icons.person_outline_rounded,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            _textField(
              controller: _emailController,
              label: 'Email Address',
              hint: 'Enter your email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your email';
                }

                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            _textField(
              controller: _phoneController,
              label: 'Phone Number',
              hint: 'Enter your phone number',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            _textField(
              controller: _messageController,
              label: 'Message',
              hint: 'Tell us about your project...',
              icon: Icons.chat_bubble_outline_rounded,
              maxLines: 5,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your message';
                }
                return null;
              },
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.deepBlue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    vertical: 17,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Send Enquiry',
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
          ],
        ),
      ),
    );
  }

  // ============================================================
  // TEXT FIELD
  // ============================================================

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: AppColors.navyBlue,
          ),
        ),

        const SizedBox(height: 8),

        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Padding(
              padding: EdgeInsets.only(
                bottom: maxLines > 1 ? 65 : 0,
              ),
              child: Icon(
                icon,
                size: 19,
              ),
            ),
            filled: true,
            fillColor: const Color(0xFFF7F9FD),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: const BorderSide(
                color: Color(0xFFE7EBF3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: const BorderSide(
                color: AppColors.deepBlue,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SUBMIT
  // ============================================================

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Thank you! Your enquiry has been submitted.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );

    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _messageController.clear();
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
              return AppColors.greenGradient.createShader(
                bounds,
              );
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