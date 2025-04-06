import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(context,
        '/login', (Route<dynamic> route) => false);
  }

  void _navigateToTranslation(BuildContext context) {
    Navigator.pushNamed(context, '/translation');
  }

  void _navigateToCommunication(BuildContext context) {
    Navigator.pushNamed(context, '/communication');
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
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCard(
                context,
                icon: Icons.translate,
                title: 'Translations',
                onTap: () => _navigateToTranslation(context),
              ),
              const SizedBox(height: 20),
              _buildCard(
                context,
                icon: Icons.chat,
                title: 'Communication',
                onTap: () => _navigateToCommunication(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Colors.green),
              const SizedBox(width: 20),
              Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
