import 'package:flutter/material.dart';
import 'package:ingilosi_mali/screens/business_lounge.dart';
// import 'package:ingilosi_mali/screens/login_business_screen.dart';
import 'package:ingilosi_mali/screens/register_business_screen.dart';

class BusinessLoginScreen extends StatefulWidget {
  const BusinessLoginScreen({super.key});

  @override
  State<BusinessLoginScreen> createState() => BusinessLoginScreenState();
}

class BusinessLoginScreenState extends State<BusinessLoginScreen> {
  final _formKey = GlobalKey<FormState>();
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
    'Login Help',
    'Contact Support'
  ];

  @override
  void dispose() {
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

    // Show search results in a snackbar or dialog
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
    final formWidth = isLargeScreen ? screenWidth * 0.4 : screenWidth * 0.9;

    return Scaffold(
      backgroundColor: Colors.black,
      drawer: isLargeScreen ? null : _buildDrawer(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/register.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha:0.5),
          ),
          child: Column(
            children: [
              // Fixed Header
              _buildHeader(isLargeScreen),
              
              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isLargeScreen ? 50 : 24,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: screenHeight - 120, // Account for header
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Login Title
                          Text(
                            'Login',
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
                              'Kindly complete your details to finalize your registration. Your prompt response will help us process your registration smoothly. Thank you!',
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

                          // Login Form
                          SizedBox(
                            width: formWidth,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  _buildSectionTitle(
                                    'Login Information',
                                    isLargeScreen,
                                  ),
                                  SizedBox(height: isLargeScreen ? 20 : 15),
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
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: isLargeScreen ? 40 : 30),

                          // Login Button
                          SizedBox(
                            width: formWidth,
                            height: isLargeScreen ? 60 : 55,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _handleLogin();
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
                                'LOGIN',
                                style: TextStyle(
                                  fontSize: isLargeScreen ? 18 : 16,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
                                  fontFamily: 'Agrandir',
                                ),
                              ),
                            ),
                          ),

                        Container(
                            width: isLargeScreen ? 500 : double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Text(
                              
                              'Not our community member yet? ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: isLargeScreen ? 18 : 16,
                                height: 1.5,
                                letterSpacing: 0.5,
                                fontFamily: 'Agrandir',
                              ),

                            ),
                            Text('Register Now!', textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: isLargeScreen ? 18 : 16,
                                height: 1.5,
                                letterSpacing: 0.5,
                                fontFamily: 'Agrandir',
                              ),)
                              ],
                            ) 
                            

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


  Widget _buildHeader(bool isLargeScreen) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha:0.3),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha:0.1),
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
              width: _isSearchExpanded ? 200 : 0,
              height: 40,
              child: _isSearchExpanded
                  ? TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: const TextStyle(color: Colors.white60),
                        filled: true,
                        fillColor: const Color(0xFF2D2D2D).withValues(alpha:0.8),
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
              color: Colors.black.withValues(alpha:0.3),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withValues(alpha:0.1),
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
                fillColor: const Color(0xFF2D2D2D).withValues(alpha:0.8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (value) {
                _performSearch(value);
                Navigator.pop(context); // Close drawer after search
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
        Navigator.pop(context); // Close drawer first
        onTap(); // Then execute the navigation
      },
      hoverColor: Colors.white.withValues(alpha:0.1),
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
          fillColor: const Color(0xFF2D2D2D).withValues(alpha:0.8),
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BusinessRegistrationScreen()),
    );
  }

  void _navigateToLogin() {
    // Since we're already on the login screen, just show a message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('You are already on the login page'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _handleLogin() {
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Login submitted successfully!',
          style: TextStyle(fontFamily: 'Agrandir'),
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 3),
      ),
    );

    // Clear form
    _emailController.clear();
    _passwordController.clear();

    // Navigate to business lounge
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BusinessLoungeScreen()),
    );
  }
}