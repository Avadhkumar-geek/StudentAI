
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_ai/data/models/chat_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final List<ChatModel> _msgs = [];

  ChatBloc() : super(ChatState.initial()) {
    on<SendUsrMsgEvent>(_sendMsg);
    on<GetAIMsgEvent>(_getAIMsg);
    on<ChatClearEvent>(_clearChat);
  }

  List<ChatModel> get msgs => _msgs;

  _sendMsg(SendUsrMsgEvent event, Emitter<ChatState> emit) {
    emit(state.copyWith(status: ChatStatus.loading));
    msgs.insert(0, ChatModel(text: event.msg, sender: ChatSender.user));
    emit(state.copyWith(status: ChatStatus.loaded, msgs: msgs));
  }

  _getAIMsg(GetAIMsgEvent event, Emitter<ChatState> emit) {
    emit(state.copyWith(status: ChatStatus.loading));
    msgs.insert(0, ChatModel(text: event.msg, sender: ChatSender.ai));
    emit(state.copyWith(status: ChatStatus.loaded, msgs: msgs));
  }

  _clearChat(ChatClearEvent event, Emitter<ChatState> emit) {
    msgs.clear();
    emit(state.copyWith(status: ChatStatus.cleared, msgs: msgs));
  }
}
