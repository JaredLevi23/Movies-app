import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errorMessage;

  const Failure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

/// General failures
class GeneralFailure extends Failure {
  const GeneralFailure(String errorMessage)
    : super( errorMessage );
}
