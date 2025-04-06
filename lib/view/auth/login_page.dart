import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savings_app/view/auth/register_page.dart';
import 'package:savings_app/viewmodel/auth/login_viewmodel.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LoginViewModel>(context);
    final theme = Theme.of(context);

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
                    style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Forecast your savings today!',
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
                  ),

                  const SizedBox(height: 32),
                  TextField(
                    controller: vm.emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: vm.passwordController,
                    obscureText: vm.obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(vm.obscurePassword ? Icons.visibility : Icons.visibility_off),
                        onPressed: vm.togglePasswordVisibility,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton(
                      onPressed: vm.isLoading ? null : () => vm.submitLogin(context),
                      child: vm.isLoading
                          ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                          : const Text('Login'),
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                  child: GestureDetector(
                    child: Text('Get Started here!'),
                    onTap: () => Navigator.pushNamed(context, '/register'),
                  ),)
                ],
              ),
            ),
        ),
      ),
    );
  }
}
