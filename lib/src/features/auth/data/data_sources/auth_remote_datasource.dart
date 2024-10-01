import 'dart:io';

import 'package:cinequest/src/common/constants/app_keys.dart';
import 'package:cinequest/src/core/errors/exceptions/firebase_network_exception.dart';
import 'package:cinequest/src/core/errors/exceptions/no_internet_exception.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/connectivity_util.dart';
import 'package:cinequest/src/features/auth/data/data_sources/_mappers/user_mapper.dart';
import 'package:cinequest/src/features/auth/data/models/user_model.dart';
import 'package:cinequest/src/features/auth/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Remote DataSource
abstract class AuthRemoteDataSource {
  Future<AppUser> getProfileUser();
  Future<void> saveProfileUser({required AppUser user});
  Future<UserCredential> signUp({
    required String email,
    required String password,
  });
  Future<UserCredential> login({
    required String email,
    required String password,
  });
  Future<UserCredential> signInWithGoogle();
  Future<void> signOut();
  Future<void> verificateCode({required String verificationCode});
  Future<String> saveProfilePhoto({required String profilePhoto});
}

/// Implementation của AuthRemoteDataSource sử dụng Firebase
class AuthFirebaseDataSourceImpl implements AuthRemoteDataSource {
  final _firebaseFirestore = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  final _firebaseStorage = FirebaseStorage.instance;

  final _userMapper = UserMapper();

  @override
  Future<AppUser> getProfileUser() async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        final DocumentSnapshot doc = await _firebaseFirestore
            .collection(usersKey)
            .doc(_firebaseAuth.currentUser?.uid)
            .get();
        if (doc.exists) {
          final model = UserModel.fromJson(doc.data()! as Map<String, dynamic>);
          return _userMapper.modelToEntity(model);
        } else {
          throw Failure(message: 'User not found'.hardcoded);
        }
      } on FirebaseException catch (e) {
        throw Failure(
          message: FirebaseRemoteException.fromFirebaseException(e).message,
          exception: e,
        );
      }
    } else {
      throw Failure(message: NoInternetException.fromException().message);
    }
  }

  @override
  Future<void> saveProfileUser({required AppUser user}) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      final model = _userMapper.entityToModel(user);
      try {
        await _firebaseFirestore
            .collection(usersKey)
            .doc(user.id)
            .set(model.toJson());
      } on FirebaseException catch (e) {
        throw Failure(
          message: FirebaseRemoteException.fromFirebaseException(e).message,
          exception: e,
        );
      }
    } else {
      throw Failure(message: NoInternetException.fromException().message);
    }
  }

  @override
  Future<String> saveProfilePhoto({required String profilePhoto}) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        final ref = _firebaseStorage
            .ref(profilePhotoStorageKey)
            .child(_firebaseAuth.currentUser?.uid ?? '');
        final snapshot = await ref.putFile(File(profilePhoto));
        final downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
      } on FirebaseException catch (e) {
        throw Failure(
          message: FirebaseRemoteException.fromFirebaseException(e).message,
          exception: e,
        );
      }
    } else {
      throw Failure(message: NoInternetException.fromException().message);
    }
  }

  @override
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        await _firebaseAuth.currentUser?.reload();
        return await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } on FirebaseException catch (e) {
        throw Failure(
          message: FirebaseRemoteException.fromFirebaseException(e).message,
          exception: e,
        );
      }
    } else {
      throw Failure(message: NoInternetException.fromException().message);
    }
  }

  @override
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        await _firebaseAuth.currentUser?.reload();
        return await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } on FirebaseException catch (e) {
        throw Failure(
          message: FirebaseRemoteException.fromFirebaseException(e).message,
          exception: e,
        );
      }
    } else {
      throw Failure(message: NoInternetException.fromException().message);
    }
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        await _firebaseAuth.currentUser?.reload();
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser?.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        return await _firebaseAuth.signInWithCredential(credential);
      } on FirebaseException catch (e) {
        throw Failure(
          message: FirebaseRemoteException.fromFirebaseException(e).message,
          exception: e,
        );
      }
    } else {
      throw Failure(message: NoInternetException.fromException().message);
    }
  }

  @override
  Future<void> signOut() async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        await _googleSignIn.signOut();
        await _firebaseAuth.signOut();
      } on FirebaseException catch (e) {
        throw Failure(
          message: FirebaseRemoteException.fromFirebaseException(e).message,
          exception: e,
        );
      }
    } else {
      throw Failure(message: NoInternetException.fromException().message);
    }
  }

  @override
  Future<void> verificateCode({required String verificationCode}) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      await Future<void>.delayed(const Duration(seconds: 3));
      if (verificationCode != '123456') {
        throw Failure(message: 'Verification code not authenticated'.hardcoded);
      }
    } else {
      throw Failure(message: NoInternetException.fromException().message);
    }
  }
}
