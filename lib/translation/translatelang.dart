import 'package:flutter/material.dart';

class TranslateLang extends StatefulWidget {
  @override
  State<TranslateLang> createState() => _TranslateLangState();
}

class _TranslateLangState extends State<TranslateLang> {
  String _selectedLanguage = '';

  void _selectLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
    // You might want to navigate back or do something with the selected language
    Navigator.pop(context, _selectedLanguage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Select Language',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Image.asset(
                  'assets/images/translatelang.png',
                  height: 150,
                  width: 150,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => _selectLanguage('Malay'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                child: const Text('Malay'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _selectLanguage('English'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                child: const Text('English'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
