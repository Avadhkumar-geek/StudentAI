part of 'app_metadata_bloc.dart';

abstract class AppMetadataEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAppMetadataEvent extends AppMetadataEvent {
  final String id;

  GetAppMetadataEvent({required this.id});

  @override
  List<Object?> get props => [];
}
