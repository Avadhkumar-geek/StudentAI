import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_ai/data/constants/globals.dart';
import 'package:student_ai/data/repositories/ai_model_repo.dart';

part 'validator_event.dart';
part 'validator_state.dart';

class ValidatorBloc extends Bloc<ValidatorEvent, ValidatorState> {
  final AIModelRepo aiModelRepo;

  ValidatorBloc({required this.aiModelRepo}) : super(ValidatorInitial()) {
    on<ValidateAPIKey>(_validateAPIKey);
    on<ValidateAPIKeyFromStorage>(_validateAPIKeyFromStorage);
    on<ResetAPIKey>(_resetAPIKey);
  }

  _validateAPIKey(ValidateAPIKey event, Emitter<ValidatorState> emit) async {
    try {
      emit(ValidatorLoading());
      await aiModelRepo.apiRequest(event.apiKey, 'say hi');
      emit(const ValidatorSuccess(successMessage: 'API Key is validated successfully'));
      apiKey = event.apiKey;
      isAPIValidated = true;

      // Save API key to storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("apiKey", apiKey!);
      prefs.setBool("isAPIValidated", isAPIValidated);
    } catch (e) {
      log(e.toString());
      emit(const ValidatorFailure(error: 'Invalid API key!!'));
    }
  }

  _validateAPIKeyFromStorage(ValidateAPIKeyFromStorage event, Emitter<ValidatorState> emit) async {
    try {
      emit(ValidatorLoading());
      log('Validating from storage');
      // Get API key from storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      apiKey = prefs.getString("apiKey");
      isAPIValidated = prefs.getBool("isAPIValidated")!;

      if (isAPIValidated) {
        log('valid API key in storage');
        emit(const ValidatorSuccess(successMessage: 'API Key is validated successfully!!'));
      } else {
        log('not valid API key in storage');
        emit(const ValidatorStorageAPIFailed(error: 'Enter a valid API key!!'));
      }
    } catch (e) {
      log(e.toString());
      emit(const ValidatorStorageAPIFailed(error: 'Enter a valid API key!!'));
    }
  }

  _resetAPIKey(ResetAPIKey event, Emitter<ValidatorState> emit) async {
    try {
      emit(ValidatorLoading());
      apiKey = '';
      isAPIValidated = false;

      // Delete API key from storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("apiKey");
      prefs.remove("isAPIValidated");

      emit(const ValidatorSuccess(successMessage: 'API Key is reset successfully!!'));
    } catch (e) {
      log(e.toString());
      emit(const ValidatorFailure(error: 'Error in resetting key!!'));
    }
  }
}
