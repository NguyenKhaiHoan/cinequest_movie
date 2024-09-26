import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:equatable/equatable.dart';

/// Base chung cho các remote use case
// ignore: one_member_abstracts
abstract class UseCase<Type, Params> {
  ///
  FutureEither<Type> call({Params params});
}

/// Thay thể cho việc không sử dụng tham số khi truyền vào use case
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
