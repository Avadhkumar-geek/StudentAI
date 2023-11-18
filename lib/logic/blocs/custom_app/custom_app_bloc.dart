import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_ai/data/models/custom_app_model.dart';
import 'package:student_ai/data/repositories/user_repo.dart';

part 'custom_app_event.dart';
part 'custom_app_state.dart';

class CustomAppsBloc extends Bloc<CustomAppEvent, CustomAppState> {
  final UserRepo userRepo;

  CustomAppsBloc({required this.userRepo}) : super(CustomAppStateInitial()) {
    on<CustomAppAddEvent>(_addCustomApp);
    on<CustomAppsGetEvent>(_getCustomApps);
    on<CustomAppDeleteEvent>(_deleteCustomApp);
    on<CustomAppEditEvent>(_editCustomApp);
  }

  _addCustomApp(CustomAppAddEvent event, Emitter<CustomAppState> emit) async {
    try {
      emit(CustomAppStateLoading());

      await userRepo.addCustomApp(CustomAppModel(
          appId: event.appId,
          title: event.title,
          desc: event.desc,
          prompt: event.prompt));

      final apps = await UserRepo.getCustomApps();

      emit(CustomAppStateLoaded(apps: apps));
    } catch (e) {
      emit(CustomAppStateFailed());
    }
  }

  _editCustomApp(CustomAppEditEvent event, Emitter<CustomAppState> emit) async {
    try {
      emit(CustomAppStateLoading());

      final updatedApp = CustomAppModel(
        appId: event.appId,
        title: event.title,
        desc: event.desc,
        prompt: event.prompt,
      );
      List<CustomAppModel> apps = [];
      await userRepo
          .editCustomApp(updatedApp)
          .then((value) async => apps = await UserRepo.getCustomApps());

      emit(CustomAppStateLoaded(apps: apps));
    } catch (e) {
      emit(CustomAppStateFailed(error: e.toString()));
    }
  }

  _getCustomApps(CustomAppsGetEvent event, Emitter<CustomAppState> emit) async {
    try {
      log("Getting apps");
      emit(CustomAppStateLoading());

      final apps = await UserRepo.getCustomApps();

      emit(CustomAppStateLoaded(apps: apps));
    } catch (e) {
      emit(CustomAppStateFailed());
    }
  }

  _deleteCustomApp(
      CustomAppDeleteEvent event, Emitter<CustomAppState> emit) async {
    try {
      emit(CustomAppStateLoading());

      await userRepo.deleteCustomApp(event.appId);

      final apps = await UserRepo.getCustomApps();
      emit(CustomAppStateLoaded(apps: apps));
    } catch (e) {
      emit(CustomAppStateFailed());
    }
  }
}
