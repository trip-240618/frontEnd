import 'package:dartz/dartz.dart';

import '../errors/failure.dart';

typedef Result<T> = Either<Failure, T>;
typedef ResultFuture<T> = Future<Result<T>>;
typedef ResultVoid = ResultFuture<void>;
