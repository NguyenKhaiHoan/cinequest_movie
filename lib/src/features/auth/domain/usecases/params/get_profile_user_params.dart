import 'package:equatable/equatable.dart';

/// Params của GetProfileUserUseCase
class GetProfileUserParams extends Equatable {
  /// Constructor
  const GetProfileUserParams({
    required this.userId,
  });

  ///
  final String userId;

  @override
  List<Object?> get props => [userId];
}
