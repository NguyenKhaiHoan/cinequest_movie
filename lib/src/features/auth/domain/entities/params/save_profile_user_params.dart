import 'package:equatable/equatable.dart';

import '../user.dart';

class SaveProfileUserParams extends Equatable {
  final AppUser user;
  const SaveProfileUserParams({
    required this.user,
  });

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
