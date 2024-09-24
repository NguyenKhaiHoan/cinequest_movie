import 'package:equatable/equatable.dart';

class GetProfileUserParams extends Equatable {
  final String userId;
  const GetProfileUserParams({
    required this.userId,
  });

  @override
  List<Object?> get props => [userId];
}
