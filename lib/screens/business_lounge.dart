// import 'package:corpnet_flut/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:ingilosi_mali/screens/register_business_screen.dart';
import 'package:ingilosi_mali/screens/welcome_screen.dart';
// import '../screens/register_business_screen.dart';

class BusinessLoungeScreen extends StatelessWidget {
  const BusinessLoungeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/asset/images/businessLounge.jpg'),

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
          child: SafeArea(
            child: Column(
              children: [
                // Header
                _buildHeader(context),

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
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),
          Row(
            children: [
              _buildHeaderButton(
                context,
                'Settings',
                Icons.settings_outlined,
                () =>
                // _showSnackBar(context, 'Settings clicked'),
                 Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(),
                  ),
                ),
              ),
              const SizedBox(width: 20),

              _buildHeaderButton(
                context,
                'Account',
                Icons.account_circle_outlined,
                () =>  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BusinessRegistrationScreen(),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              _buildHeaderButton(
                context,
                'Search',
                Icons.search,
                () => _showSnackBar(context, 'Search clicked'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return FilledButton.tonal(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: Colors.white.withValues(alpha: 0.1),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 8),
          Icon(icon, size: 20),
        ],
      ),
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

  void _handleServiceTap(BuildContext context, String service) {
    // _showSnackBar(context, '$service selected');
    // Navigate to service page
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => ServiceDetailPage(service: service),
    //   ),
    // );
    // Navigator.pushReplacement(
    //   context, MaterialPageRoute(
    //     builder: (context)=>BusinessLoungeScreen()));
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Business Lounge',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          brightness: Brightness.dark,
        ),
        fontFamily: 'System',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontWeight: FontWeight.w200,
            letterSpacing: -0.5,
          ),
          titleLarge: TextStyle(
            fontWeight: FontWeight.w300,
            letterSpacing: 0.5,
          ),
          bodyMedium: TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
      home: const BusinessLoungeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

void main() {
  runApp(const MyApp());
}
