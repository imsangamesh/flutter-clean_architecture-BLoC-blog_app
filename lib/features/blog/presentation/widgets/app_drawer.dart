import 'package:blog_app/core/constants/app_text_styles.dart';
import 'package:blog_app/core/constants/colors.dart';
import 'package:blog_app/core/extensions/extensions.dart';
import 'package:blog_app/core/theme/theme_cubit.dart';
import 'package:blog_app/core/utils/nav_utils.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: BlocBuilder<ThemeCubit, bool>(
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 70),

                /// --------------- `USER INFO`
                Text(context.user!.name, style: AppTStyles.primary),
                const SizedBox(height: 7),
                Text(context.user!.email, style: AppTStyles.midCaption),
                const Spacer(),

                /// -------------------------------- `THEME SWITCH`
                // ListTile(
                //   leading: const Icon(Icons.auto_awesome),
                //   shape: const RoundedRectangleBorder(),
                //   title: Text(
                //     context.isDark ? 'Nightly nights!' : 'Bright lights!',
                //     style: AppTStyles.primary,
                //   ),
                //   trailing: Switch(
                //     value: context.isDark,
                //     onChanged: (_) => context.theme.toggleTheme(),
                //   ),
                // ),

                /// -------------------------------- `LOGOUT`
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSignedOut) {
                      NavUtils.offAll(context, const SignUpScreen());
                    }
                  },
                  child: ListTile(
                    onTap: () =>
                        context.read<AuthBloc>().add(const AuthSignOut()),
                    tileColor: AppColors.danger.withAlpha(50),
                    leading: const Icon(Icons.logout, color: AppColors.danger),
                    shape: const RoundedRectangleBorder(),
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.danger,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
