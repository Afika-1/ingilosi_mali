// import 'package:flutter/material.dart';
// import 'package:ingilosi_mali/screens/login_business_screen.dart';

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

//     // Show search results in a snackbar
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
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Registration page'),
//         duration: Duration(seconds: 2),
//       ),
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
//     return Image.asset(
//       'lib/assets/images/logo2.png',
//       height: isLargeScreen ? 50 : 40,
//       fit: BoxFit.contain,
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