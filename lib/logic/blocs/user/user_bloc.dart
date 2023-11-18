import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_ai/data/models/user_model.dart';

import '../../../data/repositories/user_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepo userRepo;

  UserBloc({required this.userRepo}) : super(UserInitial()) {
    on<GetUserEvent>(_getUser);
    on<UpdateUserEvent>(_updateUser);
  }

  UserModel userData = UserModel(
      displayName: '', email: '', photoURL: '', uid: '', customApps: []);

  _getUser(GetUserEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());

      userData = await userRepo.getUserData();

      emit(UserSuccessState(userData: userData));
    } catch (e) {
      log(e.toString());
      emit(UserErrorState(message: e.toString()));
    }
  }

  _updateUser(UpdateUserEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      userRepo.updateUser(event.displayName);

      userData = await userRepo.getUserData();

      emit(UserUpdatedState());
      emit(UserSuccessState(userData: userData));
    } catch (e) {
      log(e.toString());
      emit(UserErrorState(message: e.toString()));
    }
  }
}
