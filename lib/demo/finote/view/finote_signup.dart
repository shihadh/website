import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shihad_portfolio/demo/finote/controller/finote_provider.dart';

class FinoteSignUpScreen extends StatelessWidget {
  const FinoteSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const SizedBox(height: 60),
            // Logo Mock
            Container(
              width: 60,
              height: 75,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Text(
                    '₹',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(width: 8, height: 8, color: Colors.red),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Sign Up',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Start managing your finances today',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 40),

            // White Form Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildInput('Enter your email', Icons.email_outlined),
                  const SizedBox(height: 16),
                  _buildInput('Enter your password', Icons.lock_outline),
                  const SizedBox(height: 16),
                  _buildInput('Confirm password', Icons.lock_outline),
                  const SizedBox(height: 24),

                  // Social Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialIcon(Icons.g_mobiledata, Colors.red),
                      const SizedBox(width: 20),
                      _buildSocialIcon(Icons.facebook, Colors.blue),
                      const SizedBox(width: 20),
                      _buildSocialIcon(Icons.phone, Colors.green),
                    ],
                  ),
                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (v) {}),
                      const Expanded(
                        child: Text(
                          'I agree to the Terms of Service and Privacy Policy',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<FinoteProvider>().setLoggedIn(true);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                          0xFFA0A0A0,
                        ), // Placeholder grey
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sign Up ',
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text.rich(
              TextSpan(
                text: 'Already have an account? ',
                style: TextStyle(color: Colors.grey),
                children: [
                  TextSpan(
                    text: 'Sign In',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(String hint, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.black54),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
      ),
      child: Icon(icon, color: color, size: 30),
    );
  }
}
