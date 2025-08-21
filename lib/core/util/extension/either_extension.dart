import 'package:dartz/dartz.dart';

extension EitherX<Left, Right> on Either<Left, Right> {
  Left? leftOrNull() => fold((left) => left, (_) => null);

  Right? rightOrNull() => fold((_) => null, (right) => right);
}
