import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? _token;

  @override
  void initState() {
    super.initState();
    // Simulate token retrieval (e.g., from shared preferences, secure storage, or API)
    _token = "your_sample_token";
  }

  void _handleCardTap(String label) {
    // Handle card taps, passing the token if needed
    if (_token != null) {
      print("Tapped on $label with token: $_token");
      // Add navigation or other logic here
    } else {
      print("No token available. Please log in.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(20),
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        children: [
          _buildDashboardCard(Icons.person, "Profile"),
          _buildDashboardCard(Icons.settings, "Settings"),
          _buildDashboardCard(Icons.bar_chart, "Reports"),
          _buildDashboardCard(Icons.logout, "Logout"),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(IconData icon, String label) {
    return GestureDetector(
      onTap: () => _handleCardTap(label),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.blueAccent),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
