import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_ai/data/models/apps_metadata_model.dart';
import 'package:student_ai/data/repositories/studentai_api_repo.dart';

part 'app_metadata_event.dart';
part 'app_metadata_state.dart';

class AppMetadataBloc extends Bloc<AppMetadataEvent, AppMetadataState> {
  final StudentAiApiRepo studentAiRepo;

  AppMetadataBloc({required this.studentAiRepo}) : super(AppMetadataInitial()) {
    on<GetAppMetadataEvent>(_getAppMetadata);
  }

  _getAppMetadata(
      GetAppMetadataEvent event, Emitter<AppMetadataState> emit) async {
    try {
      log("Appmetadata loading...");
      emit(AppMetadataLoading());

      final AppMetadataModel metadata =
          await StudentAiApiRepo.getAppsMetadata(id: event.id);

      log("Appmetadata loaded...");
      emit(AppMetadataLoaded(metadata: metadata));
    } catch (e) {
      emit(AppMetadataFailed());
    }
  }
}
