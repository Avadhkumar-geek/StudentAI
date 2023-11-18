part of 'validator_bloc.dart';

abstract class ValidatorState extends Equatable {
  const ValidatorState();
}

class ValidatorInitial extends ValidatorState {
  @override
  List<Object> get props => [];
}

class ValidatorLoading extends ValidatorState {
  @override
  List<Object> get props => [];
}

class ValidatorSuccess extends ValidatorState {
  final String successMessage;

  const ValidatorSuccess({required this.successMessage});

  @override
  List<Object> get props => [successMessage];
}

class ValidatorFailure extends ValidatorState {
  final String error;

  const ValidatorFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class ValidatorStorageAPIFailed extends ValidatorState {
  final String error;

  const ValidatorStorageAPIFailed({required this.error});

  @override
  List<Object> get props => [error];
}
