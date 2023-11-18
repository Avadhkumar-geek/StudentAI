part of 'custom_app_bloc.dart';

abstract class CustomAppEvent extends Equatable {
  const CustomAppEvent();

  @override
  List<Object> get props => [];
}

class CustomAppAddEvent extends CustomAppEvent {
  final String appId;
  final String title;
  final String desc;
  final String prompt;

  const CustomAppAddEvent(
      {required this.appId,
      required this.title,
      required this.desc,
      required this.prompt});

  @override
  List<Object> get props => [appId, title, desc, prompt];
}

class CustomAppEditEvent extends CustomAppEvent {
  final String appId;
  final String title;
  final String desc;
  final String prompt;

  const CustomAppEditEvent(
      {required this.appId,
      required this.title,
      required this.desc,
      required this.prompt});

  @override
  List<Object> get props => [appId, title, desc, prompt];
}

class CustomAppsGetEvent extends CustomAppEvent {}

class CustomAppDeleteEvent extends CustomAppEvent {
  final String appId;

  const CustomAppDeleteEvent({required this.appId});

  @override
  List<Object> get props => [appId];
}

class GetUserDataEvent extends CustomAppEvent {
  @override
  List<Object> get props => [];
}
