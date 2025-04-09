import 'package:flutter/material.dart';
import 'package:savings_app/utils/TokenStorage.dart';

class SettingsPage extends StatelessWidget {
  final tokenStorage = TokenStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        children: [
          // Section 1: Account Settings
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 20.0,
            ),
            child: Text(
              'Account Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.orange,
              ),
            ),
          ),
          Divider(color: Colors.orange, thickness: 1.5),
          ListTile(
            title: Text(
              'Change Password',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange),
            onTap: () {
              // Handle change password
            },
          ),
          ListTile(
            title: Text(
              'Manage Account',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange),
            onTap: () {
              // Handle manage account
            },
          ),

          // Section 2: Notifications
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 20.0,
            ),
            child: Text(
              'Notifications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.orange,
              ),
            ),
          ),
          Divider(color: Colors.orange, thickness: 1.5),
          ListTile(
            title: Text(
              'Push Notifications',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            trailing: Switch(
              value: true,
              activeColor: Colors.orange,
              onChanged: (value) {
                // Handle push notifications toggle
              },
            ),
          ),
          ListTile(
            title: Text(
              'Email Preferences',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange),
            onTap: () {
              // Handle email preferences
            },
          ),

          // Section 3: About
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 20.0,
            ),
            child: Text(
              'About',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.orange,
              ),
            ),
          ),
          Divider(color: Colors.orange, thickness: 1.5),
          ListTile(
            title: Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange),
            onTap: () {
              // Handle privacy policy
            },
          ),
          ListTile(
            title: Text(
              'Terms of Service',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange),
            onTap: () {
              // Handle terms of service
            },
          ),
          ListTile(
            title: Text(
              'App Version: 1.0.0',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            onTap: () {
              // Handle app version click
            },
          ),
          Divider(color: Colors.orange, thickness: 1.5),
          ListTile(
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red),
            ),
            onTap: () async {
              await tokenStorage.deleteToken();
              Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
