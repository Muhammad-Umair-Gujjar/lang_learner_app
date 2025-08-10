
import 'package:flutter/material.dart';
import 'package:flutter_project/provider/streak_provider.dart';
import 'package:flutter_project/screens/main_screen.dart';
import 'package:provider/provider.dart';
import '../../core/constants.dart';
import '../../provider/auth_provider.dart';
import 'components/custom_header.dart';
import 'components/custom_text_field.dart';
import 'components/round_button.dart';
import 'forgot_password_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleEmailLogin(AuthProvider authProvider,StreakProvider streakProvider) async {
    if (_formKey.currentState!.validate()) {
      final success = await authProvider.loginWithEmail(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (!mounted) return;

      if (success) {
        await streakProvider.updateStreak();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authProvider.errorMessage ?? "Login failed")),
        );
      }
    }
  }

  Future<void> _handleGoogleLogin(AuthProvider authProvider,StreakProvider streakProvider) async {
    final success = await authProvider.loginWithGoogle();
    if (!mounted) return;

    if (success) {
      await streakProvider.updateStreak();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authProvider.errorMessage ?? "Google login failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final streakProvider = Provider.of<StreakProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomHeader(
              heading: "Login",
              subHeading: "Login to continue your \njourney",
            ),
            const SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.all(defaultPadding * 1.5),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: emailController,
                      hintText: "Email",
                      prefixIcon: Icons.email,
                      validator: (value) =>
                      value!.isEmpty ? "Enter email" : null,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: passwordController,
                      hintText: "Password",
                      prefixIcon: Icons.lock_open_outlined,
                      obscureText: _obscurePassword,
                      suffixIcon: _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      onSuffixTap: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                      ),
                      validator: (value) =>
                      value!.isEmpty ? "Enter Password" : null,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ForgetPasswordScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(color: primaryDark),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    RoundButton(
                      label: 'Login',
                      loading: authProvider.loading,
                      onTap: () => _handleEmailLogin(authProvider,streakProvider),
                    ),
                    const SizedBox(height: 20),
                    _buildGoogleSignIn(authProvider,streakProvider),
                    const SizedBox(height: 60),
                    _buildSignupLink(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoogleSignIn(AuthProvider authProvider,StreakProvider streakProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Continue with",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: primaryDark,
            fontWeight: FontWeight.w400,
          ),
        ),
        IconButton(
          onPressed: authProvider.loading
              ? null
              : () => _handleGoogleLogin(authProvider,streakProvider),
          icon: Image.asset('assets/images/google.png', height: 18),
        ),
      ],
    );
  }

  Widget _buildSignupLink(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don’t have an account?",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SignupScreen()),
              );
            },
            child: Text(
              "Signup",
              style: TextStyle(color: primaryRed),
            ),
          ),
        ],
      ),
    );
  }
}

