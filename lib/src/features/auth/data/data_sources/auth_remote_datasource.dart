// ignore_for_file: public_member_api_docs, sort_constructors_first
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
import 'package:cinequest/src/features/auth/domain/usecases/params/auth_params.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/get_profile_user_params.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/save_profile_params.dart';
import 'package:cinequest/src/features/auth/domain/usecases/params/verification_code_params.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Remote DataSource
abstract class AuthRemoteDataSource {
  Future<AppUser> getProfileUser(GetProfileUserParams params);
  Future<void> saveProfileUser(SaveProfileUserParams params);
  Future<UserCredential> signUp(AuthParams params);
  Future<UserCredential> login(AuthParams params);
  Future<UserCredential> signInWithGoogle();
  Future<void> signOut();
  Future<void> verificateCode(VerificateCodeParams params);
  Future<String> saveProfilePhoto(SaveProfilePhotoParams params);
}

/// Implementation của AuthRemoteDataSource sử dụng Firebase
class AuthFirebaseDataSourceImpl implements AuthRemoteDataSource {
  final _firebaseFirestore = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  final _firebaseStorage = FirebaseStorage.instance;

  final _userMapper = UserMapper();

  @override
  Future<AppUser> getProfileUser(GetProfileUserParams params) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        final DocumentSnapshot doc = await _firebaseFirestore
            .collection(usersKey)
            .doc(params.userId)
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
  Future<void> saveProfileUser(SaveProfileUserParams params) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      final model = _userMapper.entityToDto(params.user);
      try {
        await _firebaseFirestore
            .collection(usersKey)
            .doc(model.id)
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
  Future<String> saveProfilePhoto(SaveProfilePhotoParams params) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        final ref =
            _firebaseStorage.ref(profilePhotoStorageKey).child(params.userId);
        final snapshot = await ref.putFile(File(params.profilePhoto));
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
  Future<UserCredential> signUp(AuthParams params) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        await _firebaseAuth.currentUser?.reload();
        return await _firebaseAuth.createUserWithEmailAndPassword(
          email: params.email,
          password: params.password,
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
  Future<UserCredential> login(AuthParams params) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        await _firebaseAuth.currentUser?.reload();
        return await _firebaseAuth.signInWithEmailAndPassword(
          email: params.email,
          password: params.password,
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
  Future<void> verificateCode(VerificateCodeParams params) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      await Future<void>.delayed(const Duration(seconds: 3));
      if (params.verificationCode != '123456') {
        throw Failure(message: 'Verification code not authenticated'.hardcoded);
      }
    } else {
      throw Failure(message: NoInternetException.fromException().message);
    }
  }
}
