import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/core/app/application/app_controller.dart';
import 'package:tracker_app/core/app/infrastructure/app_state.dart';
import 'package:tracker_app/core/extension/context_extension.dart';
import 'package:tracker_app/core/utils/validators.dart';
import 'package:tracker_app/core/widgets/custom_button.dart';
import 'package:tracker_app/core/widgets/custom_textfield.dart';
import 'package:tracker_app/features/auth/presentation/signin_screen.dart';
import 'package:tracker_app/features/user/domain/app_user.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //listen signup provider to show error
    ref.listen(signUpProvider, (prev, next) {
      if (next is AsyncError) {
        context.showSnackBar(message: '${next.error}');
      }
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            ref.read(appNotifierProvider.notifier).updateAppState(
                  const AppState.unAuthenticated(isSignIn: true),
                );
          },
          icon: const Icon(Icons.chevron_left_outlined),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please enter your details',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _nameController,
                  hintText: 'Full Name',
                  validator: Validators.requiredFieldValidators,
                ),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  validator: Validators.emailValidator,
                ),
                // CustomTextField(
                //   controller: _addressController,
                //   hintText: 'Address',
                // ),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  validator: Validators.passwordValidators,
                ),
                Consumer(builder: (context, ref, child) {
                  final authState = ref.watch(signUpProvider);
                  return CustomButton(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    onPressed: _onSignUp,
                    name: 'Sign up',
                    isLoading: authState is AsyncLoading,
                  );
                }),
                const _SignInNavigationWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSignUp() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final registeredUser = AppUser(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );
    ref.read(signUpProvider.notifier).signup(
          appUser: registeredUser,
        );
  }
}

class _SignInNavigationWidget extends ConsumerWidget {
  const _SignInNavigationWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
        ),
        InkWell(
          onTap: () {
            ref
                .read(appNotifierProvider.notifier)
                .updateAppState(const AppState.unAuthenticated(isSignIn: true));
          },
          child: Text(
            'Sign In',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}
