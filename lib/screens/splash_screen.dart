import 'package:flutter/material.dart';
import 'package:flutter_project/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import '../core/constants.dart';
import '../firebase_services/auth_flow.dart';
import '../provider/streak_provider.dart';
import '../provider/user_progres_provider.dart';
import 'auth_screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.elasticOut),
      ),
    );

    _controller.forward();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final currentlanguage= await Provider.of<ProfileProvider>(context, listen: false).currentLanguage;
    await Provider.of<UserProgress>(context, listen: false).initializeProgress(currentlanguage);
    await  Provider.of<StreakProvider>(context, listen: false).initialize();
    await Future.delayed(const Duration(seconds: 1));
    AuthFlow.initializeAuthFlow(context);
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryRed.withOpacity(0.9), primaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.1, 0.9],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Logo with Scale Animation
                  Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Opacity(
                      opacity: _opacityAnimation.value,
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 150,
                        width: 150,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: _opacityAnimation.value,
                    child: Image(
                      image: AssetImage("assets/images/text_logo.png"),
                      height: 120,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    "Learn without limits",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                      letterSpacing: 1.2,
                    ),
                  ),

                  const SizedBox(height: 50),

                  if (_controller.value > 0.7)
                    Opacity(
                      opacity: ((_controller.value - 0.7) / 0.3).clamp(
                        0.0,
                        1.0,
                      ),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
