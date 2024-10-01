import 'package:cinequest/src/features/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

/// Params của SaveProfileUserUseCase, ...
class ProfileParams extends Equatable {
  /// Constructor
  const ProfileParams({
    required this.user,
    required this.profilePhoto,
  });

  final AppUser user;
  final String profilePhoto;

  @override
  List<Object?> get props => [user, profilePhoto];

  ProfileParams copyWith({
    AppUser? user,
    String? profilePhoto,
  }) {
    return ProfileParams(
      user: user ?? this.user,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }
}
