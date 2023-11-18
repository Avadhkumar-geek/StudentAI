import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_ai/data/models/apps_model.dart';

import '../../../data/repositories/studentai_api_repo.dart';

part 'apps_event.dart';
part 'apps_state.dart';

mixin HomeBloc on Bloc<AppsEvent, AppsState> {}

mixin SearchBloc on Bloc<AppsEvent, AppsState> {}

class AppsBloc extends Bloc<AppsEvent, AppsState> with HomeBloc, SearchBloc {
  final StudentAiApiRepo studentAiApiRepo;
  final List<AppsModel> _apps = [];

  List<AppsModel> get apps => _apps;

  AppsBloc({required this.studentAiApiRepo}) : super(AppsState.initial()) {
    on<AppsGetEvent>(_getApps);
  }

  _getApps(AppsGetEvent event, Emitter<AppsState> emit) async {
    try {
      emit(state.copyWith(status: AppStateStatus.loading));

      List<AppsModel> data =
          await StudentAiApiRepo.getApps(limit: event.limit, query: event.query, page: event.page);

      if (data.isEmpty && apps.isNotEmpty) {
        emit(state.copyWith(apps: apps, status: AppStateStatus.loaded));
      } else if (data.isEmpty && apps.isEmpty) {
        apps.addAll(data);
        emit(state.copyWith(apps: apps, status: AppStateStatus.loaded));
      } else {
        apps.clear();
        apps.addAll(data);
        emit(state.copyWith(apps: apps, status: AppStateStatus.loaded));
      }
    } catch (e) {
      emit(state.copyWith(status: AppStateStatus.failed));
    }
  }
}
