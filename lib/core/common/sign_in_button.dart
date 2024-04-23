// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:blog_app/core/constants/constants.dart';
// import 'package:blog_app/featuress/auth/controller/auth_controller.dart';
// import 'package:blog_app/theme/pallete.dart';

// class SignInButton extends ConsumerWidget {
//   const SignInButton({this.isFromLogin = true, super.key});

//   final bool isFromLogin;

//   Future<void> signInWithGoogle(BuildContext context, WidgetRef ref) async {
//     await ref
//         .read(authControllerProvider.notifier)
//         .signInWithGoogle(context, isFromLogin: isFromLogin);
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ElevatedButton.icon(
//       onPressed: () => signInWithGoogle(context, ref),
//       icon: Image.asset(Constants.googlePath, width: 35),
//       label: const Text(
//         'Continue with Google',
//         style: TextStyle(fontSize: 18),
//       ),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Pallete.greyColor,
//         minimumSize: const Size(double.infinity, 50),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       ),
//     );
//   }
// }
