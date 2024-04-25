import 'package:blog_app/core/common/widgets/buttons.dart';
import 'package:blog_app/core/common/widgets/custom_textfield.dart';
import 'package:blog_app/core/constants/app_text_styles.dart';
import 'package:blog_app/core/extensions/extensions.dart';
import 'package:blog_app/core/utils/nav_utils.dart';
import 'package:blog_app/core/utils/utils.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:blog_app/features/blog/presentation/screens/blogs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //
  final nameCntr = TextEditingController();
  final emailCntr = TextEditingController();
  final passwordCntr = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isObscure = true;

  @override
  void dispose() {
    nameCntr.dispose();
    emailCntr.dispose();
    passwordCntr.dispose();
    super.dispose();
  }

  void signUp(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthSignUp(
              name: nameCntr.text.trim(),
              email: emailCntr.text.trim(),
              password: passwordCntr.text.trim(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (_, state) {
        if (state is AuthFailure) {
          Utils.showSnackbar(context, state.message);
        }
        if (state is AuthSuccess) {
          NavUtils.to(context, const BlogsScreen());
          Utils.showSnackbar(context, 'Sign Up successful!');
        }
      },
      builder: (_, state) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Sign Up', style: AppTStyles.large),
                    const SizedBox(height: 20),

                    /// -------------------- `NAME`
                    AppTextField(nameCntr, 'Name'),

                    /// -------------------- `EMAIL`
                    AppTextField(
                      emailCntr,
                      'Email',
                      inputType: TextInputType.emailAddress,
                    ),

                    /// -------------------- `PASSWORD`
                    StatefulBuilder(
                      builder: (_, setValue) {
                        return AppTextField(
                          passwordCntr,
                          'Password',
                          isObscure: isObscure,
                          suffixIcon: isObscure
                              ? Icons.visibility
                              : Icons.visibility_off,
                          suffixFun: () =>
                              setValue(() => isObscure = !isObscure),
                        );
                      },
                    ),

                    /// -------------------- `SUBMIT BUTTON`
                    SizedBox(
                      width: context.w,
                      child: LoadingButton.elevated(
                        'Sign Up',
                        () => signUp(context),
                        isLoading: state is AuthLoading,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: AppTStyles.caption,
                        ),
                        TextButton(
                          onPressed: () => NavUtils.to(
                            context,
                            const SignInScreen(),
                          ),
                          child: const Text('Sign In'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
