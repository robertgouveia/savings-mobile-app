import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:savings_app/components/quick_action_button.dart';
import 'package:savings_app/components/transaction_item.dart';
import 'package:savings_app/utils/TokenStorage.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String email = 'loading...'; // State variable for email

  @override
  void initState() {
    super.initState();
    fetchEmail(); // Start fetching email on widget initialization
  }

  // Asynchronous function to fetch email and update the state
  Future<void> fetchEmail() async {
    final tokenStorage = TokenStorage();
    final fetchedEmail = await tokenStorage.getEmail();
    setState(() {
      if (fetchedEmail == null) {
        email = 'Not found';
        return;
      };
      email = fetchedEmail.split('@')[0]; // Update state and rebuild
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Welcome $email',
          style: const TextStyle(
            color: Color(0xFF2D3748),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Color(0xFF2D3748)),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(12),
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
                    'Balance',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '£12,580.50',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Forecasted - Yearly',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Text(
                                '£21,293',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  '30%',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Savings Goals
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'My Expenses',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    Text(
                      '£2025.99',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('See All'),
                ),
              ],
            ),

            const SizedBox(height: 16),

            const TransactionItem(
              date: 'monthly',
              isDeposit: false,
              title: 'Rent',
              amount: 1200,
              iconData: Icons.house,
            ),

            const SizedBox(height: 16),
            const TransactionItem(
              date: 'monthly',
              isDeposit: false,
              title: 'Food',
              amount: 500,
              iconData: Icons.set_meal,
            ),

            const SizedBox(height: 16),
            const TransactionItem(
              date: 'monthly',
              isDeposit: false,
              title: 'Car',
              amount: 300,
              iconData: Icons.car_rental,
            ),

            const SizedBox(height: 16),
            const TransactionItem(
              date: 'monthly',
              isDeposit: false,
              title: 'Netflix',
              amount: 15.99,
              iconData: Icons.movie,
            ),

            const SizedBox(height: 24),

            // Quick Actions
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                QuickActionButton(
                  title: 'Deposit',
                  icon: Icons.add_circle_outline,
                  color: Colors.green,
                  onTap: () {},
                ),
                QuickActionButton(
                  title: 'Withdraw',
                  icon: Icons.remove_circle_outline,
                  color: Colors.red,
                  onTap: () {},
                ),
                QuickActionButton(
                  title: 'Transfer',
                  icon: Icons.swap_horiz,
                  color: Colors.blue,
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Recent Transactions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Transactions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('View All'),
                ),
              ],
            ),

            const SizedBox(height: 16),

            const TransactionItem(
              title: 'Weekly Deposit',
              amount: 250,
              isDeposit: true,
              date: 'Today',
              iconData: Icons.account_balance,
            ),

            const Divider(),

            const TransactionItem(
              title: 'Bonus Savings',
              amount: 150,
              isDeposit: true,
              date: 'Yesterday',
              iconData: Icons.savings,
            ),

            const Divider(),

            const TransactionItem(
              title: 'Emergency Withdrawal',
              amount: 80,
              isDeposit: false,
              date: 'Apr 3, 2025',
              iconData: Icons.medical_services,
            ),

            const Divider(),

            const TransactionItem(
              title: 'Paycheck Deposit',
              amount: 500,
              isDeposit: true,
              date: 'Apr 1, 2025',
              iconData: Icons.account_balance_wallet,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF4F46E5),
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
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
}