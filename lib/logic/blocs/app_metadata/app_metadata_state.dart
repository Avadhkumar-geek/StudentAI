part of 'app_metadata_bloc.dart';

abstract class AppMetadataState extends Equatable {
  const AppMetadataState();
}

class AppMetadataInitial extends AppMetadataState {
  @override
  List<Object> get props => [];
}

class AppMetadataLoading extends AppMetadataState {
  @override
  List<Object> get props => [];
}

class AppMetadataLoaded extends AppMetadataState {
  final AppMetadataModel metadata;

  const AppMetadataLoaded({required this.metadata});

  @override
  List<Object> get props => [];
}

class AppMetadataFailed extends AppMetadataState {
  @override
  List<Object> get props => [];
}
