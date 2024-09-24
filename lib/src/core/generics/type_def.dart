import 'package:dartz/dartz.dart';

import '../errors/failure.dart';

typedef FutureEither<Type> = Future<Either<Failure, Type>>;
