import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (Route<dynamic> route) => false,
    );
  }

  void _navigateToTranslation(BuildContext context) {
    Navigator.pushNamed(context, '/translation');
  }

  void _navigateToCommunication(BuildContext context) {
    Navigator.pushNamed(context, '/communication');
  }

  void _navigateToTutorial(BuildContext context) {
    Navigator.pushNamed(context, '/tutorial');
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userName = user?.displayName ?? 'Guest';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => _logout(context),
        ),
        title: Text("Welcome, $userName"),
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Left side - Recognize / Translations
              Expanded(
                flex: 1,
                child: _buildCard(
                  context,
                  icon: Icons.translate,
                  title: 'Recognize',
                  onTap: () => _navigateToTranslation(context),
                  height: double.infinity,
                  
                ),
              ),
              const SizedBox(width: 16),
              // Right side - stacked Communication and Tutorial
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                      child: _buildCard(
                        context,
                        icon: Icons.chat,
                        title: 'Communicate',
                        onTap: () => _navigateToCommunication(context),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: _buildCard(
                        context,
                        icon: Icons.menu_book,
                        title: 'Tutorial',
                        onTap: () => _navigateToTutorial(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    double? height,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: height,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.green),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
