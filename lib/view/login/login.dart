import 'package:flutter/material.dart';
import 'package:totalx/view/otp_page/otp_verification_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/login image.jpg',
              height: 150,
            ),
            const SizedBox(height: 30),
            const Text(
              'Enter Phone Number',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Enter Phone Number *',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: 'By Continuing, I agree to TotalX’s ',
                style: TextStyle(color: Colors.black54),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Terms and condition',
                    style: TextStyle(color: Colors.blue),
                  ),
                  TextSpan(text: ' & '),
                  TextSpan(
                    text: 'privacy policy',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OTPVerificationPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Get OTP',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
