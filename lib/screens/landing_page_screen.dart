// import 'package:flutter/material.dart';
// import 'package:ingilosi_mali/screens/business_lounge.dart';
// import 'package:ingilosi_mali/screens/login_business_screen.dart';
// import 'package:ingilosi_mali/screens/register_business_screen.dart';

// // Custom App Header Component
// class CustomAppHeader extends StatefulWidget implements PreferredSizeWidget {
//   final VoidCallback? onEducationTap;
//   final VoidCallback? onAboutTap;
//   final VoidCallback? onRegisterTap;
//   final VoidCallback? onLoginTap;
//   final bool showDrawer;
  
//   const CustomAppHeader({
//     super.key,
//     this.onEducationTap,
//     this.onAboutTap,
//     this.onRegisterTap,
//     this.onLoginTap,
//     this.showDrawer = true,
//   });

//   @override
//   State<CustomAppHeader> createState() => _CustomAppHeaderState();

//   @override
//   Size get preferredSize => const Size.fromHeight(80);
// }

// class _CustomAppHeaderState extends State<CustomAppHeader> {
//   final _searchController = TextEditingController();
//   bool _isSearchExpanded = false;
//   List<String> _searchResults = [];
//   final List<String> _searchableContent = [
//     'Education',
//     'About us',
//     'Register',
//     'Log In',
//     'Business Registration',
//     'Investor Registration',
//     'Contact Support'
//   ];

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _performSearch(String query) {
//     if (query.isEmpty) {
//       setState(() {
//         _searchResults = [];
//       });
//       return;
//     }

//     setState(() {
//       _searchResults = _searchableContent
//           .where((item) => item.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });

//     if (_searchResults.isNotEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Found: ${_searchResults.join(', ')}'),
//           duration: const Duration(seconds: 3),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('No results found'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//   }

//   void _defaultEducationAction() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Education page - Coming soon!'),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }

//   void _defaultAboutAction() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('About us page - Coming soon!'),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }

//   void _defaultRegisterAction() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => BusinessRegistrationScreen()),
//     );
//   }

//   void _defaultLoginAction() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => BusinessLoginScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isLargeScreen = screenWidth > 800;

//     return Container(
//       height: 80,
//       padding: const EdgeInsets.symmetric(horizontal: 24.0),
//       decoration: BoxDecoration(
//         color: Colors.black.withValues(alpha: 0.3),
//         border: Border(
//           bottom: BorderSide(
//             color: Colors.white.withValues(alpha: 0.1),
//             width: 1,
//           ),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // Logo
//           _buildLogo(isLargeScreen),
          
//           // Navigation
//           if (isLargeScreen)
//             _buildDesktopNavigation()
//           else if (widget.showDrawer)
//             Builder(
//               builder: (context) => IconButton(
//                 onPressed: () {
//                   Scaffold.of(context).openDrawer();
//                 },
//                 icon: const Icon(Icons.menu, color: Colors.white, size: 28),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLogo(bool isLargeScreen) {
//     return Row(
//       children: [
//         Container(
//           width: isLargeScreen ? 60 : 45,
//           height: isLargeScreen ? 60 : 45,
//           decoration: BoxDecoration(
//             color: Colors.transparent,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               Icon(
//                 Icons.featured_play_list_outlined,
//                 size: isLargeScreen ? 50 : 35,
//                 color: Colors.white.withValues(alpha: 0.8),
//               ),
//               Text(
//                 '\$',
//                 style: TextStyle(
//                   fontSize: isLargeScreen ? 28 : 20,
//                   fontWeight: FontWeight.bold,
//                   color: const Color(0xFFD4AF37),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(width: isLargeScreen ? 15 : 10),
//         Text(
//           'Ingilosi Mali',
//           style: TextStyle(
//             fontSize: isLargeScreen ? 24 : 18,
//             fontWeight: FontWeight.w300,
//             color: Colors.white,
//             letterSpacing: 1.2,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDesktopNavigation() {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         // Search functionality
//         Row(
//           children: [
//             AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               width: _isSearchExpanded ? 200 : 0,
//               height: 40,
//               child: _isSearchExpanded
//                   ? TextField(
//                       controller: _searchController,
//                       style: const TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         hintText: 'Search...',
//                         hintStyle: const TextStyle(color: Colors.white60),
//                         filled: true,
//                         fillColor: const Color(0xFF2D2D2D).withValues(alpha: 0.8),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                           borderSide: BorderSide.none,
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 8,
//                         ),
//                       ),
//                       onSubmitted: _performSearch,
//                       onChanged: (value) {
//                         if (value.isEmpty) {
//                           setState(() {
//                             _searchResults = [];
//                           });
//                         }
//                       },
//                     )
//                   : const SizedBox.shrink(),
//             ),
//             IconButton(
//               onPressed: () {
//                 setState(() {
//                   _isSearchExpanded = !_isSearchExpanded;
//                   if (!_isSearchExpanded) {
//                     _searchController.clear();
//                     _searchResults = [];
//                   }
//                 });
//               },
//               icon: Icon(
//                 _isSearchExpanded ? Icons.close : Icons.search,
//                 color: Colors.white,
//                 size: 24,
//               ),
//             ),
//           ],
//         ),
        
//         const SizedBox(width: 20),
        
//         // Navigation items
//         _buildNavItem('Education', widget.onEducationTap ?? _defaultEducationAction),
//         const SizedBox(width: 30),
//         _buildNavItem('About us', widget.onAboutTap ?? _defaultAboutAction),
//         const SizedBox(width: 30),
//         _buildNavItem('Register', widget.onRegisterTap ?? _defaultRegisterAction),
//         const SizedBox(width: 30),
//         _buildNavItem('Log In', widget.onLoginTap ?? _defaultLoginAction),
//       ],
//     );
//   }

//   Widget _buildNavItem(String title, VoidCallback onTap) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(4),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//         child: Text(
//           title,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Custom App Drawer Component
// class CustomAppDrawer extends StatefulWidget {
//   final VoidCallback? onEducationTap;
//   final VoidCallback? onAboutTap;
//   final VoidCallback? onRegisterTap;
//   final VoidCallback? onLoginTap;

//   const CustomAppDrawer({
//     super.key,
//     this.onEducationTap,
//     this.onAboutTap,
//     this.onRegisterTap,
//     this.onLoginTap,
//   });

//   @override
//   State<CustomAppDrawer> createState() => _CustomAppDrawerState();
// }

// class _CustomAppDrawerState extends State<CustomAppDrawer> {
//   final _searchController = TextEditingController();
//   List<String> _searchResults = [];
//   final List<String> _searchableContent = [
//     'Education',
//     'About us',
//     'Register',
//     'Log In',
//     'Business Registration',
//     'Investor Registration',
//     'Contact Support'
//   ];

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _performSearch(String query) {
//     if (query.isEmpty) {
//       setState(() {
//         _searchResults = [];
//       });
//       return;
//     }

//     setState(() {
//       _searchResults = _searchableContent
//           .where((item) => item.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });

//     if (_searchResults.isNotEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Found: ${_searchResults.join(', ')}'),
//           duration: const Duration(seconds: 3),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('No results found'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//   }

//   void _defaultEducationAction() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Education page - Coming soon!'),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }

//   void _defaultAboutAction() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('About us page - Coming soon!'),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }

//   void _defaultRegisterAction() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => BusinessRegistrationScreen()),
//     );
//   }

//   void _defaultLoginAction() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => BusinessLoginScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: const Color(0xFF1A1A1A),
//       child: Column(
//         children: [
//           // Drawer header with logo
//           Container(
//             height: 120,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.black.withValues(alpha: 0.3),
//               border: Border(
//                 bottom: BorderSide(
//                   color: Colors.white.withValues(alpha: 0.1),
//                   width: 1,
//                 ),
//               ),
//             ),
//             child: DrawerHeader(
//               margin: EdgeInsets.zero,
//               child: _buildLogo(),
//             ),
//           ),
          
//           // Search in drawer
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: _searchController,
//               style: const TextStyle(color: Colors.white),
//               decoration: InputDecoration(
//                 hintText: 'Search...',
//                 hintStyle: const TextStyle(color: Colors.white60),
//                 prefixIcon: const Icon(Icons.search, color: Colors.white60),
//                 filled: true,
//                 fillColor: const Color(0xFF2D2D2D).withValues(alpha: 0.8),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//               onSubmitted: (value) {
//                 _performSearch(value);
//                 Navigator.pop(context);
//               },
//             ),
//           ),
          
//           // Navigation items
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children: [
//                 _buildDrawerItem(
//                   'Education', 
//                   Icons.school, 
//                   widget.onEducationTap ?? _defaultEducationAction
//                 ),
//                 _buildDrawerItem(
//                   'About us', 
//                   Icons.info_outline, 
//                   widget.onAboutTap ?? _defaultAboutAction
//                 ),
//                 _buildDrawerItem(
//                   'Register', 
//                   Icons.person_add, 
//                   widget.onRegisterTap ?? _defaultRegisterAction
//                 ),
//                 _buildDrawerItem(
//                   'Log In', 
//                   Icons.login, 
//                   widget.onLoginTap ?? _defaultLoginAction
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLogo() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           width: 40,
//           height: 40,
//           decoration: BoxDecoration(
//             color: Colors.transparent,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               Icon(
//                 Icons.featured_play_list_outlined,
//                 size: 30,
//                 color: Colors.white.withValues(alpha: 0.8),
//               ),
//               Text(
//                 '\$',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: const Color(0xFFD4AF37),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(width: 10),
//         const Text(
//           'Ingilosi Mali',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w300,
//             color: Colors.white,
//             letterSpacing: 1.2,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDrawerItem(String title, IconData icon, VoidCallback onTap) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.white70),
//       title: Text(
//         title,
//         style: const TextStyle(
//           color: Colors.white,
//           fontSize: 16,
//           fontWeight: FontWeight.w400,
//         ),
//       ),
//       onTap: () {
//         Navigator.pop(context);
//         onTap();
//       },
//       hoverColor: Colors.white.withValues(alpha: 0.1),
//     );
//   }
// }

// // Main Landing Page
// class LandingPage extends StatefulWidget {
//   const LandingPage({super.key});

//   @override
//   State<LandingPage> createState() => _LandingPageState();
// }

// class _LandingPageState extends State<LandingPage> {
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final isTablet = screenWidth >= 768 && screenWidth < 1024;
//     final isMobile = screenWidth < 768;
//     final isDesktop = screenWidth >= 1024;

//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       backgroundColor: Colors.transparent,
//       appBar: CustomAppHeader(
//         onEducationTap: _navigateToEducation,
//         onAboutTap: _navigateToAbout,
//         onRegisterTap: _navigateToRegister,
//         onLoginTap: _navigateToLogin,
//       ),
//       drawer: isMobile ? CustomAppDrawer(
//         onEducationTap: _navigateToEducation,
//         onAboutTap: _navigateToAbout,
//         onRegisterTap: _navigateToRegister,
//         onLoginTap: _navigateToLogin,
//       ) : null,
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('lib/assets/images/business_lounge.jpg'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Stack(
//           children: [
//             // Main Content
//             Center(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: isMobile ? 20 : (isTablet ? 40 : 60),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Main Title
//                     Text(
//                       'Ingilosi Mali',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: isMobile ? 48 : (isTablet ? 64 : 80),
//                         fontWeight: FontWeight.w300,
//                         color: Colors.white,
//                         letterSpacing: 2.0,
//                         height: 1.0,
//                       ),
//                     ),
//                     SizedBox(height: isMobile ? 20 : 30),
//                     // Subtitle
//                     Text(
//                       'Unlocking Capital. Empowering Small Businesses.',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: isMobile ? 16 : (isTablet ? 20 : 24),
//                         fontWeight: FontWeight.w300,
//                         color: Colors.white,
//                         letterSpacing: 1.5,
//                       ),
//                     ),
//                     SizedBox(height: isMobile ? 40 : 60),
//                     // Action Buttons
//                     _buildActionButtons(isMobile, isTablet),
//                   ],
//                 ),
//               ),
//             ),

//             // Decorative Elements
//             if (!isMobile) ..._buildDecorativeElements(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildActionButtons(bool isMobile, bool isTablet) {
//     if (isMobile) {
//       return Column(
//         children: [
//           _buildActionButton('INVESTORS\nLOUNGE', () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const BusinessLoungeScreen(),
//               ),
//             );
//           }, isMobile: true),
//         ],
//       );
//     } else {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           _buildActionButton('INVESTORS\nLOUNGE', () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const BusinessLoungeScreen(),
//               ),
//             );
//           }),
//         ],
//       );
//     }
//   }

//   Widget _buildActionButton(
//     String text,
//     VoidCallback onPressed, {
//     bool isMobile = false,
//   }) {
//     return Container(
//       width: isMobile ? double.infinity : null,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(30),
//         border: Border.all(color: const Color(0xFFD4AF37), width: 1.5),
//         gradient: LinearGradient(
//           colors: [
//             Colors.transparent,
//             const Color(0xFFD4AF37).withValues(alpha: 0.1),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(30),
//           onTap: onPressed,
//           child: Container(
//             padding: EdgeInsets.symmetric(
//               horizontal: isMobile ? 30 : 40,
//               vertical: 20,
//             ),
//             child: Row(
//               mainAxisSize: isMobile ? MainAxisSize.max : MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   text,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: isMobile ? 12 : 14,
//                     fontWeight: FontWeight.w500,
//                     color: const Color(0xFFD4AF37),
//                     letterSpacing: 1.5,
//                     height: 1.3,
//                   ),
//                 ),
//                 const SizedBox(width: 15),
//                 const Icon(
//                   Icons.arrow_forward,
//                   color: Color(0xFFD4AF37),
//                   size: 18,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildDecorativeElements() {
//     return [
//       Positioned(
//         top: 100,
//         right: -100,
//         child: Container(
//           width: 400,
//           height: 400,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             gradient: RadialGradient(
//               colors: [
//                 Colors.white.withValues(alpha: 0.05),
//                 Colors.transparent,
//               ],
//             ),
//           ),
//         ),
//       ),
//       Positioned(
//         bottom: -150,
//         left: -150,
//         child: Container(
//           width: 500,
//           height: 500,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             gradient: RadialGradient(
//               colors: [
//                 Colors.white.withValues(alpha: 0.03),
//                 Colors.transparent,
//               ],
//             ),
//           ),
//         ),
//       ),
//     ];
//   }

//   // Navigation methods
//   void _navigateToEducation() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Education page - Coming soon!')),
//     );
//   }

//   void _navigateToAbout() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('About us page - Coming soon!')),
//     );
//   }

//   void _navigateToRegister() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => BusinessRegistrationScreen()),
//     );
//   }

//   void _navigateToLogin() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => BusinessLoginScreen()),
//     );
//   }
// }

// // Main App
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Ingilosi Mali',
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //         fontFamily: 'SF Pro Display',
// //       ),
// //       home: const LandingPage(),
// //     );
// //   }
// // }

// // void main() {
// //   runApp(const MyApp());
// // }

// // Placeholder screens for navigation
// class InvestorLoungeScreen extends StatelessWidget {
//   const InvestorLoungeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Investor Lounge'),
//         backgroundColor: const Color(0xFF2D4A5A),
//         foregroundColor: Colors.white,
//       ),
//       body: const Center(
//         child: Text('Investor Lounge Screen', style: TextStyle(fontSize: 24)),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:ingilosi_mali/screens/business_lounge.dart';
import 'package:ingilosi_mali/screens/login_business_screen.dart';
import 'package:ingilosi_mali/screens/register_business_screen.dart';

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
    'Statistics'
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
      MaterialPageRoute(builder: (context) => BusinessRegistrationScreen()),
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
          width: isLargeScreen ? 60 : 45,
          height: isLargeScreen ? 60 : 45,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.featured_play_list_outlined,
                size: isLargeScreen ? 50 : 35,
                color: Colors.white.withValues(alpha: 0.8),
              ),
              Text(
                '\$',
                style: TextStyle(
                  fontSize: isLargeScreen ? 28 : 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFD4AF37),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: isLargeScreen ? 15 : 10),
        Text(
          'Ingilosi Mali',
          style: TextStyle(
            fontSize: isLargeScreen ? 24 : 18,
            fontWeight: FontWeight.w300,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
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
    'Contact Support'
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
      MaterialPageRoute(builder: (context) => BusinessRegistrationScreen()),
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

  // Widget _buildLogo() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Container(
  //         width: 40,
  //         height: 40,
  //         decoration: BoxDecoration(
  //           color: Colors.transparent,
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         child: Stack(
  //           alignment: Alignment.center,
  //           children: [
  //             Icon(
  //               Icons.featured_play_list_outlined,
  //               size: 30,
  //               color: Colors.white.withValues(alpha: 0.8),
  //             ),
  //             Text(
  //               '\$',
  //               style: TextStyle(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.bold,
  //                 color: const Color(0xFFD4AF37),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(width: 10),
  //       const Text(
  //         'Ingilosi Mali',
  //         style: TextStyle(
  //           fontSize: 16,
  //           fontWeight: FontWeight.w300,
  //           color: Colors.white,
  //           letterSpacing: 1.2,
  //         ),
  //       ),
  //     ],
  //   );
  // }

// Replace the _buildLogo method in CustomAppDrawer class with this:

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
            'lib/Assets/images/logo2.png',
            width: 40,
            height: 40,
            fit: BoxFit.cover,
            // errorBuilder: (context, error, stackTrace) {
            //   // Fallback to the original icon-based logo if image fails to load
            //   return Container(
            //     decoration: BoxDecoration(
            //       color: Colors.transparent,
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     child: Stack(
            //       alignment: Alignment.center,
            //       children: [
            //         Icon(
            //           Icons.featured_play_list_outlined,
            //           size: 30,
            //           color: Colors.white.withValues(alpha: 0.8),
            //         ),
            //         Text(
            //           '\$',
            //           style: TextStyle(
            //             fontSize: 18,
            //             fontWeight: FontWeight.bold,
            //             color: const Color(0xFFD4AF37),
            //           ),
            //         ),
            //       ],
            //     ),
            //   );
            // },
          ),
        ),
      ),
      // const SizedBox(width: 10),
      // const Text(
      //   'Ingilosi Mali',
      //   style: TextStyle(
      //     fontSize: 16,
      //     fontWeight: FontWeight.w300,
      //     color: Colors.white,
      //     letterSpacing: 1.2,
      //   ),
      // ),
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

// Main Landing Page
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    // Start animations
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }
Widget _buildActionButtons(bool isMobile, bool isTablet) {
    return Column(
      children: [
        // Primary CTA Button
        Container(
          width: isMobile ? double.infinity : (isTablet ? 400 : 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: [
                const Color(0xFFD4AF37),
                const Color(0xFFD4AF37).withValues(alpha: 0.8),
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
              onTap: _navigateToRegister,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 30 : 40,
                  vertical: isMobile ? 18 : 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.rocket_launch,
                      color: Colors.white,
                      size: isMobile ? 20 : 24,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      'GET STARTED NOW',
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
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
        ),
        
        const SizedBox(height: 20),
        
        // Secondary CTA Button
        Container(
          width: isMobile ? double.infinity : (isTablet ? 400 : 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.8),
              width: 1.5,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: _navigateToLogin,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 30 : 40,
                  vertical: isMobile ? 18 : 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.login,
                      color: Colors.white,
                      size: isMobile ? 20 : 24,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      'SIGN IN',
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildDecorativeElements() {
    return [
      // Top-left decorative element
      Positioned(
        top: 150,
        left: 50,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFD4AF37).withValues(alpha: 0.1),
            border: Border.all(
              color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
              width: 1,
            ),
          ),
        ),
      ),
      
      // Top-right decorative element
      Positioned(
        top: 200,
        right: 80,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.1),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
        ),
      ),
      
      // Bottom-left decorative element
      Positioned(
        bottom: 150,
        left: 100,
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xFFD4AF37).withValues(alpha: 0.1),
            border: Border.all(
              color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
              width: 1,
            ),
          ),
        ),
      ),
      
      // Bottom-right decorative element
      Positioned(
        bottom: 200,
        right: 60,
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.05),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
        ),
      ),
      
      // Floating icons
      Positioned(
        top: 120,
        right: 200,
        child: Icon(
          Icons.trending_up,
          color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
          size: 40,
        ),
      ),
      
      Positioned(
        bottom: 300,
        left: 150,
        child: Icon(
          Icons.business,
          color: Colors.white.withValues(alpha: 0.2),
          size: 35,
        ),
      ),
    ];
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
        builder: (context) => const BusinessRegistrationScreen(),
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
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

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
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              // Hero Section
              _buildHeroSection(isMobile, isTablet),
              
              // Stats Section
              _buildStatsSection(isMobile),
              
              // Features Section
              _buildFeaturesSection(isMobile),
              
              // Roadmap Section
              _buildRoadmapSection(isMobile),
              
              // CTA Section
              _buildCTASection(isMobile),
              
              // Footer
              _buildFooter(isMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(bool isMobile, bool isTablet) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          // Main Content
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 20 : (isTablet ? 40 : 60),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Main Title
                      Text(
                        'Ingilosi Mali',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isMobile ? 48 : (isTablet ? 64 : 80),
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          letterSpacing: 2.0,
                          height: 1.0,
                        ),
                      ),
                      SizedBox(height: isMobile ? 20 : 30),
                      // Subtitle
                      Text(
                        'Unlocking Capital. Empowering Small Businesses.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isMobile ? 16 : (isTablet ? 20 : 24),
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(height: isMobile ? 40 : 60),
                      // Action Buttons
                      _buildActionButtons(isMobile, isTablet),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Decorative Elements
          if (!isMobile) ..._buildDecorativeElements(),
        ],
      ),
    );
  }

  Widget _buildStatsSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
        horizontal: isMobile ? 20 : 60,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.8),
      ),
      child: Column(
        children: [
          Text(
            'Transforming Business Funding',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.w300,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: isMobile ? 40 : 60),
          isMobile
              ? Column(
                  children: [
                    _buildStatItem('500+', 'Businesses Funded'),
                    const SizedBox(height: 30),
                    _buildStatItem('R2.5M', 'Capital Deployed'),
                    const SizedBox(height: 30),
                    _buildStatItem('95%', 'Success Rate'),
                    const SizedBox(height: 30),
                    _buildStatItem('24h', 'Average Match Time'),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem('500+', 'Businesses Funded'),
                    _buildStatItem('R2.5M', 'Capital Deployed'),
                    _buildStatItem('95%', 'Success Rate'),
                    _buildStatItem('24h', 'Average Match Time'),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color(0xFFD4AF37),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white70,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesSection(bool isMobile) {
    final features = [
      {
        'icon': Icons.speed,
        'title': 'Fast Matching',
        'description': 'AI-powered algorithm matches investors with suitable businesses in under 24 hours.',
      },
      {
        'icon': Icons.security,
        'title': 'Secure Transactions',
        'description': 'Bank-grade security with end-to-end encryption for all financial transactions.',
      },
      {
        'icon': Icons.analytics,
        'title': 'Smart Analytics',
        'description': 'Comprehensive business analytics and risk assessment tools for informed decisions.',
      },
      {
        'icon': Icons.support_agent,
        'title': '24/7 Support',
        'description': 'Dedicated support team available around the clock to assist with your journey.',
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
        horizontal: isMobile ? 20 : 60,
      ),
      child: Column(
        children: [
          Text(
            'Why Choose Ingilosi Mali?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.w300,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: isMobile ? 40 : 60),
          isMobile
              ? Column(
                  children: features
                      .map((feature) => Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: _buildFeatureCard(
                              feature['icon'] as IconData,
                              feature['title'] as String,
                              feature['description'] as String,
                              isMobile,
                            ),
                          ))
                      .toList(),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: features.length,
                  itemBuilder: (context, index) {
                    final feature = features[index];
                    return _buildFeatureCard(
                      feature['icon'] as IconData,
                      feature['title'] as String,
                      feature['description'] as String,
                      isMobile,
                    );
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, String description, bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: isMobile ? 40 : 50,
            color: const Color(0xFFD4AF37),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoadmapSection(bool isMobile) {
    final roadmapSteps = [
      {
        'step': '01',
        'title': 'Register & Profile',
        'description': 'Create your investor profile with investment preferences, budget, and sector interests.',
        'icon': Icons.person_add,
      },
      {
        'step': '02',
        'title': 'AI-Powered Matching',
        'description': 'Our algorithm analyzes business profiles and matches them with your investment criteria.',
        'icon': Icons.auto_awesome,
      },
      {
        'step': '03',
        'title': 'Due Diligence',
        'description': 'Access comprehensive business analytics, financial reports, and risk assessments.',
        'icon': Icons.analytics,
      },
      {
        'step': '04',
        'title': 'Connect & Fund',
        'description': 'Direct communication with business owners and secure funding through our platform.',
        'icon': Icons.handshake,
      },
    ];

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
            'How It Works',
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
            'From Registration to Funding in 4 Simple Steps',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 14 : 18,
              color: Colors.white70,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: isMobile ? 40 : 60),
          isMobile
              ? Column(
                  children: roadmapSteps
                      .asMap()
                      .entries
                      .map((entry) => Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: _buildRoadmapStep(
                              entry.value,
                              entry.key < roadmapSteps.length - 1,
                              isMobile,
                            ),
                          ))
                      .toList(),
                )
              : Column(
                  children: roadmapSteps
                      .asMap()
                      .entries
                      .map((entry) => Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: _buildRoadmapStep(
                              entry.value,
                              entry.key < roadmapSteps.length - 1,
                              isMobile,
                            ),
                          ))
                      .toList(),
                ),
        ],
      ),
    );
  }

  Widget _buildRoadmapStep(Map<String, dynamic> step, bool showConnector, bool isMobile) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step Circle
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFD4AF37),
                    const Color(0xFFD4AF37).withValues(alpha: 0.7),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    step['icon'] as IconData,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    step['step'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    step['title'],
                    style: TextStyle(
                      fontSize: isMobile ? 18 : 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    step['description'],
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (showConnector)
          Container(
            margin: const EdgeInsets.only(left: 40, top: 10, bottom: 10),
            width: 2,
            height: 30,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFFD4AF37),
                  const Color(0xFFD4AF37).withValues(alpha: 0.3),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCTASection(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
        horizontal: isMobile ? 20 : 60,
      ),
      child: Column(
        children: [
          Text(
            'Ready to Transform Your Investment Journey?',
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
            'Join thousands of investors and businesses already using our platform',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 14 : 18,
              color: Colors.white70,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: isMobile ? 40 : 60),
          isMobile
              ? Column(
                  children: [
                    _buildCTAButton(
                      'START INVESTING',
                      Icons.trending_up,
                      () => BusinessRegistrationScreen(),
                      isMobile: true,
                    ),
                    const SizedBox(height: 20),
                    _buildCTAButton(
                      'REGISTER BUSINESS',
                      Icons.business,
                      () => BusinessRegistrationScreen(),
                      isMobile: true,
                      isSecondary: true,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCTAButton(
                      'START INVESTING',
                      Icons.trending_up,
                      () => BusinessRegistrationScreen(),
                    ),
                    const SizedBox(width: 30),
                    _buildCTAButton(
                      'REGISTER BUSINESS',
                      Icons.business,
                      () => BusinessRegistrationScreen(),
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
                  Colors.transparent,
                  const Color(0xFFD4AF37).withValues(alpha: 0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
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
                  color: isSecondary ? Colors.white : const Color(0xFFD4AF37),
                  size: 20,
                ),
                const SizedBox(width: 15),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 12 : 14,
                    fontWeight: FontWeight.w500,
                    color: isSecondary ? Colors.white : const Color(0xFFD4AF37),
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
          Text(
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
  }