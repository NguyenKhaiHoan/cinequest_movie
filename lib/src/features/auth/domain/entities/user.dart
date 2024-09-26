import 'package:equatable/equatable.dart';

/// User entity
class AppUser extends Equatable {
  /// Constructor
  const AppUser({
    required this.id,
    required this.profilePhoto,
    required this.email,
    required this.username,
    required this.name,
    required this.surname,
    required this.createdAt,
    required this.authBy,
  });

  ///
  final String id;

  ///
  final String profilePhoto;

  ///
  final String email;

  ///
  final String username;

  ///
  final String name;

  ///
  final String surname;

  ///
  final DateTime createdAt;

  ///
  final String authBy;

  @override
  List<Object?> get props => [
        id,
        profilePhoto,
        email,
        username,
        name,
        surname,
        createdAt,
        authBy,
      ];

  AppUser copyWith({
    String? id,
    String? profilePhoto,
    String? email,
    String? username,
    String? name,
    String? surname,
    DateTime? createdAt,
    String? authBy,
  }) {
    return AppUser(
      id: id ?? this.id,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      email: email ?? this.email,
      username: username ?? this.username,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      createdAt: createdAt ?? this.createdAt,
      authBy: authBy ?? this.authBy,
    );
  }
}
