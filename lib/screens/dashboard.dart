import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ingilosi_mali/screens/login_business_screen.dart';
import 'dart:math' as math;
import '../screens/account_screen.dart';

class InvestorDashboard extends StatefulWidget {
  const InvestorDashboard({super.key});

  @override
  State<InvestorDashboard> createState() => _InvestorDashboardState();
}

class _InvestorDashboardState extends State<InvestorDashboard>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController(
    text: 'John Investor',
  );

  bool _isSearchExpanded = false;
  List<String> _searchResults = [];
  String _selectedDashboard = 'Saved businesses of interest';

  // Animation controllers
  late AnimationController _floatingParticlesController;
  late AnimationController _gradientController;
  late AnimationController _pulseController;
  late AnimationController _rotationController;

  final List<String> _searchableContent = [
    'Account',
    'Dashboard',
    'Saved businesses',
    'Investments',
    'Marketing trends',
    'Analytics',
    'Progress',
    'Portfolio',
    'Returns',
    'Performance',
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    // Floating particles animation
    _floatingParticlesController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    // Gradient animation
    _gradientController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat(reverse: true);

    // Pulse animation
    _pulseController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    // Rotation animation
    _rotationController = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _fullNameController.dispose();
    _floatingParticlesController.dispose();
    _gradientController.dispose();
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: _buildHeader(MediaQuery.of(context).size.width > 800),
      ),
      drawer: MediaQuery.of(context).size.width <= 800 ? _buildDrawer() : null,
      body: Stack(
        children: [
          // Animated Background
          _buildAnimatedBackground(),

          // Main Content
          Row(
            children: [
              // Left Navigation Menu (Desktop)
              if (MediaQuery.of(context).size.width > 800) _buildLeftMenu(),

              // Main Content Area
              Expanded(child: _buildMainContent()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return Stack(
      children: [
        // Gradient Background Animation
        AnimatedBuilder(
          animation: _gradientController,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF0A0A0A),
                    Color.lerp(
                      const Color(0xFF1A1A1A),
                      const Color.fromARGB(
                        255,
                        16,
                        88,
                        44,
                      ).withValues(alpha: 0.05),
                      _gradientController.value,
                    )!,
                    const Color(0xFF0A0A0A),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            );
          },
        ),

        // Floating Geometric Shapes
        AnimatedBuilder(
          animation: _floatingParticlesController,
          builder: (context, child) {
            return CustomPaint(
              painter: FloatingShapesPainter(
                _floatingParticlesController.value,
              ),
              size: Size.infinite,
            );
          },
        ),

        // Rotating Circles
        AnimatedBuilder(
          animation: _rotationController,
          builder: (context, child) {
            return CustomPaint(
              painter: RotatingCirclesPainter(_rotationController.value),
              size: Size.infinite,
            );
          },
        ),

        // Pulsing Dots
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return CustomPaint(
              painter: PulsingDotsPainter(_pulseController.value),
              size: Size.infinite,
            );
          },
        ),
      ],
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
        // Add subtle backdrop blur effect
        backgroundBlendMode: BlendMode.overlay,
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
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Row(
          children: [
            Container(
              width: isLargeScreen ? 50 : 40,
              height: isLargeScreen ? 50 : 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.amber, Colors.amber.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withValues(
                      alpha: 0.3 * _pulseController.value,
                    ),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.business_center,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Ingilosi Mali',
              style: TextStyle(
                color: Colors.white,
                fontSize: isLargeScreen ? 20 : 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Agrandir',
              ),
            ),
          ],
        );
      },
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
              curve: Curves.easeInOut,
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
            AnimatedRotation(
              turns: _isSearchExpanded ? 0.25 : 0,
              duration: const Duration(milliseconds: 300),
              child: IconButton(
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
            ),
          ],
        ),

        const SizedBox(width: 20),

        // Navigation items
        _buildNavItem('Education', _navigateToEducation),
        const SizedBox(width: 30),
        _buildNavItem('About us', _navigateToAbout),
        const SizedBox(width: 30),
        _buildNavItem('Dashboard', () {}),
        const SizedBox(width: 30),
        _buildNavItem('Account', AccountScreen.new), // Current page
        const SizedBox(width: 30),
        _buildNavItem('Log Out', _navigateToLogout),
      ],
    );
  }

  Widget _buildNavItem(String title, VoidCallback onTap) {
    bool isCurrentPage = title == 'Dashboard';
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            // color: isCurrentPage ? Colors.amber.withValues(alpha: 0.1) : null,
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isCurrentPage ? Colors.amber : Colors.white,
              fontSize: 16,
              fontWeight: isCurrentPage ? FontWeight.w600 : FontWeight.w400,
            ),
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
                  icon: Icons.person,
                  title: 'Account',
                  onTap: () {
                    Navigator.pop(context);
                  },
                  isSelected: true,
                ),
                const Divider(color: Colors.white24),
                _buildDrawerItem(
                  icon: Icons.bookmark,
                  title: 'Saved Businesses',
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _selectedDashboard = 'Saved businesses of interest';
                    });
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.trending_up,
                  title: 'Investments',
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _selectedDashboard = 'Businesses invested in';
                    });
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.analytics,
                  title: 'Marketing Trends',
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _selectedDashboard = 'Marketing trends';
                    });
                  },
                ),
                const Divider(color: Colors.white24),
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
                    () {};
                  },
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

  Widget _buildLeftMenu() {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 15, 15, 15).withValues(alpha: 0.9),
        border: Border(
          right: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Profile Section
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color.fromARGB(255, 7, 255, 40).withValues(alpha: 0.3),
                  const Color.fromARGB(255, 7, 123, 255).withValues(alpha: 0.1),
                ],
              ),
            ),
            child: Column(
              children: [
                _buildProfileAvatar(true),
                const SizedBox(height: 12),
                Text(
                  _fullNameController.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Agrandir',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Investor',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 14,
                    fontFamily: 'Agrandir',
                  ),
                ),
              ],
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                _buildMenuSection('ACCOUNT', [
                  _buildMenuItem(
                    icon: Icons.person,
                    title: 'Account',
                    isSelected: true,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AccountScreen(),
                        ),
                      );
                    },
                  ),
                ]),

                _buildMenuSection('DASHBOARDS', [
                  _buildMenuItem(
                    icon: Icons.bookmark,
                    title: 'Saved businesses of interest',
                    isSelected:
                        _selectedDashboard == 'Saved businesses of interest',
                    onTap: () {
                      setState(() {
                        _selectedDashboard = 'Saved businesses of interest';
                      });
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.trending_up,
                    title: 'Businesses invested in',
                    isSelected: _selectedDashboard == 'Businesses invested in',
                    onTap: () {
                      setState(() {
                        _selectedDashboard = 'Businesses invested in';
                      });
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.analytics,
                    title: 'Marketing trends',
                    isSelected: _selectedDashboard == 'Marketing trends',
                    onTap: () {
                      setState(() {
                        _selectedDashboard = 'Marketing trends';
                      });
                    },
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              fontFamily: 'Agrandir',
            ),
          ),
        ),
        ...items,
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.transparent : null,
            border: Border(
              right: BorderSide(
                color: isSelected ? Colors.amber : Colors.transparent,
                width: 0.1,
              ),
              top: BorderSide(
                color: isSelected ? Colors.amber : Colors.transparent,
                width: 0.1,
              ),
              bottom: BorderSide(
                color: isSelected ? Colors.amber : Colors.transparent,
                width: 0.1,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected
                    ? const Color.fromARGB(255, 5, 197, 197)
                    : Colors.white70,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? Colors.amber : Colors.white,
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    fontFamily: 'Agrandir',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileAvatar(bool isLarge) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Container(
          width: isLarge ? 80 : 60,
          height: isLarge ? 80 : 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 0, 0, 0),
                Colors.amber.shade700,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.amber.withValues(
                  alpha: 0.3 * _pulseController.value,
                ),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: isLarge ? 40 : 30,
          ),
        );
      },
    );
  }

  Widget _buildMainContent() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dashboard Title
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Row(
              key: ValueKey(_selectedDashboard),
              children: [
                Icon(_getDashboardIcon(), color: Colors.amber, size: 32),
                const SizedBox(width: 16),
                Text(
                  _selectedDashboard,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Agrandir',
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Dashboard Content
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: _buildDashboardContent(),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getDashboardIcon() {
    switch (_selectedDashboard) {
      case 'Saved businesses of interest':
        return Icons.bookmark;
      case 'Businesses invested in':
        return Icons.trending_up;
      case 'Marketing trends':
        return Icons.analytics;
      default:
        return Icons.dashboard;
    }
  }

  Widget _buildDashboardContent() {
    switch (_selectedDashboard) {
      case 'Saved businesses of interest':
        return _buildSavedBusinesses();
      case 'Businesses invested in':
        return _buildInvestments();
      case 'Marketing trends':
        return _buildMarketingTrends();
      default:
        return _buildSavedBusinesses();
    }
  }

  Widget _buildSavedBusinesses() {
    return GridView.builder(
      key: const ValueKey('saved_businesses'),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.5,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return TweenAnimationBuilder(
          duration: Duration(milliseconds: 300 + (index * 100)),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, double value, child) {
            return Transform.scale(
              scale: value,
              child: Opacity(
                opacity: value,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                      255,
                      0,
                      0,
                      0,
                    ).withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amber.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.amber, Colors.amber.shade700],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.business,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const Spacer(),
                            Icon(Icons.bookmark, color: Colors.amber, size: 20),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Business ${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Agrandir',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Technology • Growth Stage',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 14,
                            fontFamily: 'Agrandir',
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              'R${(index + 1) * 500}K',
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Agrandir',
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'Saved ${index + 1}d ago',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.5),
                                fontSize: 12,
                                fontFamily: 'Agrandir',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInvestments() {
    return Column(
      key: const ValueKey('investments'),
      children: [
        // Summary Cards
        Row(
          children: [
            Expanded(
              child: _buildSummaryCard(
                'Total Invested',
                'R2.4M',
                Icons.account_balance_wallet,
                Colors.blue,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildSummaryCard(
                'Current Value',
                'R3.1M',
                Icons.trending_up,
                Colors.green,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildSummaryCard(
                'Total Return',
                '+29.2%',
                Icons.show_chart,
                Colors.amber,
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Investment Performance Chart
        Expanded(
          child: TweenAnimationBuilder(
            duration: const Duration(milliseconds: 800),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: Opacity(
                  opacity: value,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                        255,
                        0,
                        0,
                        0,
                      ).withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Investment Performance',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Agrandir',
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(child: _buildPerformanceChart()),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Widget _buildMarketingT

  Widget _buildMarketingTrends() {
    return Column(
      key: const ValueKey('marketing_trends'),
      children: [
        // Trend Categories
        Row(
          children: [
            Expanded(
              child: _buildTrendCard(
                'Digital Marketing',
                '+15.3%',
                Icons.computer,
                Colors.blue,
                'Growing trend in digital advertising',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTrendCard(
                'Social Commerce',
                '+24.7%',
                Icons.shopping_cart,
                Colors.purple,
                'E-commerce via social platforms',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTrendCard(
                'AI Marketing',
                '+31.2%',
                Icons.smart_toy,
                Colors.orange,
                'AI-powered marketing solutions',
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Trends Chart
        Expanded(
          child: TweenAnimationBuilder(
            duration: const Duration(milliseconds: 1000),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: Opacity(
                  opacity: value,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                        255,
                        0,
                        0,
                        0,
                      ).withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Marketing Trends Analysis',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Agrandir',
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(child: _buildTrendsChart()),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 600),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double animValue, child) {
        return Transform.scale(
          scale: animValue,
          child: Opacity(
            opacity: animValue,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                  255,
                  15,
                  15,
                  15,
                ).withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, color: color, size: 24),
                      const Spacer(),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 14,
                      fontFamily: 'Agrandir',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Agrandir',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTrendCard(
    String title,
    String growth,
    IconData icon,
    Color color,
    String description,
  ) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 700),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double animValue, child) {
        return Transform.scale(
          scale: animValue,
          child: Opacity(
            opacity: animValue,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                  255,
                  15,
                  15,
                  15,
                ).withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, color: color, size: 24),
                      const Spacer(),
                      Text(
                        growth,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Agrandir',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Agrandir',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 12,
                      fontFamily: 'Agrandir',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPerformanceChart() {
    return LineChart(
      LineChartData(
        backgroundColor: Colors.transparent,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.white.withValues(alpha: 0.1),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (double value, TitleMeta meta) {
                const style = TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                );
                Widget text;
                switch (value.toInt()) {
                  case 0:
                    text = const Text('Jan', style: style);
                    break;
                  case 1:
                    text = const Text('Feb', style: style);
                    break;
                  case 2:
                    text = const Text('Mar', style: style);
                    break;
                  case 3:
                    text = const Text('Apr', style: style);
                    break;
                  case 4:
                    text = const Text('May', style: style);
                    break;
                  case 5:
                    text = const Text('Jun', style: style);
                    break;
                  default:
                    text = const Text('', style: style);
                    break;
                }
                return SideTitleWidget(axisSide: meta.axisSide, child: text);
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (double value, TitleMeta meta) {
                const style = TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                );
                return Text('${value.toInt()}M', style: style);
              },
              reservedSize: 42,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: 5,
        minY: 0,
        maxY: 4,
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 2),
              FlSpot(1, 2.2),
              FlSpot(2, 2.5),
              FlSpot(3, 2.8),
              FlSpot(4, 3.1),
              FlSpot(5, 3.1),
            ],
            isCurved: true,
            gradient: LinearGradient(
              colors: [Colors.amber.withValues(alpha: 0.8), Colors.amber],
            ),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: Colors.amber,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  Colors.amber.withValues(alpha: 0.3),
                  Colors.amber.withValues(alpha: 0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendsChart() {
    return LineChart(
      LineChartData(
        backgroundColor: Colors.transparent,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 10,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.white.withValues(alpha: 0.1),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (double value, TitleMeta meta) {
                const style = TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                );
                Widget text;
                switch (value.toInt()) {
                  case 0:
                    text = const Text('Q1', style: style);
                    break;
                  case 1:
                    text = const Text('Q2', style: style);
                    break;
                  case 2:
                    text = const Text('Q3', style: style);
                    break;
                  case 3:
                    text = const Text('Q4', style: style);
                    break;
                  default:
                    text = const Text('', style: style);
                    break;
                }
                return SideTitleWidget(axisSide: meta.axisSide, child: text);
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 10,
              getTitlesWidget: (double value, TitleMeta meta) {
                const style = TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                );
                return Text('${value.toInt()}%', style: style);
              },
              reservedSize: 42,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: 3,
        minY: 0,
        maxY: 40,
        lineBarsData: [
          // Digital Marketing
          LineChartBarData(
            spots: const [
              FlSpot(0, 10),
              FlSpot(1, 12),
              FlSpot(2, 14),
              FlSpot(3, 15),
            ],
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 3,
                  color: Colors.blue,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
          ),
          // Social Commerce
          LineChartBarData(
            spots: const [
              FlSpot(0, 15),
              FlSpot(1, 18),
              FlSpot(2, 22),
              FlSpot(3, 25),
            ],
            isCurved: true,
            color: Colors.purple,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 3,
                  color: Colors.purple,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
          ),
          // AI Marketing
          LineChartBarData(
            spots: const [
              FlSpot(0, 20),
              FlSpot(1, 25),
              FlSpot(2, 28),
              FlSpot(3, 31),
            ],
            isCurved: true,
            color: Colors.orange,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 3,
                  color: Colors.orange,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.amber.withValues(alpha: 0.1) : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isDestructive
                    ? Colors.red
                    : (isSelected ? Colors.amber : Colors.white70),
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isDestructive
                        ? Colors.red
                        : (isSelected ? Colors.amber : Colors.white),
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    fontFamily: 'Agrandir',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _performSearch(String query) {
    if (query.isEmpty) return;

    final results = _searchableContent
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      _searchResults = results;
    });
  }

  void _navigateToEducation() {
    // Navigate to education page
    print('Navigate to Education');
  }

  void _navigateToAbout() {
    // Navigate to about page
    print('Navigate to About');
  }

  void _navigateToDashboard() {
    // Navigate to about page
    print('Navigate to About');
  }

  void _navigateToAccount() {
    // Navigate to about page

    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AccountScreen(),
                        ),
                      );
                    
  };}

  void _navigateToLogout() {
    // Handle logout
    print('Logout');
    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BusinessLoginScreen(),
                        ),
                      );
                    };
  }
}

// Custom Painters for Background Animation
class FloatingShapesPainter extends CustomPainter {
  final double animationValue;

  FloatingShapesPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.amber.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;

    // Draw floating rectangles
    for (int i = 0; i < 5; i++) {
      final x =
          (size.width * 0.1 + i * size.width * 0.2) +
          math.sin(animationValue * 2 * math.pi + i) * 20;
      final y =
          (size.height * 0.2 + i * size.height * 0.15) +
          math.cos(animationValue * 2 * math.pi + i) * 15;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(animationValue * 2 * math.pi + i);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset.zero, width: 30, height: 30),
          const Radius.circular(5),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class RotatingCirclesPainter extends CustomPainter {
  final double animationValue;

  RotatingCirclesPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 10, 88, 94).withValues(alpha: 0.03)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final center = Offset(size.width / 2, size.height / 2);

    // Draw rotating circles
    for (int i = 0; i < 3; i++) {
      final radius = 50.0 + i * 100;
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(animationValue * 2 * math.pi * (i % 2 == 0 ? 1 : -1));
      canvas.drawCircle(Offset.zero, radius, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class PulsingDotsPainter extends CustomPainter {
  final double animationValue;

  PulsingDotsPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(
        255,
        27,
        116,
        42,
      ).withValues(alpha: 0.1 * animationValue)
      ..style = PaintingStyle.fill;

    // Draw pulsing dots
    for (int i = 0; i < 8; i++) {
      final angle = i * 2 * math.pi / 8;
      final x = size.width * 0.8 + math.cos(angle) * 100;
      final y = size.height * 0.3 + math.sin(angle) * 100;

      canvas.drawCircle(Offset(x, y), 5 + animationValue * 3, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
