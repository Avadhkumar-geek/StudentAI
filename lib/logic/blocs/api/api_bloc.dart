import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_ai/data/constants/globals.dart';

import 'package:student_ai/data/repositories/ai_model_repo.dart';

part 'api_event.dart';
part 'api_state.dart';

class APIBloc extends Bloc<APIEvent, APIState> {
  final AIModelRepo aiModelRepo;

  APIBloc({required this.aiModelRepo}) : super(APIInitState()) {
    on<APIRequestEvent>(_apiRequest);
  }

  _apiRequest(APIRequestEvent event, Emitter<APIState> emit) async {
    try {
      emit(APIRequestState(query: event.query));

      final response = await aiModelRepo.apiRequest(apiKey!, event.query);

      emit(APISuccessState(response: response));
    } catch (e) {
      emit(APIFailedState(error: e.toString()));
    }
  }
}
