import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:savings_app/components/transaction_item.dart';
import 'package:savings_app/utils/TokenStorage.dart';

import '../../utils/claude.dart';

final response = {
  "id": "msg_01XZ5ZJccLYZEy5t2cPfgZ36",
  "type": "message",
  "role": "assistant",
  "model": "claude-3-7-sonnet-20250219",
  "content": [
    {
      "type": "text",
      "text": """{
    "optimization_message": "Based on your current savings rate of about \$433/month, I recommend slightly increasing your monthly savings to \$450. Consider reducing dining out expenses by \$20/month which could accelerate your car savings goal by approximately one month. Also, prioritize paying off your laptop debt first since it carries 4.5% interest.",
    "forecast_eoy_balance": 7058,
    "expected_goal_dates": {
      "car": "December 2025",
      "debt_free": "October 2025"
    }
  }"""
    }
  ],
  "stop_reason": "end_turn",
  "stop_sequence": null,
  "usage": {
    "input_tokens": 403,
    "cache_creation_input_tokens": 0,
    "cache_read_input_tokens": 0,
    "output_tokens": 137
  }
};

// will soon be sent over API.
final inputData = {
  "year": 2025.0,
  "income": [
    {
      "type": "salary",
      "amount": 24000.0,
      "frequency": "annual",
      "after_tax": false
    }
  ],
  "expenses": [
    {
      "type": "rent",
      "amount": 365.0,
      "frequency": "monthly",
      "category": "housing"
    },
    {
      "type": "groceries",
      "amount": 250.0,
      "frequency": "monthly",
      "category": "food"
    },
    {
      "type": "utilities",
      "amount": 50.0,
      "frequency": "monthly",
      "category": "housing"
    },
    {
      "type": "subscriptions",
      "amount": 8.0,
      "frequency": "monthly",
      "category": "entertainment"
    },
    {
      "type": "dining_out",
      "amount": 100.0,
      "frequency": "monthly",
      "category": "food"
    }
  ],
  "balance_history": [
    {
      "month": "january",
      "amount": 2000.0,
      "savings_contribution": 0.0
    },
    {
      "month": "february",
      "amount": 2400.0,
      "savings_contribution": 400.0
    },
    {
      "month": "march",
      "amount": 2800.0,
      "savings_contribution": 400.0
    },
    {
      "month": "april",
      "amount": 3300.0,
      "savings_contribution": 500.0
    }
  ],
  "financial_goals": [
    {
      "name": "car",
      "target_amount": 5000.0,
      "current_amount": 0.0,
      "priority": "high"
    }
  ],
  "debts": [
    {
      "type": "laptop",
      "total_amount": 1100.0,
      "remaining_amount": 500.0,
      "interest_rate": 4.5,
      "minimum_payment": 50.0
    },
    {
      "type": "phone",
      "total_amount": 1100.0,
      "remaining_amount": 900.0,
      "interest_rate": 0.0,
      "minimum_payment": 60.0
    }
  ]
};

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String email = 'loading...';
  double totalExpenses = 0.0;

  @override
  void initState() {
    super.initState();
    fetchEmail();
    calculateTotalExpenses();
    //contactClaude();
  }

  void calculateTotalExpenses() {
    setState(() {
      totalExpenses = (inputData['expenses'] as List<dynamic>?)
          ?.fold(0.0, (sum, expense) => (sum ?? 0.0) + (expense['amount'] ?? 0.0)) ?? 0.0;
    });
  }

  Future<void> contactClaude() async {
    final claude = Claude();
    await claude.contact(inputData);
  }

  Future<void> fetchEmail() async {
    final tokenStorage = TokenStorage();
    final fetchedEmail = await tokenStorage.getEmail();
    setState(() {
      if (fetchedEmail == null) {
        email = 'Not found';
        return;
      };
      email = fetchedEmail.split('@')[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    final text = (response as Map<String, dynamic>)['content'][0]['text'] as String;
    final parsedResponse = jsonDecode(text) as Map<String, dynamic>;

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
            onPressed: () => Navigator.pushNamed(context, '/settings'),
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
                  Text(
                    '£${(inputData['balance_history'] as List<Map<
                        String,
                        dynamic>>).last['amount']
                        .toStringAsFixed(2)
                        .replaceAllMapped(
                        RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',')}',
                    style: const TextStyle(
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
                              Text(
                                '£${parsedResponse['forecast_eoy_balance'].toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',')}',
                                style: const TextStyle(
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
                                child: Text(
                                  '${(((inputData['balance_history'] as List<Map<String, dynamic>>).last['amount'] / parsedResponse['forecast_eoy_balance']) * 100).toStringAsFixed(2)}%',
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Expenses',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    Text(
                      '£$totalExpenses',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            ...(inputData['expenses'] as List<Map<String, dynamic>>).map((
                expense) {
              return TransactionItem(
                date: expense['frequency'],
                isDeposit: false,
                title: (expense['type'][0].toUpperCase() + expense['type'].substring(1)).replaceAll('_', ' '),
                amount: expense['amount'],
                iconData: Icons
                    .description, // Replace with logic to map category to icon if needed
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF4F46E5),
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/goals');
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
}