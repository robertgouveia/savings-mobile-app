import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savings_app/viewmodel/auth/verification_viewmodel.dart';

class VerificationPage extends StatelessWidget {
  final String email;

  const VerificationPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final theme = Theme.of(context);
    final vm = Provider.of<VerificationViewModel>(context);
    final email = arguments?['email'] ?? '';

    return ChangeNotifierProvider(
      create: (_) {
        final vm = VerificationViewModel();
        vm.setEmail(email);
        return vm;
      },
      child: Consumer<VerificationViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Savings App',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enter the verification code sent to $email.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.hintColor,
                        ),
                      ),

                      const SizedBox(height: 20),
                      // Verification Code input fields
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(6, (index) {
                          return SizedBox(
                            width: 40,
                            child: TextField(
                              controller: vm.codeControllers[index],
                              decoration: const InputDecoration(
                                counterText: '',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              onChanged: (value) {
                                if (value.isNotEmpty && index < 5) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: FilledButton(
                          onPressed: () => vm.submitVerification(context),
                          child:
                          vm.isLoading
                              ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                              : const Text('Verify Code'),
                        ),
                      ),

                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 0,
                        ),
                        child: GestureDetector(
                          child: Text(
                            'Did not receive a code? Resend',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
