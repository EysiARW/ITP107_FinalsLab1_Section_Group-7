import 'package:flutter/material.dart';

import '../main.dart';

// ---------------------------------------------------------------------------
// Login screen — route: '/'
// ---------------------------------------------------------------------------

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  String? emailError, passwordError;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() {
      emailError = email.text.trim().isEmpty ? 'Enter your work email.' : null;
      passwordError = password.text.isEmpty ? 'Enter your password.' : null;
    });
    if (emailError == null && passwordError == null) {
      // No real backend here, so just grab whatever's before the "@" and
      // use it as a display name on the home screen.
      final derivedName = email.text.split('@').first;
      // Replace instead of push — once signed in, the back button
      // shouldn't take the user back to the login screen.
      Navigator.pushReplacementNamed(context, '/home',
          arguments: derivedName.isNotEmpty ? derivedName : 'there');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
              eyebrow: 'UNIVERSITY OF CABUYAO',
              title: 'Welcome back',
              subtitle: 'Sign in to continue to your student portal.'),
          const SizedBox(height: 30),
          PortalTextField(
              label: 'Work email',
              controller: email,
              icon: Icons.alternate_email_rounded,
              error: emailError,
              keyboardType: TextInputType.emailAddress),
          const SizedBox(height: 18),
          PortalPasswordField(
              label: 'Password', controller: password, error: passwordError),
          const SizedBox(height: 22),
          PrimaryActionButton(label: 'Sign in', onPressed: _submit),
          AuthSwitchLink(
            text: 'Need an account?',
            linkText: 'Create an account',
            // Regular push here — keep Login on the stack so Sign-Up's
            // back button can return to it.
            onTap: () => Navigator.pushNamed(context, '/signup'),
          ),
        ],
      ),
    );
  }
}
