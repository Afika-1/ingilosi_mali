// // import 'package:corpnet_flut/screens/business_lounge.dart';
// // import 'package:corpnet_flut/screens/landing_page_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:ingilosi_mali/screens/landing_page_screen.dart';

// class WelcomeScreen extends StatefulWidget {
//   const WelcomeScreen({super.key});
//   @override
//   State<WelcomeScreen> createState() => WelcomeScreenState();
// }

// class WelcomeScreenState extends State<WelcomeScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: Duration(milliseconds: 1200),
//       vsync: this,
//     );
//     _animation = Tween<double>(begin: 0.3, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
//     );
//     _animationController.repeat(reverse: true);
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('lib/assets/images/welcome.png'),
//             fit: BoxFit.fill,
//             alignment: Alignment.center,
//             colorFilter: ColorFilter.mode(
//               Colors.black.withValues(alpha: 0.3), // Add overlay
//               BlendMode.darken,
//             ),
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 40),
//             child: Column(
//               children: [
//                 SizedBox(height: 60),

//                 // Logo and brand name in top left
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         width: 80,
//                         height: 80,
//                         child: Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             Positioned.fill(
//                               child: Center(
//                                 child: Image.asset(
//                                   'lib/assets/images/logo2.png',
//                                   width: 200,
//                                   height: 200,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 Expanded(
//                   child: Column(
//                     // mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // Loading dots
//                       SizedBox(
//                         height: 60,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             _buildLoadingDot(0),
//                             SizedBox(width: 40),
//                             _buildLoadingDot(1),
//                             SizedBox(width: 40),
//                             _buildLoadingDot(2),
//                           ],
//                         ),
//                       ),

//                       SizedBox(height: 80),

//                       // Main title
//                       Text(
//                         'Ingelosi Imali',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 64,
//                           fontWeight: FontWeight.w400,
//                           letterSpacing: 2,
//                           fontFamily: 'SF Pro Display',
//                           height: 1.1,
//                         ),
//                       ),

//                       SizedBox(height: 30),

//                       // Subtitle
//                       Text(
//                         'Unlocking Capital. Empowering Small Businesses.',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Colors.white.withValues(alpha: 0.9),
//                           fontSize: 20,
//                           fontWeight: FontWeight.w400,
//                           letterSpacing: 0.8,
//                           fontFamily: 'SF Pro Display',
//                           height: 1.3,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Welcome button
//                 Padding(
//                   padding: EdgeInsets.only(bottom: 60),
//                   child: SizedBox(
//                     width: 220,
//                     height: 60,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => LandingPage(),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.transparent,
//                         foregroundColor: Color(0xFFD4AF37),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           side: BorderSide(color: Color(0xFFD4AF37), width: 2),
//                         ),
//                         elevation: 0,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'WELCOME',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               letterSpacing: 2,
//                               fontFamily: 'Agrandir',
//                             ),
//                           ),
//                           SizedBox(width: 12),
//                           Icon(Icons.arrow_forward, size: 20),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLoadingDot(int index) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, child) {
//         double delay = index * 0.2;
//         double animationValue = (_animation.value + delay) % 2.0;

//         return Container(
//           width: 20,
//           height: 20,
//           decoration: BoxDecoration(
//             color: Color(
//               0xFF00A693,
//             ).withValues(alpha: 0.3 + (0.7 * animationValue)),
//             shape: BoxShape.circle,
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:ingilosi_mali/screens/landing_page_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _logoAnimation;
  late Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );

    _logoAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _buttonAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/welcome.png'),
            fit: BoxFit.fill,
            alignment: Alignment.center,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3), // Add overlay
              BlendMode.darken,
            ),
          ),
        ),
        child: Stack(
          children: [
            // Logo and brand name in top left
            Positioned(
              top: 50,
              left: 20,
              child: ScaleTransition(
                scale: _logoAnimation,
                child: Row(
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.asset(
                        'lib/assets/images/logo2.png',
                        width: 80,
                        height: 80,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Ingalozi Mali',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Main Content
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Loading dots
                    SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildLoadingDot(0),
                          SizedBox(width: 20),
                          _buildLoadingDot(1),
                          SizedBox(width: 20),
                          _buildLoadingDot(2),
                        ],
                      ),
                    ),

                    SizedBox(height: 80),

                    // Main title
                    Text(
                      'Ingalozi Imali',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 64,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 2,
                        height: 1.1,
                      ),
                    ),

                    SizedBox(height: 30),

                    // Subtitle
                    Text(
                      'Unlocking Capital. Empowering Small Businesses.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.8,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Welcome button
            // Welcome button
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: ScaleTransition(
                scale: _buttonAnimation,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    // Center the button within the available space
                    child: SizedBox(
                      width: 220, // Fixed width
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LandingPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Color(0xFFD4AF37),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(
                              color: Color(0xFFD4AF37),
                              width: 2,
                            ),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'WELCOME',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 2,
                                fontFamily: 'Agrandir',
                              ),
                            ),
                            SizedBox(width: 12),
                            Icon(Icons.arrow_forward, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingDot(int index) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        double delay = index * 0.2;
        double animationValue =
            (_animationController.value + delay) % 1.0; // Changed to % 1.0

        return Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Color(0xFF00A693).withOpacity(0.3 + (0.7 * animationValue)),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
