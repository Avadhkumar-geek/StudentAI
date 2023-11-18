part of 'apps_bloc.dart';

enum AppStateStatus { initial, loading, loaded, failed }

class AppsState extends Equatable {
  final List<AppsModel> apps;
  final AppStateStatus status;

  const AppsState({required this.apps, required this.status});

  static AppsState initial() => const AppsState(status: AppStateStatus.initial, apps: []);

  AppsState copyWith({List<AppsModel>? apps, AppStateStatus? status}) =>
      AppsState(apps: apps ?? this.apps, status: status ?? this.status);

  @override
  List<Object?> get props => [apps, status];
}
