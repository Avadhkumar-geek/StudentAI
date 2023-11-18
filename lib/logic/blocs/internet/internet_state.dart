part of 'internet_bloc.dart';

enum Connection { on, off }

abstract class InternetState extends Equatable {
  const InternetState();
}

class InternetLoadingState extends InternetState {
  @override
  List<Object> get props => [];
}

class InternetConnectedState extends InternetState {
  final Connection connectionType;

  const InternetConnectedState(this.connectionType);

  @override
  List<Object> get props => [connectionType];
}

class InternetDisconnectedState extends InternetState {
  @override
  List<Object> get props => [];
}
