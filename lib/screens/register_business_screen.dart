// import 'package:corpnet_flut/screens/login_business_screen.dart';
import 'package:flutter/material.dart';
import 'package:ingilosi_mali/screens/login_business_screen.dart';

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

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _businessNameController.dispose();
    _contactNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
            image: AssetImage('lib/asset/images/register.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          // Dark overlay to ensure text readability
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
          ),
          child: Stack(
            children: [
              // Top left white gradient
              Positioned(
                top: -10,
                left: -100,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 0.5,
                      colors: [
                        Colors.white.withOpacity(0.15),
                        Colors.white.withOpacity(0.08),
                        Colors.white.withOpacity(0.08),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.4, 0.7, 1.0],
                    ),
                  ),
                ),
              ),
              // Bottom right white gradient
              Positioned(
                bottom: -100,
                right: -100,
                child: Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 1.0,
                      colors: [
                        Colors.white.withOpacity(0.15),
                        Colors.white.withOpacity(0.08),
                        Colors.white.withOpacity(0.03),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.4, 0.7, 1.0],
                    ),
                  ),
                ),
              ),
              // Main content
              SafeArea(
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

                          // Header with logo and menu
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Spacer(),
                              SizedBox(
                                width: isLargeScreen ? 150 : 120,
                                height: isLargeScreen ? 150 : 120,
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Center(
                                        child: Image.asset(
                                          'lib/asset/images/logo2.png',
                                          width: isLargeScreen ? 150 : 120,
                                          height: isLargeScreen ? 150 : 120,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 25,
                                      height: 3,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      width: 25,
                                      height: 3,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      width: 25,
                                      height: 3,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: isLargeScreen ? 40 : 30),

                          // Registration Title
                          Text(
                            'Registration',
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

                          // Registration Form
                          SizedBox(
                            width: formWidth,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  _buildTextField(
                                    controller: _fullNameController,
                                    hintText: 'Full Name *',
                                    keyboardType: TextInputType.name,
                                    isLargeScreen: isLargeScreen,
                                  ),
                                  SizedBox(height: isLargeScreen ? 25 : 20),

                                  _buildTextField(
                                    controller: _businessNameController,
                                    hintText: 'Business Name *',
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
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: isLargeScreen ? 40 : 30),

                          // Register Button
                          SizedBox(
                            width: formWidth,
                            height: isLargeScreen ? 60 : 55,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Handle registration
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
                                'REGISTER',
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
                ),
              ),
            ],
          ),
        ),
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

  void _handleRegistration() {
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Registration submitted successfully!',
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
      MaterialPageRoute(builder: (context) =>  BusinessLoginScreen()),
    );
  }
}