import 'dart:developer';

import 'package:blog_app/core/apis/storage_api_provider.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/core/theme/theme_cubit.dart';
import 'package:blog_app/features/auth/data/data_sources/auth_remote_data_src.dart';
import 'package:blog_app/features/auth/data/repo/auth_repo_impl.dart';
import 'package:blog_app/features/auth/domain/repo/auth_repo.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_in.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_out.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/data/data_sources/blog_local_data_src.dart';
import 'package:blog_app/features/blog/data/data_sources/blog_remote_data_src.dart';
import 'package:blog_app/features/blog/data/repo/blog_repo_impl.dart';
import 'package:blog_app/features/blog/domain/repo/blog_repo.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

final sl = GetIt.instance;

final slFireAuth = sl<FirebaseAuth>();
final slTheme = sl<ThemeCubit>();
final slAuth = sl<AuthBloc>();

Future<void> init() async {
  // External Dependencies
  sl
    ..registerLazySingleton(() => FirebaseAuth.instance) // Firebase Auth
    ..registerLazySingleton(() => FirebaseFirestore.instance) // Firestore
    ..registerLazySingleton(() => FirebaseStorage.instance) // Fire Storage
    ..registerLazySingleton(GetStorage.new) // GetStorage
    ..registerLazySingleton(Uuid.new) // Uuid
    ..registerLazySingleton(Connectivity.new) // Connectivity

    // Internal Dependencies
    ..registerLazySingleton(
      () => FireStorageApi(firebaseStorage: sl()),
    )
    ..registerLazySingleton<ConnectionChecker>(
      () => ConnectionCheckerImpl(sl()),
    );

  await _initAuth();
  await _initTheme();
  await _initBlog();
}

Future<void> _initAuth() async {
  sl
    // Bloc
    ..registerFactory(
      () => AuthBloc(signUp: sl(), signIn: sl(), signOut: sl(), box: sl()),
    )
    // Usecases
    ..registerLazySingleton(() => SignUp(sl()))
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(() => SignOut(sl()))
    // Repository
    ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()))
    // DataSource
    ..registerLazySingleton<AuthRemoteDataSrc>(
      () => AuthRemoteDataSrcImpl(fire: sl(), fireAuth: sl(), box: sl()),
    );

  log(' - - - - - - AUTH dependencies injected! - - - - - - ');
}

Future<void> _initBlog() async {
  sl
    // Bloc
    ..registerFactory(
      () => BlogBloc(uploadBlog: sl(), getAllBlogs: sl()),
    )
    // Usecases
    ..registerLazySingleton(() => UploadBlog(sl()))
    ..registerLazySingleton(() => GetAllBlogs(sl()))
    // Repository
    ..registerLazySingleton<BlogRepo>(
      () => BlogRepoImpl(
        remoteDataSrc: sl(),
        uuid: sl(),
        checker: sl(),
        localDataSrc: sl(),
      ),
    )
    // DataSource
    ..registerLazySingleton<BlogRemoteDataSrc>(
      () => BlogRemoteDataSrcImpl(fire: sl(), storageApi: sl()),
    )
    ..registerLazySingleton<BlogLocalDataSrc>(
      () => BlogLocalDataSrcImpl(sl()),
    );

  log(' - - - - - - BLOG dependencies injected! - - - - - - ');
}

Future<void> _initTheme() async {
  sl.registerFactory(() => ThemeCubit(sl()));
  log(' - - - - - - THEME dependency injected! - - - - - - ');
}
