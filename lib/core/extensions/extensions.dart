import 'package:blog_app/core/theme/theme_cubit.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension ContextExt on BuildContext {
  MediaQueryData get media => MediaQuery.of(this);
  Size get size => media.size;

  double get h => size.height;
  double get w => size.width;

  // ------------------- BLoC Getters
  bool get isDark => read<ThemeCubit>().isDark;

  ThemeCubit get theme => read<ThemeCubit>();
  UserModel? get user => read<AuthBloc>().user;
}
