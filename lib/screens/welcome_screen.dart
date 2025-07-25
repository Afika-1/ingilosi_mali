
import 'package:alternative_funds/screens/faq_screen.dart';
import 'package:flutter/material.dart';
import 'package:alternative_funds/screens/dashboard.dart';
import 'package:alternative_funds/screens/landing_page_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _decorativeController;
  late Animation<double> _logoAnimation;
  late Animation<double> _buttonAnimation;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _slideUpAnimation;
  late Animation<double> _decorativeAnimation;

  @override
  void initState() {
    super.initState();
    
    // Main animation controller
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );

    // Decorative elements animation controller
    _decorativeController = AnimationController(
      duration: Duration(milliseconds: 3000),
      vsync: this,
    );

    _logoAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _buttonAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Fade in animation for content
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.0, curve: Curves.easeOut),
      ),
    );

    // Slide up animation for main content
    _slideUpAnimation = Tween<double>(begin: 0.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.2, 0.8, curve: Curves.easeOut),
      ),
    );

    // Decorative elements animation
    _decorativeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _decorativeController, curve: Curves.easeInOut),
    );

    // Start animations
    _animationController.repeat(reverse: true);
    _decorativeController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _decorativeController.dispose();
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
              Colors.black.withValues(alpha:0.4), // Slightly darker overlay
              BlendMode.darken,
            ),
          ),
        ),
        child: Stack(
          children: [
            // Decorative background elements
            ..._buildDecorativeElements(),
            
            // Logo and brand name in top left
            Positioned(
              top: 50,
              left: 20,
              child: AnimatedBuilder(
                animation: _fadeInAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeInAnimation.value,
                    child: ScaleTransition(
                      scale: _logoAnimation,
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.transparent,
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'lib/assets/images/logo.png',
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Text(
                          //       'Alternative',
                          //       style: TextStyle(
                          //         fontSize: 24,
                          //         fontWeight: FontWeight.w400,
                          //         color: Colors.white,
                          //         letterSpacing: 1.2,
                          //         shadows: [
                          //           Shadow(
                          //             color: Colors.black.withValues(alpha:0.5),
                          //             offset: Offset(1, 1),
                          //             blurRadius: 3,
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //     Text(
                          //       'Fund',
                          //       style: TextStyle(
                          //         fontSize: 20,
                          //         fontWeight: FontWeight.w300,
                          //         color: Color(0xFFD4AF37),
                          //         letterSpacing: 1.2,
                          //         shadows: [
                          //           Shadow(
                          //             color: Colors.black.withValues(alpha:0.5),
                          //             offset: Offset(1, 1),
                          //             blurRadius: 3,
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Main Content
            Center(
              child: AnimatedBuilder(
                animation: _slideUpAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _slideUpAnimation.value),
                    child: Opacity(
                      opacity: _fadeInAnimation.value,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Enhanced loading dots with glow effect
                            SizedBox(
                              height: 80,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildEnhancedLoadingDot(0),
                                  SizedBox(width: 25),
                                  _buildEnhancedLoadingDot(1),
                                  SizedBox(width: 25),
                                  _buildEnhancedLoadingDot(2),
                                ],
                              ),
                            ),

                            SizedBox(height: 60),

                            // Main title with gradient effect
                            ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [
                                  Color(0xFFD4AF37),
                                  // Colors.white,
                                  Color(0xFFD4AF37),
                                  Colors.white,
                                ],
                                stops: [0.0, 0.5, 1.0],
                              ).createShader(bounds),
                              child: Text(
                                'The Alternative Fund',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 56,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 3,
                                  height: 1.1,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withValues(alpha:0.7),
                                      offset: Offset(2, 2),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 30),

                            // Enhanced subtitle
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 15,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.black.withValues(alpha:0.3),
                                border: Border.all(
                                  color: Color(0xFFD4AF37).withValues(alpha:0.3),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                'SMME Funding, Matching Angels with Unicorns',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha:0.95),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1.2,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Enhanced welcome button
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: _fadeInAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeInAnimation.value,
                    child: ScaleTransition(
                      scale: _buttonAnimation,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: Container(
                            width: 240,
                            height: 65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFD4AF37).withValues(alpha:0.4),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FAQScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Color(0xFFD4AF37),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  side: BorderSide(
                                    color: Color(0xFFD4AF37),
                                    width: 2.5,
                                  ),
                                ),
                                elevation: 0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'GET STARTED',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 2.5,
                                      fontFamily: 'Agrandir',
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFD4AF37).withValues(alpha:0.2),
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDecorativeElements() {
    return [
      // Top-left decorative element with floating animation
      AnimatedBuilder(
        animation: _decorativeAnimation,
        builder: (context, child) {
          return Positioned(
            top: 150 + (10 * _decorativeAnimation.value),
            left: 50,
            child: Opacity(
              opacity: 0.6 + (0.4 * _decorativeAnimation.value),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFD4AF37).withValues(alpha:0.1),
                  border: Border.all(
                    color: Color(0xFFD4AF37).withValues(alpha:0.3 + (0.2 * _decorativeAnimation.value)),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFD4AF37).withValues(alpha:0.2),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      
      // Top-right decorative element
      AnimatedBuilder(
        animation: _decorativeAnimation,
        builder: (context, child) {
          return Positioned(
            top: 200 - (15 * _decorativeAnimation.value),
            right: 80,
            child: Opacity(
              opacity: 0.5 + (0.5 * _decorativeAnimation.value),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha:0.1),
                  border: Border.all(
                    color: Colors.white.withValues(alpha:0.2 + (0.3 * _decorativeAnimation.value)),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      
      // Bottom-left decorative element
      AnimatedBuilder(
        animation: _decorativeAnimation,
        builder: (context, child) {
          return Positioned(
            bottom: 150 + (8 * _decorativeAnimation.value),
            left: 100,
            child: Opacity(
              opacity: 0.4 + (0.6 * _decorativeAnimation.value),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xFFD4AF37).withValues(alpha:0.1),
                  border: Border.all(
                    color: Color(0xFFD4AF37).withValues(alpha:0.3 + (0.2 * _decorativeAnimation.value)),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      
      // Bottom-right decorative element
      AnimatedBuilder(
        animation: _decorativeAnimation,
        builder: (context, child) {
          return Positioned(
            bottom: 200 - (20 * _decorativeAnimation.value),
            right: 60,
            child: Opacity(
              opacity: 0.3 + (0.4 * _decorativeAnimation.value),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha:0.05),
                  border: Border.all(
                    color: Colors.white.withValues(alpha:0.1 + (0.2 * _decorativeAnimation.value)),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      
      // Floating trending up icon
      AnimatedBuilder(
        animation: _decorativeAnimation,
        builder: (context, child) {
          return Positioned(
            top: 120 + (12 * _decorativeAnimation.value),
            right: 200,
            child: Transform.rotate(
              angle: 0.1 * _decorativeAnimation.value,
              child: Icon(
                Icons.trending_up,
                color: Color(0xFFD4AF37).withValues(alpha:0.3 + (0.4 * _decorativeAnimation.value)),
                size: 40 + (5 * _decorativeAnimation.value),
              ),
            ),
          );
        },
      ),
      
      // Floating business icon
      AnimatedBuilder(
        animation: _decorativeAnimation,
        builder: (context, child) {
          return Positioned(
            bottom: 300 - (10 * _decorativeAnimation.value),
            left: 150,
            child: Transform.rotate(
              angle: -0.1 * _decorativeAnimation.value,
              child: Icon(
                Icons.business,
                color: Colors.white.withValues(alpha:0.2 + (0.3 * _decorativeAnimation.value)),
                size: 35 + (3 * _decorativeAnimation.value),
              ),
            ),
          );
        },
      ),
    ];
  }

  Widget _buildEnhancedLoadingDot(int index) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        double delay = index * 0.3;
        double animationValue = (_animationController.value + delay) % 1.0;
        
        return Container(
          width: 18 + (8 * animationValue),
          height: 18 + (8 * animationValue),
          decoration: BoxDecoration(
            color: Color(0xFF00A693).withValues(alpha:0.2 + (0.8 * animationValue)),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0xFF00A693).withValues(alpha:0.4 * animationValue),
                blurRadius: 8 * animationValue,
                spreadRadius: 2 * animationValue,
              ),
            ],
          ),
        );
      },
    );
  }
}