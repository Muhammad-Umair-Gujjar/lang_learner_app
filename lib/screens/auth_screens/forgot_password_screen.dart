
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/auth_provider.dart';
import 'components/custom_header.dart';
import 'components/custom_text_field.dart';
import 'components/round_button.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final emailController = TextEditingController();
  bool loading = false;

  Future<void> _resetPassword() async {
    setState(() => loading = true);
    final message = await context
        .read<AuthProvider>()
        .sendPasswordResetEmail(emailController.text);

    if (mounted && message != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomHeader(
              heading: "Password Reset",
              subHeading: "Enter email to reset \nyour password",
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  CustomTextField(
                    controller: emailController,
                    hintText: "Email",
                    prefixIcon: Icons.email,
                  ),
                  const SizedBox(height: 20),
                  RoundButton(
                    label: 'Reset Password',
                    loading: loading,
                    onTap: _resetPassword,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
