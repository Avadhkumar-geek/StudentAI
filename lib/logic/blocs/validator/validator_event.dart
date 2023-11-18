part of 'validator_bloc.dart';

abstract class ValidatorEvent extends Equatable {
  const ValidatorEvent();
}

class ValidateAPIKey extends ValidatorEvent {
  final String apiKey;

  const ValidateAPIKey({required this.apiKey});

  @override
  List<Object> get props => [apiKey];
}

class ValidateAPIKeyFromStorage extends ValidatorEvent {
  @override
  List<Object> get props => [];
}

class ResetAPIKey extends ValidatorEvent {
  @override
  List<Object> get props => [];
}
