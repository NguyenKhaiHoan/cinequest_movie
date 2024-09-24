import 'package:equatable/equatable.dart';

import 'type_def.dart';

abstract class UseCase<Type, Params> {
  FutureEither<Type> call({Params params});
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
