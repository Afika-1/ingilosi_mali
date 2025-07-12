import 'package:flutter/material.dart';
import 'package:ingilosi_mali/screens/login_business_screen.dart';

class BusinessRegistrationScreen2 extends StatefulWidget {
  const BusinessRegistrationScreen2({super.key});

  @override
  State<BusinessRegistrationScreen2> createState() =>
      BusinessRegistrationScreen2State();
}

class BusinessRegistrationScreen2State
    extends State<BusinessRegistrationScreen2> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _geographicalLocationController = TextEditingController();

  bool _isPasswordVisible = false;

  // Industry dropdown values
  String? _firstIndustryChoice;
  String? _secondIndustryChoice;
  String? _thirdIndustryChoice;

  // Investment range dropdown
  String? _investmentRange;

  // Requirements checklist
  final Map<String, bool> _requirements = {
    'Tax clearance': false,
    'Company Registration Documents': false,
    'Tax Clearance Certificate': false,
    'Valid BBBEE Certificate': false,
    'Proof of Business Banking (not older than 3 months)': false,
    'Proof of Business address (not older than 3 months)': false,
    'Company Profile': false,
    'Detailed Business Plan': false,
    'Assigned Business Advisor to your company': false,
    'Latest compiled financial report': false,
    '6 months bank statements': false,
    'Does your business have a turnover of more than R250 000pa': false,
    'Is the business profitable': false,
    'Do you have collateral': false,
    'Does the business have a good credit record': false,
    'Does the Business owner have a good credit record': false,
  };

  final List<String> _industries = [
    'Technology',
    'Healthcare',
    'Finance',
    'Retail',
    'Manufacturing',
    'Real Estate',
    'Agriculture',
    'Energy',
    'Transportation',
    'Education',
    'Hospitality',
    'Construction',
    'Media & Entertainment',
    'Food & Beverage',
    'Automotive',
  ];

  final List<String> _investmentRanges = ['50k-100k', '100k-250k', '250k-500k'];

  @override
  void dispose() {
    _fullNameController.dispose();
    _businessNameController.dispose();
    _contactNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _geographicalLocationController.dispose();
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
          decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.4)),
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
                        Colors.white.withValues(alpha: 0.15),
                        Colors.white.withValues(alpha: 0.08),
                        Colors.white.withValues(alpha: 0.08),
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
                        Colors.white.withValues(alpha: 0.15),
                        Colors.white.withValues(alpha: 0.08),
                        Colors.white.withValues(alpha: 0.03),
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
                                          'lib/assets/images/logo2.png',
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
                                  // Investment Preferences Section
                                  _buildSectionTitle(
                                    'Investment Preferences',
                                    isLargeScreen,
                                  ),
                                  SizedBox(height: isLargeScreen ? 20 : 15),

                                  // Industry of Interest Dropdowns
                                  Text(
                                    'Industry of Interest (Select 3 in order of preference)',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: isLargeScreen ? 16 : 14,
                                      fontFamily: 'Agrandir',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: isLargeScreen ? 15 : 10),

                                  _buildDropdown(
                                    value: _firstIndustryChoice,
                                    hintText: 'First Choice *',
                                    items: _industries,
                                    onChanged: (value) => setState(
                                      () => _firstIndustryChoice = value,
                                    ),
                                    isLargeScreen: isLargeScreen,
                                  ),
                                  SizedBox(height: isLargeScreen ? 20 : 15),

                                  _buildDropdown(
                                    value: _secondIndustryChoice,
                                    hintText: 'Second Choice *',
                                    items: _industries
                                        .where(
                                          (item) =>
                                              item != _firstIndustryChoice,
                                        )
                                        .toList(),
                                    onChanged: (value) => setState(
                                      () => _secondIndustryChoice = value,
                                    ),
                                    isLargeScreen: isLargeScreen,
                                  ),
                                  SizedBox(height: isLargeScreen ? 20 : 15),

                                  _buildDropdown(
                                    value: _thirdIndustryChoice,
                                    hintText: 'Third Choice *',
                                    items: _industries
                                        .where(
                                          (item) =>
                                              item != _firstIndustryChoice &&
                                              item != _secondIndustryChoice,
                                        )
                                        .toList(),
                                    onChanged: (value) => setState(
                                      () => _thirdIndustryChoice = value,
                                    ),
                                    isLargeScreen: isLargeScreen,
                                  ),
                                  SizedBox(height: isLargeScreen ? 25 : 20),

                                  // Investment Range Dropdown
                                  _buildDropdown(
                                    value: _investmentRange,
                                    hintText: 'Investment Offer Range *',
                                    items: _investmentRanges,
                                    onChanged: (value) => setState(
                                      () => _investmentRange = value,
                                    ),
                                    isLargeScreen: isLargeScreen,
                                  ),
                                  SizedBox(height: isLargeScreen ? 25 : 20),

                                  // Geographical Location
                                  _buildTextField(
                                    controller: _geographicalLocationController,
                                    hintText: 'Geographical Location *',
                                    keyboardType: TextInputType.text,
                                    isLargeScreen: isLargeScreen,
                                  ),

                                  SizedBox(height: isLargeScreen ? 40 : 30),

                                  // Requirements Section
                                  _buildSectionTitle(
                                    'Requirements from Business Owner',
                                    isLargeScreen,
                                  ),
                                  SizedBox(height: isLargeScreen ? 20 : 15),

                                  Text(
                                    'Select all requirements you expect from potential business partners:',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: isLargeScreen ? 14 : 12,
                                      fontFamily: 'Agrandir',
                                    ),
                                  ),
                                  SizedBox(height: isLargeScreen ? 15 : 10),

                                  // Requirements Checklist
                                  _buildRequirementsChecklist(isLargeScreen),

                                  SizedBox(height: isLargeScreen ? 40 : 30),
                                ],
                              ),
                            ),
                          ),

                          // Register Button
                          SizedBox(
                            width: formWidth,
                            height: isLargeScreen ? 60 : 55,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (_validateForm()) {
                                    _handleRegistration();
                                  }
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
            borderRadius: BorderRadius.circular(isLargeScreen ? 30 : 27.5),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(isLargeScreen ? 30 : 27.5),
            borderSide: const BorderSide(color: Colors.white24, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(isLargeScreen ? 30 : 27.5),
            borderSide: const BorderSide(color: Colors.amber, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(isLargeScreen ? 30 : 27.5),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(isLargeScreen ? 30 : 27.5),
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

  Widget _buildDropdown({
    required String? value,
    required String hintText,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    bool isLargeScreen = false,
  }) {
    return SizedBox(
      height: isLargeScreen ? 60 : 55,
      child: DropdownButtonFormField<String>(
        value: value,
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
            borderRadius: BorderRadius.circular(isLargeScreen ? 30 : 27.5),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(isLargeScreen ? 30 : 27.5),
            borderSide: const BorderSide(color: Colors.white24, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(isLargeScreen ? 30 : 27.5),
            borderSide: const BorderSide(color: Colors.amber, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(isLargeScreen ? 30 : 27.5),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(isLargeScreen ? 30 : 27.5),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: isLargeScreen ? 28 : 24,
            vertical: isLargeScreen ? 20 : 16,
          ),
        ),
        style: TextStyle(
          color: Colors.white,
          fontSize: isLargeScreen ? 18 : 16,
          fontFamily: 'Agrandir',
        ),
        dropdownColor: const Color(0xFF2D2D2D),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white60),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextStyle(
                color: Colors.white,
                fontSize: isLargeScreen ? 16 : 14,
                fontFamily: 'Agrandir',
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select an option';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildRequirementsChecklist(bool isLargeScreen) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(isLargeScreen ? 20 : 15),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      padding: EdgeInsets.all(isLargeScreen ? 20 : 16),
      child: Column(
        children: _requirements.keys.map((requirement) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: isLargeScreen ? 8 : 6),
            child: Row(
              children: [
                Checkbox(
                  value: _requirements[requirement],
                  onChanged: (bool? value) {
                    setState(() {
                      _requirements[requirement] = value ?? false;
                    });
                  },
                  activeColor: Colors.amber,
                  checkColor: Colors.black,
                  side: const BorderSide(color: Colors.white60, width: 1.5),
                ),
                SizedBox(width: isLargeScreen ? 12 : 8),
                Expanded(
                  child: Text(
                    requirement,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isLargeScreen ? 14 : 12,
                      fontFamily: 'Agrandir',
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  bool _validateForm() {
    if (_firstIndustryChoice == null ||
        _secondIndustryChoice == null ||
        _thirdIndustryChoice == null) {
      _showErrorMessage('Please select all three industry preferences');
      return false;
    }

    if (_investmentRange == null) {
      _showErrorMessage('Please select an investment range');
      return false;
    }

    bool hasSelectedRequirement = _requirements.values.any(
      (selected) => selected,
    );
    if (!hasSelectedRequirement) {
      _showErrorMessage('Please select at least one requirement');
      return false;
    }

    return true;
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontFamily: 'Agrandir')),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
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
    _geographicalLocationController.clear();

    setState(() {
      _firstIndustryChoice = null;
      _secondIndustryChoice = null;
      _thirdIndustryChoice = null;
      _investmentRange = null;
      _requirements.updateAll((key, value) => false);
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BusinessLoginScreen()),
    );
  }
}
