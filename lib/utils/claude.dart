import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Claude {
  final url = Uri.parse('https://api.anthropic.com/v1/messages');

  Future<void> contact() async {
    final inputData = {
      "year": 2025,
      "income": [
        {
          "type": "salary",
          "amount": 24000,
          "frequency": "annual",
          "after_tax": false
        }
      ],
      "expenses": [
        {
          "type": "rent",
          "amount": 765 / 2,
          "frequency": "monthly",
          "category": "housing"
        },
        {
          "type": "groceries",
          "amount": 250,
          "frequency": "monthly",
          "category": "food"
        },
        {
          "type": "utilities",
          "amount": 100 / 2,
          "frequency": "monthly",
          "category": "housing"
        },
        {
          "type": "subscriptions",
          "amount": 16.99 / 2,
          "frequency": "monthly",
          "category": "entertainment"
        },
        {
          "type": "dining_out",
          "amount": 100,
          "frequency": "monthly",
          "category": "food"
        }
      ],
      "balance_history": [
        {
          "month": "january",
          "amount": 2000,
          "savings_contribution": 0
        },
        {
          "month": "february",
          "amount": 2400,
          "savings_contribution": 400
        },
        {
          "month": "march",
          "amount": 2800,
          "savings_contribution": 400
        },
        {
          "month": "april",
          "amount": 3300,
          "savings_contribution": 500
        }
      ],
      "financial_goals": [
        {
          "name": "car",
          "target_amount": 5000,
          "current_amount": 0,
          "priority": "high"
        }
      ],
      "debts": [
        {
          "type": "laptop",
          "total_amount": 1100,
          "remaining_amount": 500,
          "interest_rate": 4.5,
          "minimum_payment": 50
        },
        {
          "type": "phone",
          "total_amount": 1100,
          "remaining_amount": 900,
          "interest_rate": 0,
          "minimum_payment": 60
        }
      ]
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': dotenv.get('ANTHROPIC_API_KEY'),
        'anthropic-version': '2023-06-01'
      },
      body: jsonEncode({
        "model": "claude-3-7-sonnet-20250219",
        "system": "You are a financial analysis assistant. Analyze the financial data provided and return ONLY a JSON object with these fields: 'optimization_message', 'forecast_eoy_balance' and 'expected_goal_dates'",
        "messages": [
          {
            "role": "user",
            "content": "Here is my financial data for analysis: ${jsonEncode(inputData)}"
          }
        ],
        "max_tokens": 1000
      }),
    );

    final res = jsonDecode(response.body);

    print(res);
  }
}