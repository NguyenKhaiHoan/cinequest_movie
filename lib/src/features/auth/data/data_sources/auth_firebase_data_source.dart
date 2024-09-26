import 'package:cinequest/src/core/errors/exceptions/firebase_network_exception.dart';
import 'package:cinequest/src/core/errors/exceptions/no_internet_exception.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/utils/connectivity_util.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/auth_params.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/verification_code_params.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Sử dụng FirebaseAuth
abstract class AuthFirebaseDataSource {
  ///
  Future<UserCredential> signUp(AuthParams params);

  ///
  Future<UserCredential> login(AuthParams params);

  ///
  Future<UserCredential> signInWithGoogle();

  ///
  Future<void> signOut();

  ///
  Future<void> verificateCode(VerificationCodeParams params);
}

/// Implementation của AuthFirebaseDataSource
class AuthFirebaseDataSourceImpl implements AuthFirebaseDataSource {
  /// Constructor
  AuthFirebaseDataSourceImpl({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn;
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

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
          message: FirebaseNetworkException.fromFirebaseException(e).message,
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
          message: FirebaseNetworkException.fromFirebaseException(e).message,
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
          message: FirebaseNetworkException.fromFirebaseException(e).message,
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
          message: FirebaseNetworkException.fromFirebaseException(e).message,
        );
      }
    } else {
      throw Failure(message: NoInternetException.fromException().message);
    }
  }

  @override
  Future<void> verificateCode(VerificationCodeParams params) async {
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
