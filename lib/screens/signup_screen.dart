import 'package:flutter/material.dart';

import '../main.dart';

// ---------------------------------------------------------------------------
// Sign-up screen — route: '/signup'
// ---------------------------------------------------------------------------

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final fullName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  String? nameError, emailError, passwordError, confirmError;

  @override
  void dispose() {
    fullName.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() {
      nameError = fullName.text.trim().isEmpty ? 'Enter your full name.' : null;
      emailError = email.text.trim().isEmpty ? 'Enter your work email.' : null;
      passwordError = password.text.isEmpty ? 'Create a password.' : null;
      confirmError = confirmPassword.text.isEmpty
          ? 'Confirm your password.'
          : (password.text != confirmPassword.text
              ? 'Passwords do not match.'
              : null);
    });
    if ([nameError, emailError, passwordError, confirmError]
        .every((e) => e == null)) {
      // Same idea as login: replace so the user can't go "back" into the
      // sign-up form after their account is created.
      Navigator.pushReplacementNamed(context, '/home',
          arguments: fullName.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
              eyebrow: 'JOIN PNC CONNECT',
              title: 'Create your account',
              subtitle: 'Set up your student portal access.'),
          const SizedBox(height: 30),
          PortalTextField(
              label: 'Full name',
              controller: fullName,
              icon: Icons.person_outline_rounded,
              error: nameError),
          const SizedBox(height: 18),
          PortalTextField(
              label: 'Work email',
              controller: email,
              icon: Icons.alternate_email_rounded,
              error: emailError,
              keyboardType: TextInputType.emailAddress),
          const SizedBox(height: 18),
          PortalPasswordField(
              label: 'Password', controller: password, error: passwordError),
          const SizedBox(height: 18),
          PortalPasswordField(
              label: 'Confirm password',
              controller: confirmPassword,
              error: confirmError),
          const SizedBox(height: 22),
          PrimaryActionButton(label: 'Create account', onPressed: _submit),
          AuthSwitchLink(
            text: 'Already have an account?',
            linkText: 'Sign in',
            // Just pop back to Login instead of navigating there again.
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
