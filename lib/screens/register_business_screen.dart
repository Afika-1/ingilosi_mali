import 'package:flutter/material.dart';
import 'package:ingilosi_mali/screens/login_business_screen.dart';
import 'package:ingilosi_mali/screens/register_business_2.dart';

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
  final _searchController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isSearchExpanded = false;
  List<String> _searchResults = [];
  final List<String> _searchableContent = [
    'Education',
    'About us',
    'Register',
    'Log In',
    'Business Registration',
    'Investor Registration',
    'Contact Support'
  ];

  @override
  void dispose() {
    _fullNameController.dispose();
    _businessNameController.dispose();
    _contactNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _searchResults = _searchableContent
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });

    if (_searchResults.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Found: ${_searchResults.join(', ')}'),
          duration: const Duration(seconds: 3),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No results found'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLargeScreen = screenWidth > 800;
    final formWidth = isLargeScreen ? screenWidth * 0.5 : screenWidth * 0.9;

    return Scaffold(
      backgroundColor: Colors.black,
      drawer: isLargeScreen ? null : _buildDrawer(),
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
            color: Colors.black.withValues(alpha: 0.5),
          ),
          child: Column(
            children: [
              // Fixed Header
              _buildHeader(isLargeScreen),
              
              // Main Content with Footer
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Registration Form Content with padding
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isLargeScreen ? 50 : 24,
                        ),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: screenHeight - 200, // Account for header and footer
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                      
                      // Footer - No padding, full width
                      _buildFooter(!isLargeScreen),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isLargeScreen) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.3),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          _buildLogo(isLargeScreen),
          
          // Navigation
          if (isLargeScreen)
            _buildDesktopNavigation()
          else
            Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu, color: Colors.white, size: 28),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLogo(bool isLargeScreen) {
    return Image.asset(
      'lib/assets/images/logo2.png',
      height: isLargeScreen ? 50 : 40,
      fit: BoxFit.contain,
    );
  }

  Widget _buildDesktopNavigation() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Search functionality
        Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _isSearchExpanded ? 300 : 0,
              height: 40,
              child: _isSearchExpanded
                  ? TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: const TextStyle(color: Colors.white60),
                        filled: true,
                        fillColor: const Color(0xFF2D2D2D).withValues(alpha: 0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                      onSubmitted: _performSearch,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            _searchResults = [];
                          });
                        }
                      },
                    )
                  : const SizedBox.shrink(),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _isSearchExpanded = !_isSearchExpanded;
                  if (!_isSearchExpanded) {
                    _searchController.clear();
                    _searchResults = [];
                  }
                });
              },
              icon: Icon(
                _isSearchExpanded ? Icons.close : Icons.search,
                color: Colors.white,
                size: 24,
              ),
            ),
          ],
        ),
        
        const SizedBox(width: 20),
        
        // Navigation items
        _buildNavItem('Education', _navigateToEducation),
        const SizedBox(width: 30),
        _buildNavItem('About us', _navigateToAbout),
        const SizedBox(width: 30),
        _buildNavItem('Register', _navigateToRegister),
        const SizedBox(width: 30),
        _buildNavItem('Log In', _navigateToLogin),
      ],
    );
  }

  Widget _buildNavItem(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF1A1A1A),
      child: Column(
        children: [
          // Drawer header with logo
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
            ),
            child: DrawerHeader(
              margin: EdgeInsets.zero,
              child: _buildLogo(false),
            ),
          ),
          
          // Search in drawer
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: const TextStyle(color: Colors.white60),
                prefixIcon: const Icon(Icons.search, color: Colors.white60),
                filled: true,
                fillColor: const Color(0xFF2D2D2D).withValues(alpha: 0.8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (value) {
                _performSearch(value);
                Navigator.pop(context);
              },
            ),
          ),
          
          // Navigation items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem('Education', Icons.school, _navigateToEducation),
                _buildDrawerItem('About us', Icons.info_outline, _navigateToAbout),
                _buildDrawerItem('Register', Icons.person_add, _navigateToRegister),
                _buildDrawerItem('Log In', Icons.login, _navigateToLogin),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      hoverColor: Colors.white.withValues(alpha: 0.1),
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
          fillColor: const Color(0xFF2D2D2D).withValues(alpha: 0.8),
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

  Widget _buildFooter(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 60,
        horizontal: isMobile ? 20 : 60,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.9),
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          isMobile
              ? Column(
                  children: [
                    _buildFooterSection('Company', [
                      'About Us',
                      'Careers',
                      'Press',
                      'Blog',
                    ]),
                    const SizedBox(height: 30),
                    _buildFooterSection('Support', [
                      'Help Center',
                      'Contact Us',
                      'Terms of Service',
                      'Privacy Policy',
                    ]),
                    const SizedBox(height: 30),
                    _buildFooterSection('Follow Us', [
                      'Twitter',
                      'LinkedIn',
                      'Facebook',
                      'Instagram',
                    ]),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFooterSection('Company', [
                      'About Us',
                      'Careers',
                      'Press',
                      'Blog',
                    ]),
                    _buildFooterSection('Support', [
                      'Help Center',
                      'Contact Us',
                      'Terms of Service',
                      'Privacy Policy',
                    ]),
                    _buildFooterSection('Follow Us', [
                      'Twitter',
                      'LinkedIn',
                      'Facebook',
                      'Instagram',
                    ]),
                  ],
                ),
          SizedBox(height: isMobile ? 30 : 40),
          Divider(
            color: Colors.white.withValues(alpha: 0.1),
          ),
          const SizedBox(height: 20),
          const Text(
            '© 2025 Ingilosi Mali. All rights reserved.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 15),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$item - Coming soon!')),
                );
              },
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToEducation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Education page - Coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _navigateToAbout() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('About us page - Coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _navigateToRegister() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('You are already on the registration page'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BusinessLoginScreen()),
    );
  }

  void _handleRegistration() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Investor registration submitted successfully!',
          style: TextStyle(fontFamily: 'Agrandir'),
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 3),
      ),
    );

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