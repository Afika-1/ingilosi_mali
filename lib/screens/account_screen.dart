import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:alternative_funds/screens/business_lounge.dart';
import 'dart:io';

import 'package:alternative_funds/screens/dashboard.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  // Basic Information Controllers
  final _fullNameController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _geographicalLocationController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isSearchExpanded = false;
  bool _isEditMode = false;
  List<String> _searchResults = [];
  File? _profileImage;
  String? _profileImageUrl; // For existing profile images from server

  final List<String> _searchableContent = [
    'Education',
    'About us'
        'Dashboard',
    'Account',
    'Log Out',
    'Edit Profile',
    'Investment Preferences',
    'Contact Support',
  ];

  // Investment Preferences
  String? _firstIndustryChoice;
  String? _secondIndustryChoice;
  String? _thirdIndustryChoice;
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
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    // Simulate loading user data - in a real app, this would come from a database/API
    setState(() {
      _fullNameController.text = 'John Doe';
      _businessNameController.text = 'Doe Investments';
      _contactNumberController.text = '+27 123 456 789';
      _emailController.text = 'john.doe@email.com';
      _passwordController.text = 'password123';
      _geographicalLocationController.text = 'Cape Town, South Africa';
      _firstIndustryChoice = 'Technology';
      _secondIndustryChoice = 'Healthcare';
      _thirdIndustryChoice = 'Finance';
      _investmentRange = '100k-250k';

      // Sample requirements selection
      _requirements['Tax clearance'] = true;
      _requirements['Company Registration Documents'] = true;
      _requirements['Valid BBBEE Certificate'] = true;
      _requirements['Detailed Business Plan'] = true;
      _requirements['Is the business profitable'] = true;

      // Sample profile image URL (replace with actual URL from your backend)
      _profileImageUrl =
          null; // Set to null initially, would be loaded from server
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _businessNameController.dispose();
    _contactNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _geographicalLocationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    if (!_isEditMode) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2D2D2D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Select Profile Photo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Agrandir',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImageSourceOption(
                    icon: Icons.photo_library,
                    label: 'Gallery',
                    onTap: () => _selectImage(ImageSource.gallery),
                  ),
                  _buildImageSourceOption(
                    icon: Icons.camera_alt,
                    label: 'Camera',
                    onTap: () => _selectImage(ImageSource.camera),
                  ),
                  if (_profileImage != null || _profileImageUrl != null)
                    _buildImageSourceOption(
                      icon: Icons.delete,
                      label: 'Remove',
                      onTap: _removeImage,
                      isDestructive: true,
                    ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageSourceOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isDestructive
                  ? Colors.red.withValues(alpha: 0.2)
                  : Colors.amber.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: isDestructive ? Colors.red : Colors.amber,
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              color: isDestructive ? Colors.red : Colors.amber,
              size: 28,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: isDestructive ? Colors.red : Colors.white,
            fontSize: 12,
            fontFamily: 'Agrandir',
          ),
        ),
      ],
    );
  }

  Future<void> _selectImage(ImageSource source) async {
    Navigator.pop(context);

    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _profileImage = File(image.path);
          _profileImageUrl = null; // Clear the URL when a new image is selected
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile photo selected successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error selecting image: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _removeImage() {
    Navigator.pop(context);
    setState(() {
      _profileImage = null;
      _profileImageUrl = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile photo removed'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget _buildProfileAvatar(bool isLargeScreen) {
    final double avatarSize = isLargeScreen ? 120 : 100;

    return Stack(
      children: [
        Container(
          width: avatarSize,
          height: avatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.amber, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: avatarSize / 2,
            backgroundColor: const Color(0xFF2D2D2D),
            backgroundImage: _profileImage != null
                ? FileImage(_profileImage!)
                : _profileImageUrl != null
                ? NetworkImage(_profileImageUrl!)
                : null,
            child: _profileImage == null && _profileImageUrl == null
                ? Icon(
                    Icons.person,
                    size: avatarSize * 0.5,
                    color: Colors.white60,
                  )
                : null,
          ),
        ),
        if (_isEditMode)
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: _pickImage,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                  size: 16,
                ),
              ),
            ),
          ),
      ],
    );
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

  void _handleSaveChanges() {
    if (_formKey.currentState!.validate()) {
      // Here you would typically upload the profile image to your server
      // and save all the form data

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Changes saved successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
      setState(() {
        _isEditMode = false;
        // In a real app, you would convert the File to a URL after upload
        if (_profileImage != null) {
          // _profileImageUrl = 'uploaded_image_url'; // Set after successful upload
        }
      });
    }
  }

  void _navigateToEducation() {
    // Navigate to education screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navigating to Education... comming soon'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _navigateToAbout() {
    // Navigate to about screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navigating to About Us... comming soon'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _navigateToDashboard() {
    // Navigate to about page
    // print('Navigate to Dashboard');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => InvestorDashboard()),
    );
  }

  void _navigateToLogout() {
    // Show logout confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2D2D2D),
          title: const Text(
            'Confirm Logout',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Are you sure you want to log out?',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BusinessLoungeScreen(),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logged out successfully'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.amber),
              ),
            ),
          ],
        );
      },
    );
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
          decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.5)),
          child: Column(
            children: [
              // Fixed Header
              _buildHeader(isLargeScreen),

              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Account Content
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isLargeScreen ? 50 : 24,
                        ),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: screenHeight - 200,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 40),

                                // Profile Avatar
                                _buildProfileAvatar(isLargeScreen),

                                SizedBox(height: isLargeScreen ? 30 : 20),

                                // Account Title
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'My Account',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: isLargeScreen ? 56 : 48,
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 2,
                                        fontFamily: 'Agrandir',
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isEditMode = !_isEditMode;
                                        });
                                      },
                                      icon: Icon(
                                        _isEditMode ? Icons.save : Icons.edit,
                                        color: Colors.amber,
                                        size: isLargeScreen ? 32 : 28,
                                      ),
                                      tooltip: _isEditMode
                                          ? 'Save Changes'
                                          : 'Edit Profile',
                                    ),
                                  ],
                                ),

                                SizedBox(height: isLargeScreen ? 20 : 15),

                                // Subtitle
                                Container(
                                  width: isLargeScreen ? 500 : double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    _isEditMode
                                        ? 'Update your investor profile and preferences below.'
                                        : 'Manage your investor profile and investment preferences.',
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

                                // Account Form
                                SizedBox(
                                  width: formWidth,
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Basic Information Section
                                        _buildSectionTitle(
                                          'Basic Information',
                                          isLargeScreen,
                                        ),
                                        SizedBox(
                                          height: isLargeScreen ? 20 : 15,
                                        ),

                                        _buildTextField(
                                          controller: _fullNameController,
                                          hintText: 'Full Name *',
                                          keyboardType: TextInputType.name,
                                          isLargeScreen: isLargeScreen,
                                          enabled: _isEditMode,
                                        ),
                                        SizedBox(
                                          height: isLargeScreen ? 25 : 20,
                                        ),

                                        _buildTextField(
                                          controller: _businessNameController,
                                          hintText: 'Investor/Company Name *',
                                          keyboardType: TextInputType.text,
                                          isLargeScreen: isLargeScreen,
                                          enabled: _isEditMode,
                                        ),
                                        SizedBox(
                                          height: isLargeScreen ? 25 : 20,
                                        ),

                                        _buildTextField(
                                          controller: _contactNumberController,
                                          hintText: 'Contact Number *',
                                          keyboardType: TextInputType.phone,
                                          isLargeScreen: isLargeScreen,
                                          enabled: _isEditMode,
                                        ),
                                        SizedBox(
                                          height: isLargeScreen ? 25 : 20,
                                        ),

                                        _buildTextField(
                                          controller: _emailController,
                                          hintText: 'Email *',
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          isLargeScreen: isLargeScreen,
                                          enabled: _isEditMode,
                                        ),
                                        SizedBox(
                                          height: isLargeScreen ? 25 : 20,
                                        ),

                                        _buildTextField(
                                          controller: _passwordController,
                                          hintText: 'Password *',
                                          isPassword: true,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          isLargeScreen: isLargeScreen,
                                          enabled: _isEditMode,
                                        ),
                                        SizedBox(
                                          height: isLargeScreen ? 25 : 20,
                                        ),

                                        _buildTextField(
                                          controller:
                                              _geographicalLocationController,
                                          hintText: 'Geographical Location *',
                                          keyboardType: TextInputType.text,
                                          isLargeScreen: isLargeScreen,
                                          enabled: _isEditMode,
                                        ),

                                        SizedBox(
                                          height: isLargeScreen ? 40 : 30,
                                        ),

                                        // Investment Preferences Section
                                        _buildSectionTitle(
                                          'Investment Preferences',
                                          isLargeScreen,
                                        ),
                                        SizedBox(
                                          height: isLargeScreen ? 20 : 15,
                                        ),

                                        Text(
                                          'Industry of Interest (In order of preference)',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: isLargeScreen ? 16 : 14,
                                            fontFamily: 'Agrandir',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: isLargeScreen ? 15 : 10,
                                        ),

                                        _buildDropdown(
                                          value: _firstIndustryChoice,
                                          hintText: 'First Choice *',
                                          items: _industries,
                                          onChanged: _isEditMode
                                              ? (value) => setState(
                                                  () => _firstIndustryChoice =
                                                      value,
                                                )
                                              : null,
                                          isLargeScreen: isLargeScreen,
                                        ),
                                        SizedBox(
                                          height: isLargeScreen ? 20 : 15,
                                        ),

                                        _buildDropdown(
                                          value: _secondIndustryChoice,
                                          hintText: 'Second Choice *',
                                          items: _industries
                                              .where(
                                                (item) =>
                                                    item !=
                                                    _firstIndustryChoice,
                                              )
                                              .toList(),
                                          onChanged: _isEditMode
                                              ? (value) => setState(
                                                  () => _secondIndustryChoice =
                                                      value,
                                                )
                                              : null,
                                          isLargeScreen: isLargeScreen,
                                        ),
                                        SizedBox(
                                          height: isLargeScreen ? 20 : 15,
                                        ),

                                        _buildDropdown(
                                          value: _thirdIndustryChoice,
                                          hintText: 'Third Choice *',
                                          items: _industries
                                              .where(
                                                (item) =>
                                                    item !=
                                                        _firstIndustryChoice &&
                                                    item !=
                                                        _secondIndustryChoice,
                                              )
                                              .toList(),
                                          onChanged: _isEditMode
                                              ? (value) => setState(
                                                  () => _thirdIndustryChoice =
                                                      value,
                                                )
                                              : null,
                                          isLargeScreen: isLargeScreen,
                                        ),
                                        SizedBox(
                                          height: isLargeScreen ? 25 : 20,
                                        ),

                                        _buildDropdown(
                                          value: _investmentRange,
                                          hintText: 'Investment Offer Range *',
                                          items: _investmentRanges,
                                          onChanged: _isEditMode
                                              ? (value) => setState(
                                                  () =>
                                                      _investmentRange = value,
                                                )
                                              : null,
                                          isLargeScreen: isLargeScreen,
                                        ),

                                        SizedBox(
                                          height: isLargeScreen ? 40 : 30,
                                        ),

                                        // Requirements Section
                                        _buildSectionTitle(
                                          'Requirements from Business Owner',
                                          isLargeScreen,
                                        ),
                                        SizedBox(
                                          height: isLargeScreen ? 20 : 15,
                                        ),

                                        Text(
                                          'Your selected requirements from potential business partners:',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: isLargeScreen ? 14 : 12,
                                            fontFamily: 'Agrandir',
                                          ),
                                        ),
                                        SizedBox(
                                          height: isLargeScreen ? 15 : 10,
                                        ),

                                        _buildRequirementsChecklist(
                                          isLargeScreen,
                                        ),

                                        SizedBox(
                                          height: isLargeScreen ? 40 : 30,
                                        ),

                                        // Save Button (only visible in edit mode)
                                        if (_isEditMode)
                                          SizedBox(
                                            width: formWidth,
                                            height: isLargeScreen ? 60 : 55,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  _handleSaveChanges();
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.amber,
                                                foregroundColor: Colors.black,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        isLargeScreen
                                                            ? 30
                                                            : 27.5,
                                                      ),
                                                ),
                                                elevation: 0,
                                              ),
                                              child: Text(
                                                'SAVE CHANGES',
                                                style: TextStyle(
                                                  fontSize: isLargeScreen
                                                      ? 18
                                                      : 16,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 1.5,
                                                  fontFamily: 'Agrandir',
                                                ),
                                              ),
                                            ),
                                          ),

                                        SizedBox(
                                          height: isLargeScreen ? 50 : 40,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Footer
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
                        fillColor: const Color(
                          0xFF2D2D2D,
                        ).withValues(alpha: 0.8),
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
        _buildNavItem('Dashboard', _navigateToDashboard),
        const SizedBox(width: 30),
        _buildNavItem('Account', () {}), // Current page
        const SizedBox(width: 30),
        _buildNavItem('Log Out', _navigateToLogout),
        const SizedBox(width: 30),
      ],
    );
  }

  Widget _buildNavItem(String title, VoidCallback onTap) {
    bool isCurrentPage = title == 'Account';
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          title,
          style: TextStyle(
            color: isCurrentPage ? Colors.amber : Colors.white,
            fontSize: 16,
            fontWeight: isCurrentPage ? FontWeight.w600 : FontWeight.w400,
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
          // Drawer Header
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.amber.withValues(alpha: 0.3),
                  Colors.amber.withValues(alpha: 0.1),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildProfileAvatar(false),
                const SizedBox(height: 10),
                Text(
                  _fullNameController.text.isNotEmpty
                      ? _fullNameController.text
                      : 'User',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Agrandir',
                  ),
                ),
              ],
            ),
          ),

          // Search Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: const TextStyle(color: Colors.white60),
                filled: true,
                fillColor: const Color(0xFF2D2D2D),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.white60),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchResults = [];
                          });
                        },
                        icon: const Icon(Icons.clear, color: Colors.white60),
                      )
                    : null,
              ),
              onSubmitted: _performSearch,
              onChanged: (value) {
                if (value.isEmpty) {
                  setState(() {
                    _searchResults = [];
                  });
                }
              },
            ),
          ),

          // Navigation Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  icon: Icons.school,
                  title: 'Education',
                  onTap: () {
                    Navigator.pop(context);
                    _navigateToEducation();
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.info,
                  title: 'About us',
                  onTap: () {
                    Navigator.pop(context);
                    _navigateToAbout();
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.info,
                  title: 'Dashboard',
                  onTap: () {
                    Navigator.pop(context);
                    _navigateToDashboard();
                    
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.person,
                  title: 'Account',
                  onTap: () {
                    Navigator.pop(context);
                  },
                  isSelected: true,
                ),

                const Divider(color: Colors.white24),
                _buildDrawerItem(
                  icon: Icons.logout,
                  title: 'Log Out',
                  onTap: () {
                    Navigator.pop(context);
                    _navigateToLogout();
                  },
                  isDestructive: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isSelected = false,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive
            ? Colors.red
            : isSelected
            ? Colors.amber
            : Colors.white70,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive
              ? Colors.red
              : isSelected
              ? Colors.amber
              : Colors.white,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          fontFamily: 'Agrandir',
        ),
      ),
      onTap: onTap,
      selectedTileColor: Colors.amber.withValues(alpha: 0.1),
      selected: isSelected,
    );
  }

  Widget _buildSectionTitle(String title, bool isLargeScreen) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.amber,
        fontSize: isLargeScreen ? 24 : 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 1,
        fontFamily: 'Agrandir',
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool isPassword = false,
    TextInputType? keyboardType,
    required bool isLargeScreen,
    bool enabled = true,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword && !_isPasswordVisible,
      keyboardType: keyboardType,
      enabled: enabled,
      style: TextStyle(
        color: Colors.white,
        fontSize: isLargeScreen ? 16 : 14,
        fontFamily: 'Agrandir',
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white60,
          fontSize: isLargeScreen ? 16 : 14,
          fontFamily: 'Agrandir',
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 0, 0, 0).withValues(alpha: 0.8),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.white24, width: 1),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.amber, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: isLargeScreen ? 20 : 16,
          vertical: isLargeScreen ? 20 : 16,
        ),
        suffixIcon: isPassword
            ? IconButton(
                onPressed: enabled
                    ? () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      }
                    : null,
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white60,
                ),
              )
            : null,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
        if (hintText.toLowerCase().contains('email')) {
          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
            return 'Please enter a valid email address';
          }
        }
        if (hintText.toLowerCase().contains('contact')) {
          if (!RegExp(r'^\d{10,}$').hasMatch(value)) {
            return 'Please enter a valid phone number';
          }
        }
        return null;
      },
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String hintText,
    required List<String> items,
    required ValueChanged<String?>? onChanged,
    required bool isLargeScreen,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isLargeScreen ? 20 : 16,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: onChanged != null
            ? const Color.fromARGB(255, 15, 15, 15).withValues(alpha: 0.8)
            : const Color.fromARGB(255, 5, 5, 5).withValues(alpha: 0.5),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(isLargeScreen ? 15 : 12),
          bottomRight: Radius.circular(isLargeScreen ? 15 : 12),
        ),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            hintText,
            style: TextStyle(
              color: Colors.white60,
              fontSize: isLargeScreen ? 16 : 14,
              fontFamily: 'Agrandir',
            ),
          ),
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
          dropdownColor: const Color(0xFF2D2D2D),
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.white60,
            size: isLargeScreen ? 28 : 24,
          ),
          isExpanded: true,
        ),
      ),
    );
  }

  Widget _buildRequirementsChecklist(bool isLargeScreen) {
    return Container(
      padding: EdgeInsets.all(isLargeScreen ? 20 : 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 5, 5, 5).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(isLargeScreen ? 15 : 12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _requirements.keys.map((requirement) {
          bool isHovered = false; // Variable to track hover state

          return MouseRegion(
            onEnter: (_) {
              setState(() {
                isHovered = true; // Set to true on hover
              });
            },
            onExit: (_) {
              setState(() {
                isHovered = false; // Set to false on exit
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                color: _isEditMode && isHovered
                    ? Colors.grey.withValues(alpha: 0.3)
                    : Colors.transparent,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: _isEditMode
                          ? () {
                              setState(() {
                                _requirements[requirement] =
                                    !_requirements[requirement]!;
                              });
                            }
                          : null,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: _requirements[requirement]!
                              ? Colors.amber
                              : Colors.transparent,
                          border: Border.all(
                            color: _requirements[requirement]!
                                ? Colors.amber
                                : Colors.white60,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: _requirements[requirement]!
                            ? const Icon(
                                Icons.check,
                                color: Colors.black,
                                size: 17,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        requirement,
                        style: TextStyle(
                          color: _requirements[requirement]!
                              ? Colors.white
                              : Colors.white30,
                          fontSize: isLargeScreen ? 14 : 12,
                          fontFamily: 'Agrandir',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
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
          top: BorderSide(color: Colors.white.withValues(alpha: 0.1), width: 1),
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
          Divider(color: Colors.white.withValues(alpha: 0.1)),
          const SizedBox(height: 20),
          const Text(
            '© 2025 Alternative Funds. All rights reserved.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.white60),
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
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('$item - Coming soon!')));
              },
              child: Text(
                item,
                style: const TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
