import 'package:blog_app/core/services/injection_container.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/core/theme/theme_cubit.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/screens/blogs_screen.dart';
import 'package:blog_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await init();

  final isAuthenticated = slAuth.user != null && slFireAuth.currentUser != null;
  runApp(MyApp(isAuthenticated: isAuthenticated));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.isAuthenticated, super.key});

  final bool isAuthenticated;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ThemeCubit>()),
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<BlogBloc>()),
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Blog App',
            theme: AppTheme.light(context),
            darkTheme: AppTheme.light(context),
            themeMode: slTheme.mode,
            home: isAuthenticated ? const BlogsScreen() : const SignUpScreen(),
          );
        },
      ),
    );
  }
}

/*

- snackbars
- Loading icon buttons + all buttons (AppElev) 
- replace icon button in add_blog
- validators for textfields
- error theme of textfields
- error text widget in helper_widgets

*/
