import 'package:alternative_funds/screens/faq_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:alternative_funds/screens/login_business_screen.dart';
import 'package:alternative_funds/screens/register_investor_screen.dart';

// Custom App Header Component
class CustomAppHeader extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback? onEducationTap;
  final VoidCallback? onAboutTap;
  final VoidCallback? onRegisterTap;
  final VoidCallback? onLoginTap;
  final bool showDrawer;
  
  const CustomAppHeader({
    super.key,
    this.onEducationTap,
    this.onAboutTap,
    this.onRegisterTap,
    this.onLoginTap,
    this.showDrawer = true,
  });

  @override
  State<CustomAppHeader> createState() => _CustomAppHeaderState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _CustomAppHeaderState extends State<CustomAppHeader> {
  final _searchController = TextEditingController();
  bool _isSearchExpanded = false;
  List<String> _searchResults = [];
  final List<String> _searchableContent = [
    'Education',
    'About us',
    'Register',
    'Log In',
    'Business Registration',
    'Investor Registration',
    'Contact Support',
    'Roadmap',
    'Features',
    'Statistics',
    'FAQ',
    'Frequently Asked Questions'
  ];

  @override
  void dispose() {
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
    final isLargeScreen = screenWidth > 800;

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
          else if (widget.showDrawer)
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
    return Row(
      children: [
        Container(
          width: isLargeScreen ? 120 : 80,
          height: isLargeScreen ? 120 : 80,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image(
              image: AssetImage('lib/assets/images/logo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: isLargeScreen ? 15 : 10),
      ],
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
        _buildNavItem('Education', widget.onEducationTap ?? () {}),
        const SizedBox(width: 30),
        _buildNavItem('About us', widget.onAboutTap ?? () {}),
        const SizedBox(width: 30),
        _buildNavItem('Register', widget.onRegisterTap ?? () {}),
        const SizedBox(width: 30),
        _buildNavItem('Log In', widget.onLoginTap ?? () {}),
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
}

// Custom App Drawer Component
class CustomAppDrawer extends StatefulWidget {
  final VoidCallback? onEducationTap;
  final VoidCallback? onAboutTap;
  final VoidCallback? onRegisterTap;
  final VoidCallback? onLoginTap;

  const CustomAppDrawer({
    super.key,
    this.onEducationTap,
    this.onAboutTap,
    this.onRegisterTap,
    this.onLoginTap,
  });

  @override
  State<CustomAppDrawer> createState() => _CustomAppDrawerState();
}

class _CustomAppDrawerState extends State<CustomAppDrawer> {
  final _searchController = TextEditingController();
  List<String> _searchResults = [];
  final List<String> _searchableContent = [
    'Education',
    'About us',
    'Register',
    'Log In',
    'Business Registration',
    'Investor Registration',
    'Contact Support',
    'FAQ',
    'Frequently Asked Questions'
  ];

  @override
  void dispose() {
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
              child: _buildLogo(),
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
                _buildDrawerItem(
                  'Education', 
                  Icons.school, 
                  widget.onEducationTap ?? () {}
                ),
                _buildDrawerItem(
                  'About us', 
                  Icons.info_outline, 
                  widget.onAboutTap ?? () {}
                ),
                _buildDrawerItem(
                  'Register', 
                  Icons.person_add, 
                  widget.onRegisterTap ?? () {}
                ),
                _buildDrawerItem(
                  'Log In', 
                  Icons.login, 
                  widget.onLoginTap ?? () {}
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'lib/assets/images/logo.png',
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
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
}

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  
  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  
  // Form state
  bool _isSubmitting = false;
  String? _selectedInquiryType;
  
  final List<String> _inquiryTypes = [
    'General Inquiry',
    'Business Funding',
    'Investment Opportunities',
    'Technical Support',
    'Partnership',
    'Media Inquiry',
  ];

  // Company contact details
  final String _companyPhone = '+27 21 123 4567';
  final String _companyEmail = 'info@alternativefunds.co.za';
  final String _companyAddress = 'CPUT Engineering Building\nCape Town, 7535';

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // Navigation methods
  void _navigateToEducation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Education page - Coming soon!'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFFD4AF37),
      ),
    );
  }

  void _navigateToAbout() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('About us page - Coming soon!'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFFD4AF37),
      ),
    );
  }

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const InvestorRegistrationScreen(),
      ),
    );
  }

  void _navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BusinessLoginScreen(),
      ),
    );
  }

  void _navigateToFAQ() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FAQScreen(),
      ),
    );
  }

  // Contact methods
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        // Fallback: Copy to clipboard
        await Clipboard.setData(ClipboardData(text: phoneNumber));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Phone number copied to clipboard: $phoneNumber'),
              backgroundColor: const Color(0xFFD4AF37),
            ),
          );
        }
      }
    } catch (e) {
      // Copy to clipboard as fallback
      await Clipboard.setData(ClipboardData(text: phoneNumber));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Phone number copied to clipboard: $phoneNumber'),
            backgroundColor: const Color(0xFFD4AF37),
          ),
        );
      }
    }
  }

  Future<void> _sendEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Inquiry from Alternative Funds Website',
    );
    
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        // Fallback: Copy to clipboard
        await Clipboard.setData(ClipboardData(text: email));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Email address copied to clipboard: $email'),
              backgroundColor: const Color(0xFFD4AF37),
            ),
          );
        }
      }
    } catch (e) {
      // Copy to clipboard as fallback
      await Clipboard.setData(ClipboardData(text: email));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Email address copied to clipboard: $email'),
            backgroundColor: const Color(0xFFD4AF37),
          ),
        );
      }
    }
  }

  Future<void> _openMaps() async {
    const String address = 'CPUT Engineering Building, Bellville Campus, Cape Town, South Africa';
    final Uri launchUri = Uri(
      scheme: 'https',
      host: 'maps.google.com',
      path: '/search/',
      query: 'api=1&query=${Uri.encodeComponent(address)}',
    );
    
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri, mode: LaunchMode.externalApplication);
      } else {
        // Fallback: Copy address to clipboard
        await Clipboard.setData(const ClipboardData(text: address));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Address copied to clipboard'),
              backgroundColor: Color(0xFFD4AF37),
            ),
          );
        }
      }
    } catch (e) {
      // Copy address to clipboard as fallback
      await Clipboard.setData(const ClipboardData(text: address));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Address copied to clipboard'),
            backgroundColor: Color(0xFFD4AF37),
          ),
        );
      }
    }
  }

  // Form validation
  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    
    // Remove all non-digit characters for validation
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    
    if (digitsOnly.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? _validateSubject(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Subject is required';
    }
    if (value.trim().length < 5) {
      return 'Subject must be at least 5 characters';
    }
    return null;
  }

  String? _validateMessage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Message is required';
    }
    if (value.trim().length < 10) {
      return 'Message must be at least 10 characters';
    }
    return null;
  }

  // Form submission
  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    if (_selectedInquiryType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an inquiry type'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // Simulate form submission
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isSubmitting = false;
      });

      // Clear form
      _formKey.currentState!.reset();
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _subjectController.clear();
      _messageController.clear();
      _selectedInquiryType = null;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Thank you! Your message has been sent successfully.'),
          backgroundColor: Color(0xFFD4AF37),
          duration: Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: CustomAppHeader(
        onEducationTap: _navigateToEducation,
        onAboutTap: _navigateToAbout,
        onRegisterTap: _navigateToRegister,
        onLoginTap: _navigateToLogin,
      ),
      drawer: isMobile ? CustomAppDrawer(
        onEducationTap: _navigateToEducation,
        onAboutTap: _navigateToAbout,
        onRegisterTap: _navigateToRegister,
        onLoginTap: _navigateToLogin,
      ) : null,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/business_lounge.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.7),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Hero Section
                _buildHeroSection(isMobile),
                
                // Contact Info Section
                _buildContactInfoSection(isMobile),
                
                // Contact Form Section
                _buildContactFormSection(isMobile),
                
                // Footer
                _buildFooter(isMobile),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(bool isMobile) {
    return Container(
      height: isMobile ? 350 : 450,
      padding: EdgeInsets.fromLTRB(
        isMobile ? 20 : 60,
        100,
        isMobile ? 20 : 60,
        40,
      ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Contact Us',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 36 : 48,
                fontWeight: FontWeight.w300,
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: isMobile ? 20 : 30),
            Text(
              'Get in touch with our team for personalized support and guidance',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 16 : 20,
                fontWeight: FontWeight.w300,
                color: Colors.white70,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfoSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 60,
        horizontal: isMobile ? 20 : 60,
      ),
      child: Column(
        children: [
          // Text(
          //   'Get In Touch',
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     fontSize: isMobile ? 24 : 32,
          //     fontWeight: FontWeight.w300,
          //     color: Colors.white,
          //     letterSpacing: 1.5,
          //   ),
          // ),
          // SizedBox(height: isMobile ? 30 : 50),
          
          isMobile
              ? Column(
                  children: [
                    _buildContactCard(
                      'Phone',
                      Icons.phone,
                      _companyPhone,
                      'Tap to call',
                      () => _makePhoneCall(_companyPhone),
                      isMobile: true,
                    ),
                    const SizedBox(height: 20),
                    _buildContactCard(
                      'Email',
                      Icons.email,
                      _companyEmail,
                      'Tap to send email',
                      () => _sendEmail(_companyEmail),
                      isMobile: true,
                    ),
                    const SizedBox(height: 20),
                    _buildContactCard(
                      'Address',
                      Icons.location_on,
                      _companyAddress,
                      'Tap to open in maps',
                      _openMaps,
                      isMobile: true,
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: _buildContactCard(
                        'Phone',
                        Icons.phone,
                        _companyPhone,
                        'Click to call',
                        () => _makePhoneCall(_companyPhone),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildContactCard(
                        'Email',
                        Icons.email,
                        _companyEmail,
                        'Click to send email',
                        () => _sendEmail(_companyEmail),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildContactCard(
                        'Address',
                        Icons.location_on,
                        _companyAddress,
                        'Click to open in maps',
                        _openMaps,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildContactCard(
    String title,
    IconData icon,
    String content,
    String subtitle,
    VoidCallback onTap, {
    bool isMobile = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(isMobile ? 20 : 30),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4AF37).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFFD4AF37),
                    size: 30,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isMobile ? 18 : 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 16,
                    color: Colors.white70,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: isMobile ? 12 : 14,
                    color: const Color(0xFFD4AF37),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactFormSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile ? 20 : 60,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
      ),
      child: Column(
        children: [
          Text(
            'Send us a Message',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.w300,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: isMobile ? 30 : 50),
          
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
            padding: EdgeInsets.all(isMobile ? 20 : 40),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Name and Email Row
                  isMobile
                      ? Column(
                          children: [
                            _buildTextFormField(
                              controller: _nameController,
                              label: 'Full Name',
                              icon: Icons.person,
                              validator: _validateName,
                            ),
                            const SizedBox(height: 20),
                            _buildTextFormField(
                              controller: _emailController,
                              label: 'Email Address',
                              icon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                              validator: _validateEmail,
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: _buildTextFormField(
                                controller: _nameController,
                                label: 'Full Name',
                                icon: Icons.person,
                                validator: _validateName,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: _buildTextFormField(
                                controller: _emailController,
                                label: 'Email Address',
                                icon: Icons.email,
                                keyboardType: TextInputType.emailAddress,
                                validator: _validateEmail,
                              ),
                            ),
                          ],
                        ),
                  
                  const SizedBox(height: 20),
                  
                  // Phone and Inquiry Type Row
                  isMobile
                      ? Column(
                          children: [
                            _buildTextFormField(
                              controller: _phoneController,
                              label: 'Phone Number',
                              icon: Icons.phone,
                              keyboardType: TextInputType.phone,
                              validator: _validatePhone,
                            ),
                            const SizedBox(height: 20),
                            _buildDropdownField(),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: _buildTextFormField(
                                controller: _phoneController,
                                label: 'Phone Number',
                                icon: Icons.phone,
                                keyboardType: TextInputType.phone,
                                validator: _validatePhone,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(child: _buildDropdownField()),
                          ],
                        ),
                  
                  const SizedBox(height: 20),
                  
                  // Subject
                  _buildTextFormField(
                    controller: _subjectController,
                    label: 'Subject',
                    icon: Icons.subject,
                    validator: _validateSubject,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Message
                  _buildTextFormField(
                    controller: _messageController,
                    label: 'Message',
                    icon: Icons.message,
                    maxLines: 5,
                    validator: _validateMessage,
                  ),
                  
                  SizedBox(height: isMobile ? 30 : 40),
                  
                  // Submit Button
                  _buildSubmitButton(isMobile),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: const Color(0xFFD4AF37)),
        filled: true,
        fillColor: Colors.black.withValues(alpha: 0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFFD4AF37), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        errorStyle: const TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _buildDropdownField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: DropdownButtonFormField<String>(
        value: _selectedInquiryType,
        decoration: InputDecoration(
          labelText: 'Inquiry Type',
          labelStyle: const TextStyle(color: Colors.white70),
          prefixIcon: const Icon(Icons.category, color: Color(0xFFD4AF37)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        dropdownColor: const Color(0xFF2D2D2D),
        style: const TextStyle(color: Colors.white),
        items: _inquiryTypes.map((String type) {
          return DropdownMenuItem<String>(
            value: type,
            child: Text(type),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedInquiryType = newValue;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select an inquiry type';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildSubmitButton(bool isMobile) {
    return Container(
      width: isMobile ? double.infinity : 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFD4AF37),
            Color(0xFFB8941F),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: _isSubmitting ? null : _submitForm,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: _isSubmitting
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                      SizedBox(width: 15),
                      Text(
                        'SENDING...',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  )
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 15),
                      Text(
                        'SEND MESSAGE',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(bool isMobile) {
    return Container(
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
                      'FAQ',
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
                      'FAQ',
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
          
          const SizedBox(height: 40),
          
          // Copyright
          Container(
            padding: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
            ),
            child: Text(
              '© ${DateTime.now().year} Alternative Funds. All rights reserved.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 12 : 14,
                color: Colors.white60,
                letterSpacing: 0.5,
              ),
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
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 15),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$item - Coming soon!'),
                  backgroundColor: const Color(0xFFD4AF37),
                ),
              );
              _navigateToFAQ();

            },
            child: Text(
              item,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
                letterSpacing: 0.5,
              ),
            ),
          ),
        )),
      ],
    );
  }
}