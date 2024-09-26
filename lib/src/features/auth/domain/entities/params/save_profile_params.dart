import 'package:cinequest/src/features/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

/// Params của SaveProfileUseCase
class SaveProfileParams extends Equatable {
  /// Constructor
  const SaveProfileParams({
    required this.user,
    required this.profilePhoto,
  });

  ///
  final AppUser user;

  ///
  final String profilePhoto;

  @override
  List<Object?> get props => [user, profilePhoto];

  SaveProfileParams copyWith({
    AppUser? user,
    String? profilePhoto,
  }) {
    return SaveProfileParams(
      user: user ?? this.user,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }
}

/// Params
class SaveProfilePhotoParams extends Equatable {
  /// Constructor
  const SaveProfilePhotoParams({
    required this.profilePhoto,
    required this.userId,
  });

  ///
  final String profilePhoto;

  ///
  final String userId;

  @override
  List<Object?> get props => [profilePhoto, userId];
}

/// Params
class SaveProfileUserParams extends Equatable {
  /// Constructor
  const SaveProfileUserParams({
    required this.user,
  });

  ///
  final AppUser user;

  /// CopyWith
  SaveProfileUserParams copyWith({
    AppUser? user,
  }) {
    return SaveProfileUserParams(
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [user];
}
