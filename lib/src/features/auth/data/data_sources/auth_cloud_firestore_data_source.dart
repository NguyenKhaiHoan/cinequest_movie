import 'package:cinequest/src/core/errors/exceptions/firebase_network_exception.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/features/auth/data/data_sources/_mapper/user_mapper.dart';
import 'package:cinequest/src/features/auth/domain/entities/params/get_profile_user_params.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/params/save_profile_user_params.dart';
import '../../domain/entities/user.dart';
import '../models/user_dto.dart';

abstract class AuthCloudFirestoreDataSource {
  Future<AppUser> getProfileUser(GetProfileUserParams params);
  Future<void> saveProfileUser(SaveProfileUserParams params);
}

class AuthCloudFirestoreDataSourceImpl implements AuthCloudFirestoreDataSource {
  final FirebaseFirestore _firestore;
  AuthCloudFirestoreDataSourceImpl({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final _userMapper = UserMapper();

  @override
  Future<AppUser> getProfileUser(GetProfileUserParams params) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('Users').doc(params.userId).get();
      if (doc.exists) {
        final userDto = UserDto.fromJson(doc.data() as Map<String, dynamic>);
        return _userMapper.dtoToEntity(userDto);
      } else {
        throw Failure(message: 'User not found');
      }
    } on FirebaseException catch (e) {
      throw Failure(
          message: FirebaseNetworkException.fromFirebaseException(e).message);
    }
  }

  @override
  Future<void> saveProfileUser(SaveProfileUserParams params) async {
    final userDto = _userMapper.entityToDto(params.user);
    try {
      await _firestore
          .collection('Users')
          .doc(userDto.id)
          .set(userDto.toJson());
    } on FirebaseException catch (e) {
      throw Failure(
          message: FirebaseNetworkException.fromFirebaseException(e).message);
    }
  }
}
