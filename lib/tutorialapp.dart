import 'package:flutter/material.dart';
import 'package:signspeak/dashboard/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppUsageTutorialPage extends StatelessWidget {
  const AppUsageTutorialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("How to Use This App"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                const Text(
                  'Welcome to SignSpeak!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text(
                  'This app helps you translate, learn and communicate using sign language. Here’s how to get started:',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),

                _buildStep(
                  icon: Icons.translate,
                  title: 'Recognize',
                  description: 'Tap on the "Recognize" card to open your camera and detect sign language in real-time.',
                ),
                const SizedBox(height: 16),
                _buildStep(
                  icon: Icons.chat,
                  title: 'Communicate',
                  description: 'Use this to input text and see its sign translation, or send sign messages.',
                ),
                const SizedBox(height: 16),
                _buildStep(
                  icon: Icons.menu_book,
                  title: 'Tutorial',
                  description: 'View sign images from A–Z and learn how to perform them.',
                ),
                const SizedBox(height: 32),

                const Text(
                  'Tips:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text(
                  '• Make sure your hand is visible to the camera.\n• Use the app in a well-lit area.\n• Practice with the A–Z guide regularly.',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('hasSeenTutorial', true);  // Mark the tutorial as seen

  // Navigate to the homepage after the tutorial is done
  Navigator.pushReplacementNamed(context, '/home');  
},

              child: const Text("Continue to App", style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep({required IconData icon, required String title, required String description}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.green),
        title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(description),
      ),
    );
  }
}
