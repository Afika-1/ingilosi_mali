import 'package:flutter/material.dart';
import 'package:ingilosi_mali/screens/login_business_screen.dart';
import 'package:ingilosi_mali/screens/register_business_2.dart';
// import 'package:ingilosi_mali/screens/education_screen.dart'; // Import your Education screen
// import 'package:ingilosi_mali/screens/about_us_screen.dart'; // Import your About Us screen
// import 'package:ingilosi_mali/screens/login_screen.dart'; // Import your Login screen

class BusinessRegistrationScreen extends StatefulWidget {
  const BusinessRegistrationScreen({super.key});

  @override
  State<BusinessRegistrationScreen> createState() =>
      BusinessRegistrationScreenState();
}

class BusinessRegistrationScreenState
    extends State<BusinessRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _searchController = TextEditingController(); // Controller for search input

  bool _isPasswordVisible = false;
  bool _isMenuOpen = false;
  bool _isSearchExpanded = false; // Track search field expansion

  @override
  void dispose() {
    _fullNameController.dispose();
    _businessNameController.dispose();
    _contactNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _searchController.dispose(); // Dispose of the search controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 800;
    final formWidth = isLargeScreen ? screenWidth * 0.5 : double.infinity;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/Assets/images/register.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Header with logo and menu
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Logo
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: Image.asset(
                          'lib/assets/images/logo2.png',
                          width: 120,
                          height: 120,
                        ),
                      ),
                      // Desktop Navigation
                      if (isLargeScreen) _buildDesktopNavigation(),
                      // Hamburger Menu for Mobile
                      if (!isLargeScreen) _buildHamburgerMenu(),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Main content
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: isLargeScreen ? 50 : 24,
                      ),
                      child: SizedBox(
                        width: isLargeScreen ? 600 : double.infinity,
                        child: Column(
                          children: [
                            const SizedBox(height: 40),

                            // Registration Title
                            Text(
                              'Investor Registration',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isLargeScreen ? 56 : 48,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 2,
                                fontFamily: 'Agrandir',
                              ),
                            ),

                            SizedBox(height: isLargeScreen ? 20 : 15),

                            // Subtitle
                            Container(
                              width: isLargeScreen ? 500 : double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Complete your investor profile to connect with suitable business opportunities. Your preferences will help us match you with the right investment prospects.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: isLargeScreen ? 18 : 16,
                                  height: 1.5,
                                  letterSpacing: 0.5,
                                  fontFamily: 'Agrandir',
                                ),
                              ),
                            ),

                            SizedBox(height: isLargeScreen ? 40 : 30),

                            // Registration Form
                            SizedBox(
                              width: formWidth,
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Basic Information Section
                                    _buildSectionTitle('Basic Information', isLargeScreen),
                                    SizedBox(height: isLargeScreen ? 20 : 15),

                                    _buildTextField(
                                      controller: _fullNameController,
                                      hintText: 'Full Name *',
                                      keyboardType: TextInputType.name,
                                      isLargeScreen: isLargeScreen,
                                    ),
                                    SizedBox(height: isLargeScreen ? 25 : 20),

                                    _buildTextField(
                                      controller: _businessNameController,
                                      hintText: 'Investor/Company Name *',
                                      keyboardType: TextInputType.text,
                                      isLargeScreen: isLargeScreen,
                                    ),
                                    SizedBox(height: isLargeScreen ? 25 : 20),

                                    _buildTextField(
                                      controller: _contactNumberController,
                                      hintText: 'Contact Number *',
                                      keyboardType: TextInputType.phone,
                                      isLargeScreen: isLargeScreen,
                                    ),
                                    SizedBox(height: isLargeScreen ? 25 : 20),

                                    _buildTextField(
                                      controller: _emailController,
                                      hintText: 'Email *',
                                      keyboardType: TextInputType.emailAddress,
                                      isLargeScreen: isLargeScreen,
                                    ),
                                    SizedBox(height: isLargeScreen ? 25 : 20),

                                    _buildTextField(
                                      controller: _passwordController,
                                      hintText: 'Password *',
                                      isPassword: true,
                                      keyboardType: TextInputType.visiblePassword,
                                      isLargeScreen: isLargeScreen,
                                    ),

                                    SizedBox(height: isLargeScreen ? 40 : 30),

                                    // Register Button
                                    SizedBox(
                                      width: formWidth,
                                      height: isLargeScreen ? 60 : 55,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!.validate()) {
                                            _handleRegistration();
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF2D2D2D),
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              isLargeScreen ? 30 : 27.5,
                                            ),
                                            side: const BorderSide(
                                              color: Colors.white24,
                                              width: 1,
                                            ),
                                          ),
                                          elevation: 0,
                                        ),
                                        child: Text(
                                          'REGISTER AS INVESTOR',
                                          style: TextStyle(
                                            fontSize: isLargeScreen ? 18 : 16,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1.5,
                                            fontFamily: 'Agrandir',
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: isLargeScreen ? 50 : 40),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isLargeScreen) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.amber,
        fontSize: isLargeScreen ? 20 : 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'Agrandir',
        letterSpacing: 1,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
    bool isLargeScreen = false,
  }) {
    return SizedBox(
      height: isLargeScreen ? 60 : 55,
      child: TextFormField(
        controller: controller,
        obscureText: isPassword && !_isPasswordVisible,
        keyboardType: keyboardType,
        style: TextStyle(
          color: Colors.white,
          fontSize: isLargeScreen ? 18 : 16,
          fontFamily: 'Agrandir',
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white60,
            fontSize: isLargeScreen ? 18 : 16,
            fontWeight: FontWeight.w300,
            fontFamily: 'Agrandir',
          ),
          filled: true,
          fillColor: const Color(0xFF2D2D2D).withOpacity(0.8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              isLargeScreen ? 30 : 27.5,
            ),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              isLargeScreen ? 30 : 27.5,
            ),
            borderSide: const BorderSide(color: Colors.white24, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              isLargeScreen ? 30 : 27.5,
            ),
            borderSide: const BorderSide(color: Colors.amber, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              isLargeScreen ? 30 : 27.5,
            ),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              isLargeScreen ? 30 : 27.5,
            ),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: isLargeScreen ? 28 : 24,
            vertical: isLargeScreen ? 20 : 16,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.white60,
                    size: isLargeScreen ? 24 : 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
              : null,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          if (hintText.toLowerCase().contains('email')) {
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Please enter a valid email';
            }
          }
          if (hintText.toLowerCase().contains('password')) {
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDesktopNavigation() {
    return Row(
      children: [
        // Search Field
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _isSearchExpanded ? 200 : 0,
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: const TextStyle(color: Colors.white60),
              filled: true,
              fillColor: const Color(0xFF2D2D2D).withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
            onSubmitted: (value) {
              // Implement search logic here
              print('Searching for: $value');
            },
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              _isSearchExpanded = !_isSearchExpanded; // Toggle search field
            });
          },
          icon: const Icon(Icons.search, color: Colors.white, size: 24),
        ),
        const SizedBox(width: 40),
        _buildNavItem('Education', () => _navigateToEducation()),
        const SizedBox(width: 40),
        _buildNavItem('About us', () => _navigateToAbout()),
        const SizedBox(width: 40),
        _buildNavItem('Register', () => _navigateToRegister()),
        const SizedBox(width: 40),
        _buildNavItem('Log In', () => _navigateToLogin()),
      ],
    );
  }

  Widget _buildNavItem(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
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

  void _navigateToEducation() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => EducationScreen()), // Navigate to Education screen
    // );
  }

  void _navigateToAbout() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => AboutUsScreen()), // Navigate to About Us screen
    // );
  }

  void _navigateToRegister() {
    // Logic to navigate to Register screen
  }

  void _navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BusinessLoginScreen()), // Navigate to Login screen
    );
  }

  void _handleRegistration() {
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Investor registration submitted successfully!',
          style: TextStyle(fontFamily: 'Agrandir'),
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    // Clear form
    _fullNameController.clear();
    _businessNameController.clear();
    _contactNumberController.clear();
    _emailController.clear();
    _passwordController.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BusinessRegistrationScreen2()),
    );
  }
}