import 'package:blog_app/core/constants/constants.dart';
import 'package:blog_app/core/errors/exceptions.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

abstract interface class AuthRemoteDataSrc {
  const AuthRemoteDataSrc();

  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> signIn({
    required String email,
    required String password,
  });
  Future<void> signOut();
}

// -------------------------------- CONCRETE CLASS

class AuthRemoteDataSrcImpl implements AuthRemoteDataSrc {
  const AuthRemoteDataSrcImpl({
    required this.fireAuth,
    required this.fire,
    required this.box,
  });

  final FirebaseAuth fireAuth;
  final FirebaseFirestore fire;
  final GetStorage box;

  @override
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await fireAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw const ApiException('User is null, please try again!');
      }

      final userModel = UserModel(
        id: credential.user!.uid,
        email: credential.user!.email ?? email,
        name: name,
      );

      await _updateUserModel(userModel);
      await _storeUser(userModel);

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw ApiException(e.message.toString());
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await fireAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw const ApiException('User is null, please try again!');
      }

      final userModel = await _fetchUserModel(credential.user!.uid);
      if (userModel == null) {
        throw const ApiException("User doesn't exist, Please sign up!");
      }

      await _storeUser(userModel);

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw ApiException(e.message.toString());
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await fireAuth.signOut();
    await box.erase();
  }

  /// ---------------------------------------- `FIRESTORE`

  Future<void> _updateUserModel(UserModel userModel) async {
    await fire
        .collection(FireKeys.users)
        .doc(userModel.id)
        .set(userModel.toMap());
  }

  Future<UserModel?> _fetchUserModel(String uid) async {
    final userSnap = await fire.collection(FireKeys.users).doc(uid).get();
    return userSnap.exists ? UserModel.fromMap(userSnap.data()!) : null;
  }

  /// ---------------------------------------- `GET STORAGE`

  Future<void> _storeUser(UserModel user) async {
    await box.write(BoxKeys.user, user.toMap());
  }
}
