part of 'apps_bloc.dart';

abstract class AppsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppsGetEvent extends AppsEvent {
  final int? limit;
  final String? query;
  final int? page;

  AppsGetEvent({this.limit, this.query, this.page});

  @override
  List<Object?> get props => [];
}
