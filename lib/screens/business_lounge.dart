
// import 'package:corpnet_flut/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:ingilosi_mali/screens/account_screen.dart';
// import 'package:ingilosi_mali/screens/register_investor_screen.dart';
import 'package:ingilosi_mali/screens/welcome_screen.dart';
// import '../screens/register_business_screen.dart';

class BusinessLoungeScreen extends StatefulWidget {
  const BusinessLoungeScreen({super.key});

  @override
  State<BusinessLoungeScreen> createState() => _BusinessLoungeScreenState();
}

class _BusinessLoungeScreenState extends State<BusinessLoungeScreen> {
  final _searchController = TextEditingController();
  bool _isSearchExpanded = false;
  List<String> _searchResults = [];
  final List<String> _searchableContent = [
    'Access to funding',
    'Access to market',
    'Business Coaching',
    'Statistics',
    'Settings',
    'Account',
    'Help',
    'Support'
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

    // Show search results in a snackbar
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

    return Scaffold(
      backgroundColor: Colors.black,
      drawer: isLargeScreen ? null : _buildDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/business_Lounge.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.3),
                Colors.black.withValues(alpha: 0.7),
              ],
            ),
          ),
          child: Column(
            children: [
              // Updated Header with login screen style navbar
              _buildHeader(isLargeScreen),

              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),

                      // Logo and Title
                      _buildLogoSection(),

                      const SizedBox(height: 60),

                      // Welcome Message
                      _buildWelcomeMessage(),

                      const SizedBox(height: 80),

                      // Service Cards
                      _buildServiceCards(context),

                      const SizedBox(height: 60),

                      // Statistics
                      _buildStatistics(),

                      const SizedBox(height: 40),
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
          const Spacer(), // Push navigation to the right
          
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
        _buildNavItem('Services', _navigateToServices),
        const SizedBox(width: 30),
        _buildNavItem('Account', _navigateToAccount),
        const SizedBox(width: 30),
        _buildNavItem('Settings', _navigateToSettings),
        const SizedBox(width: 30),
        _buildNavItem('Logout', _navigateToLogout),
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
          // Drawer header
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
            child: const DrawerHeader(
              margin: EdgeInsets.zero,
              child: Center(
                child: Text(
                  'Business Lounge',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
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
                Navigator.pop(context); // Close drawer after search
              },
            ),
          ),
          
          // Navigation items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem('Services', Icons.business_center, _navigateToServices),
                _buildDrawerItem('Account', Icons.account_circle_outlined, _navigateToAccount),
                _buildDrawerItem('Settings', Icons.settings_outlined, _navigateToSettings),
                _buildDrawerItem('Logout', Icons.logout, _navigateToLogout),
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
      hoverColor: Colors.white.withValues(alpha: 0.1),
    );
  }

  Widget _buildLogoSection() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: const Icon(
            Icons.flight_takeoff_rounded,
            color: Colors.white,
            size: 40,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Ingelosi Imali',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 40),
        Text(
          'Business Lounge',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w200,
            fontSize: 48,
            height: 1.2,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildWelcomeMessage() {
    return Text.rich(
      TextSpan(
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w300,
          height: 1.4,
          letterSpacing: 0.2,
        ),
        children: [
          TextSpan(
            text: 'Welcome ',
            style: TextStyle(color: Colors.white),
          ),
          TextSpan(
            text: 'Lester Philander',
            style: TextStyle(
              color: Colors.amber.shade600,
              fontWeight: FontWeight.w400,
            ),
          ),
          const TextSpan(
            text: ', how can we help you today?',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildServiceCards(BuildContext context) {
    final services = [
      ServiceItem(
        title: 'Access to funding',
        icon: Icons.monetization_on_outlined,
        description: 'Get funding solutions for your business',
      ),
      ServiceItem(
        title: 'Access to market',
        icon: Icons.storefront_outlined,
        description: 'Connect with market opportunities',
      ),
      ServiceItem(
        title: 'Business Coaching\nand Support',
        icon: Icons.business_center_outlined,
        description: 'Expert guidance for business growth',
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWideScreen = constraints.maxWidth > 800;

        if (isWideScreen) {
          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: services
                  .map(
                    (service) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: _buildServiceCard(context, service),
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        } else {
          return Column(
            children: services
                .map(
                  (service) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: _buildServiceCard(context, service),
                  ),
                )
                .toList(),
          );
        }
      },
    );
  }

  Widget _buildServiceCard(BuildContext context, ServiceItem service) {
    return Card(
      elevation: 0,
      color: Colors.white.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.1), width: 1),
      ),
      child: InkWell(
        onTap: () => _handleServiceTap(context, service.title),
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Icon(service.icon, color: Colors.white, size: 40),
              ),
              const SizedBox(height: 24),
              Text(
                service.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                service.description,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 12,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatistics() {
    return Card(
      elevation: 0,
      color: Colors.white.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.1), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.trending_up_rounded,
              color: Colors.amber,
              size: 24,
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text.rich(
                TextSpan(
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    height: 1.4,
                  ),
                  children: [
                    const TextSpan(
                      text: 'We have helped ',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextSpan(
                      text: '10,987 Businesses',
                      style: TextStyle(
                        color: Colors.amber.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const TextSpan(
                      text: ' since June 2025',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Navigation methods
  void _navigateToServices() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Services page - Coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _navigateToAccount() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AccountScreen(),
      ),
    );
  }

  void _navigateToSettings() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomeScreen(),
      ),
    );
  }

  void _navigateToLogout() {
    // Show logout confirmation
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1A1A),
          title: const Text(
            'Logout',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Are you sure you want to logout?',
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
                    builder: (context) => WelcomeScreen(),
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

  void _handleServiceTap(BuildContext context, String service) {
    _showSnackBar(context, '$service selected');
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.amber.shade700,
      ),
    );
  }
}

class ServiceItem {
  final String title;
  final IconData icon;
  final String description;

  const ServiceItem({
    required this.title,
    required this.icon,
    required this.description,
  });
}