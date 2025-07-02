// import 'package:corpnet_flut/screens/business_lounge.dart';
// import 'package:corpnet_flut/screens/login_business_screen.dart';
// import 'package:corpnet_flut/screens/register_business_screen.dart';
import 'package:flutter/material.dart';
import 'package:ingilosi_mali/screens/login_business_screen.dart';
import 'package:ingilosi_mali/screens/register_business_screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isMobile = screenWidth < 768;
    final isDesktop = screenWidth >= 1024;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/asset/images/businessLounge.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Top Navigation Bar
            Positioned(
              top: isMobile ? 40 : 50,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20 : (isTablet ? 30 : 40),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo Section
                    _buildLogo(isMobile, isTablet),
                    // Navigation Menu - Desktop/Tablet
                    if (!isMobile) _buildDesktopNavigation(),
                    // Hamburger Menu - Mobile
                    if (isMobile) _buildHamburgerMenu(),
                  ],
                ),
              ),
            ),

            // Mobile Dropdown Menu
            if (isMobile && _isMenuOpen) _buildMobileDropdownMenu(),

            // Main Content
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20 : (isTablet ? 40 : 60),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Main Title
                    Text(
                      'Ingalozi Mali',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 48 : (isTablet ? 64 : 80),
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                        letterSpacing: 2.0,
                        height: 1.0,
                      ),
                    ),
                    SizedBox(height: isMobile ? 20 : 30),
                    // Subtitle
                    Text(
                      'Unlocking Capital. Empowering Small Businesses.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 16 : (isTablet ? 20 : 24),
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(height: isMobile ? 40 : 60),
                    // Action Buttons
                    _buildActionButtons(isMobile, isTablet),
                  ],
                ),
              ),
            ),

            // Decorative Elements
            if (!isMobile) ..._buildDecorativeElements(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(bool isMobile, bool isTablet) {
    return Row(
      children: [
        Container(
          width: isMobile ? 45 : (isTablet ? 55 : 60),
          height: isMobile ? 45 : (isTablet ? 55 : 60),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.featured_play_list_outlined,
                size: isMobile ? 35 : (isTablet ? 45 : 50),
                color: Colors.white.withValues(alpha: 0.8),
              ),
              Text(
                '\$',
                style: TextStyle(
                  fontSize: isMobile ? 20 : (isTablet ? 24 : 28),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFD4AF37),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: isMobile ? 10 : 15),
        Text(
          'Ingalozi Mali',
          style: TextStyle(
            fontSize: isMobile ? 18 : (isTablet ? 22 : 24),
            fontWeight: FontWeight.w300,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopNavigation() {
    return Row(
      children: [
        _buildNavItem('Education', () => _navigateToEducation()),
        const SizedBox(width: 40),
        _buildNavItem('About us', () => _navigateToAbout()),
        const SizedBox(width: 40),
        _buildNavItem('Register', () => _navigateToRegister()),
        const SizedBox(width: 40),
        _buildNavItem('Log In', () => _navigateToLogin()),
        const SizedBox(width: 30),
        IconButton(
          onPressed: () => _performSearch(),
          icon: const Icon(Icons.search, color: Colors.white, size: 24),
        ),
      ],
    );
  }

  Widget _buildHamburgerMenu() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isMenuOpen = !_isMenuOpen;
        });
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _isMenuOpen
            ? const AlwaysStoppedAnimation(1.0)
            : const AlwaysStoppedAnimation(0.0),
        color: Colors.white,
        size: 28,
      ),
    );
  }

  Widget _buildMobileDropdownMenu() {
    return Positioned(
      top: 100,
      left: 20,
      right: 20,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            _buildMobileNavItem('Education', () => _navigateToEducation()),
            _buildDivider(),
            _buildMobileNavItem('About us', () => _navigateToAbout()),
            _buildDivider(),
            _buildMobileNavItem('Register', () => _navigateToRegister()),
            _buildDivider(),
            _buildMobileNavItem('Log In', () => _navigateToLogin()),
            _buildDivider(),
            _buildMobileNavItem('Search', () => _performSearch()),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileNavItem(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isMenuOpen = false;
        });
        onTap();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: Colors.white.withValues(alpha: 0.9),
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 1, color: Colors.white.withValues(alpha: 0.1));
  }

  Widget _buildActionButtons(bool isMobile, bool isTablet) {
    if (isMobile) {
      return Column(
        children: [
          // _buildActionButton('BUSINESS\nLOUNGE \nFor Businesses', () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => BusinessLoungeScreen()),
          //   );
          // }, isMobile: true),
          // const SizedBox(height: 20),
          _buildActionButton('INVESTORS\nLOUNGE \nFor Investors', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const InvestorLoungeScreen(),
              ),
            );
          }, isMobile: true),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // _buildActionButton('BUSINESS\nLOUNGE', () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => BusinessLoungeScreen()),
          //   );
          // }),
          SizedBox(width: isTablet ? 30 : 40),
          _buildActionButton('INVESTORS\nLOUNGE', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const InvestorLoungeScreen(),
              ),
            );
          }),
        ],
      );
    }
  }

  Widget _buildActionButton(
    String text,
    VoidCallback onPressed, {
    bool isMobile = false,
  }) {
    return Container(
      width: isMobile ? double.infinity : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFD4AF37), width: 1.5),
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            const Color(0xFFD4AF37).withValues(alpha: 0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 30 : 40,
              vertical: 20,
            ),
            child: Row(
              mainAxisSize: isMobile ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 12 : 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFD4AF37),
                    letterSpacing: 1.5,
                    height: 1.3,
                  ),
                ),
                const SizedBox(width: 15),
                const Icon(
                  Icons.arrow_forward,
                  color: Color(0xFFD4AF37),
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDecorativeElements() {
    return [
      Positioned(
        top: 100,
        right: -100,
        child: Container(
          width: 400,
          height: 400,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Colors.white.withValues(alpha: 0.05),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
      Positioned(
        bottom: -150,
        left: -150,
        child: Container(
          width: 500,
          height: 500,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Colors.white.withValues(alpha: 0.03),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    ];
  }

  Widget _buildNavItem(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: Colors.white.withValues(alpha: 0.9),
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  // Navigation methods
  // void _navigateToEducation() {
  //   // Add your education screen navigation here
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text('Education page - Coming soon!')),
    // );
  // }

  // void _navigateToAbout() {
  //   // Add your about screen navigation here
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text('About us page - Coming soon!')),
  //   );
  // }

  // void _navigateToRegister() {
  //   // Add your register screen navigation here
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text('Register page - Coming soon!')),
  //   );
  // }

  // void _navigateToLogin() {
  //   // Add your login screen navigation here
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text('Login page - Coming soon!')),
  //   );
  // }

  // Navigation methods
  void _navigateToEducation() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const EducationScreen()),
    // );
     ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Education page - Coming soon!')),
    );
  }

  void _navigateToAbout() {
    // Navigator.push(
    //   context,
      // MaterialPageRoute(builder: (context) => const AboutScreen()),);
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('About us page - Coming soon!')),
    
      
    );
  }

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BusinessRegistrationScreen()),
    );
  }

  void _navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BusinessLoginScreen()),
    );
  }

  void _performSearch() {
    // Add your search functionality here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Search functionality - Coming soon!')),
    );
  }
}

// Main App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ingalozi Mali',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SF Pro Display',
      ),
      home: const LandingPage(),
    );
  }
}

void main() {
  runApp(const MyApp());
}

// Placeholder screens for navigation
class InvestorLoungeScreen extends StatelessWidget {
  const InvestorLoungeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investor Lounge'),
        backgroundColor: const Color(0xFF2D4A5A),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Investor Lounge Screen', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
