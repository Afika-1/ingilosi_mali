import 'package:flutter/material.dart';
import 'package:alternative_funds/screens/login_business_screen.dart';
import 'package:alternative_funds/screens/register_investor_screen.dart';

// Custom App Header Component (Reused from Landing Page)
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

  void _defaultEducationAction() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Education page - Coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _defaultAboutAction() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('About us page - Coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _defaultRegisterAction() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InvestorRegistrationScreen()),
    );
  }

  void _defaultLoginAction() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BusinessLoginScreen()),
    );
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
        _buildNavItem('Education', widget.onEducationTap ?? _defaultEducationAction),
        const SizedBox(width: 30),
        _buildNavItem('About us', widget.onAboutTap ?? _defaultAboutAction),
        const SizedBox(width: 30),
        _buildNavItem('Register', widget.onRegisterTap ?? _defaultRegisterAction),
        const SizedBox(width: 30),
        _buildNavItem('Log In', widget.onLoginTap ?? _defaultLoginAction),
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

// Custom App Drawer Component (Reused from Landing Page)
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

  void _defaultEducationAction() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Education page - Coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _defaultAboutAction() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('About us page - Coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _defaultRegisterAction() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InvestorRegistrationScreen()),
    );
  }

  void _defaultLoginAction() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BusinessLoginScreen()),
    );
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
                  widget.onEducationTap ?? _defaultEducationAction
                ),
                _buildDrawerItem(
                  'About us', 
                  Icons.info_outline, 
                  widget.onAboutTap ?? _defaultAboutAction
                ),
                _buildDrawerItem(
                  'Register', 
                  Icons.person_add, 
                  widget.onRegisterTap ?? _defaultRegisterAction
                ),
                _buildDrawerItem(
                  'Log In', 
                  Icons.login, 
                  widget.onLoginTap ?? _defaultLoginAction
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

// FAQ Screen
class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  
  final List<Map<String, String>> _faqs = [
    {
      'question': 'What is the funding range?',
      'answer': 'R25,000 - R99,000',
    },
    {
      'question': 'Do I need to have a registered business to apply for funding?',
      'answer': 'Yes, you need to have a registered business to apply for funding through our platform.',
    },
    {
      'question': 'Do you offer Equity, Loan or Grant Funding?',
      'answer': 'We offer only Equity and Loan funding. The terms are agreed directly with the funder/investor.',
    },
    {
      'question': 'Who are the funders?',
      'answer': 'In our funding community, we have Independent funders, Family offices, Corporate Funders and Risk Funders.',
    },
    {
      'question': 'Do they fund start-ups?',
      'answer': 'Yes, this is one of the things that sets us apart from other funders. We actively support start-ups.',
    },
    {
      'question': 'I have a judgement against my name, can I still apply?',
      'answer': 'Yes, another thing that sets us apart from other funders is that we consider applications even with judgements.',
    },
    {
      'question': 'How long does the process take?',
      'answer': 'Depending on the complexity of your business, it could take 5-7 working days.',
    },
  ];

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
    super.dispose();
  }

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
                
                // FAQ Section
                _buildFAQSection(isMobile),
                
                // CTA Section
                _buildCTASection(isMobile),
                
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
      height: isMobile ? 400 : 500,
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
              'Frequently Asked Questions',
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
              'Find answers to the most common questions about our funding platform',
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

  Widget _buildFAQSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile ? 20 : 60,
      ),
      child: Column(
        children: [
          // Section Title
          Text(
            'Common Questions',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.w300,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: isMobile ? 30 : 50),
          
          // FAQ Items
          ...List.generate(_faqs.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _buildFAQItem(
                _faqs[index]['question']!,
                _faqs[index]['answer']!,
                isMobile,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer, bool isMobile) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 30,
            vertical: 10,
          ),
          childrenPadding: EdgeInsets.fromLTRB(
            isMobile ? 20 : 30,
            0,
            isMobile ? 20 : 30,
            20,
          ),
          backgroundColor: Colors.transparent,
          collapsedBackgroundColor: Colors.transparent,
          iconColor: const Color(0xFFD4AF37),
          collapsedIconColor: Colors.white70,
          title: Text(
            question,
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: isMobile ? 14 : 16,
                  color: Colors.white70,
                  height: 1.5,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCTASection(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
        horizontal: isMobile ? 20 : 60,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
      ),
      child: Column(
        children: [
          Text(
            'Still Have Questions?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.w300,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Get in touch with our support team for personalized assistance',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 14 : 18,
              color: Colors.white70,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: isMobile ? 40 : 60),
          
          // CTA Buttons
          isMobile
              ? Column(
                  children: [
                    _buildCTAButton(
                      'CONTACT SUPPORT',
                      Icons.support_agent,
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Support page - Coming soon!'),
                            backgroundColor: Color(0xFFD4AF37),
                          ),
                        );
                      },
                      isMobile: true,
                    ),
                    const SizedBox(height: 20),
                    _buildCTAButton(
                      'START APPLICATION',
                      Icons.rocket_launch,
                      _navigateToRegister,
                      isMobile: true,
                      isSecondary: true,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCTAButton(
                      'CONTACT SUPPORT',
                      Icons.support_agent,
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Support page - Coming soon!'),
                            backgroundColor: Color(0xFFD4AF37),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 30),
                    _buildCTAButton(
                      'START APPLICATION',
                      Icons.rocket_launch,
                      _navigateToRegister,
                      isSecondary: true,
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildCTAButton(
    String text,
    IconData icon,
    VoidCallback onPressed, {
    bool isMobile = false,
    bool isSecondary = false,
  }) {
    return Container(
      width: isMobile ? double.infinity : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isSecondary ? Colors.white60 : const Color(0xFFD4AF37),
          width: 1.5,
        ),
        gradient: isSecondary
            ? null
            : LinearGradient(
                colors: [
                  const Color(0xFFD4AF37),
                  const Color(0xFFD4AF37).withValues(alpha: 0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        boxShadow: !isSecondary ? [
          BoxShadow(
            color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ] : null,
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
                Icon(
                  icon,
                  color: isSecondary ? Colors.white : Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 15),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 12 : 14,
                    fontWeight: FontWeight.w500,
                    color: isSecondary ? Colors.white : Colors.white,
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
        )).toList(),
      ],
    );
  }
}