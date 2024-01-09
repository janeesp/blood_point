import 'package:fpdart/fpdart.dart';
import 'Faillure.dart';


typedef FutureEither<T> = Future<Either<Failure,T>>;
typedef FutureVoid=FutureEither<void>;
