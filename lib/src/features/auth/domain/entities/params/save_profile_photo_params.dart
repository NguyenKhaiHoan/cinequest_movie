import 'package:equatable/equatable.dart';

class SaveProfilePhotoParams extends Equatable {
  final String profilePhoto;
  final String userId;
  const SaveProfilePhotoParams({
    required this.profilePhoto,
    required this.userId,
  });

  @override
  List<Object?> get props => [profilePhoto, userId];
}
