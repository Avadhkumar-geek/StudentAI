
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_ai/data/models/user_model.dart';
import 'package:student_ai/data/repositories/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;

  AuthBloc({required this.authRepo}) : super(DeAuth()) {
    on<AppStarted>(_appStartedEvent);
    on<LogInEvent>(_logInEvent);
    on<LogOutEvent>(_logOutEvent);
  }

  _appStartedEvent(AppStarted event, Emitter<AuthState> emit) async {
    try {
      final isSignedIn = await authRepo.isSignedIn();
      if (isSignedIn) emit(AuthSuccess(user: await authRepo.getUser()));
    } catch (e) {
      emit(AuthFail(errMsg: e.toString()));
      emit(DeAuth());
    }
  }

  _logInEvent(LogInEvent event, Emitter<AuthState> emit) async {
    emit(AuthInit());

    try {
      await authRepo.logInWithGoogle();
      emit(AuthSuccess(user: await authRepo.getUser()));
    } catch (e) {
      emit(AuthFail(errMsg: e.toString()));
      emit(DeAuth());
    }
  }

  _logOutEvent(LogOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthInit());
    await authRepo.logOut();
    emit(DeAuth());
  }
}
