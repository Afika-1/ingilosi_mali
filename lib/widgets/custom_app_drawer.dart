// import 'package:flutter/material.dart';
// import 'package:ingilosi_mali/screens/login_business_screen.dart';

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
//                 Navigator.pop(context); // Close drawer after search
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
//     return Image.asset(
//       'lib/assets/images/logo2.png',
//       height: 40,
//       fit: BoxFit.contain,
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
//         Navigator.pop(context); // Close drawer first
//         onTap(); // Then execute the navigation
//       },
//       hoverColor: Colors.white.withValues(alpha: 0.1),
//     );
//   }
// }