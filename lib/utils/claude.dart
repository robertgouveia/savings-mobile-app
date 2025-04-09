import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Claude {
  final url = Uri.parse('https://api.anthropic.com/v1/messages');

  Future<void> contact(dynamic inputData) async {
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