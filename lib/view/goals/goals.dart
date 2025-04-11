import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:savings_app/components/transaction_item.dart';

class GoalsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sample data for goals
    final goals = [
      {
        'title': 'New Car',
        'target': 15000.0,
        'saved': 5250.0,
        'deadline': 'December 2025',
        'icon': Icons.directions_car,
      },
      {
        'title': 'Vacation',
        'target': 3000.0,
        'saved': 1800.0,
        'deadline': 'August 2025',
        'icon': Icons.beach_access,
      },
      {
        'title': 'Emergency Fund',
        'target': 10000.0,
        'saved': 7500.0,
        'deadline': 'Ongoing',
        'icon': Icons.health_and_safety,
      },
      {
        'title': 'New Laptop',
        'target': 2000.0,
        'saved': 500.0,
        'deadline': 'September 2025',
        'icon': Icons.laptop_mac,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Your Goals',
          style: TextStyle(
            color: Color(0xFF2D3748),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Color(0xFF2D3748)),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.deepOrange, Colors.orangeAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Goal Total',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '£30,000',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Goals list header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Active Goals',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // View all goals
                    },
                    child: Text(
                      'View All',
                      style: TextStyle(
                        color: Colors.orange[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ...(goals as List<Map<String, dynamic>>).map((
                goal) {
              return TransactionItem(
                date: goal['deadline'],
                isDeposit: true,
                title: goal['title'],
                amount: goal['target'],
                iconData: Icons
                    .description, // Replace with logic to map category to icon if needed
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add goal functionality
        },
        backgroundColor: Colors.orange[700],
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF4F46E5),
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
            return;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.savings),
            label: 'Goals',
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}