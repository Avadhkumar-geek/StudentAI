part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendUsrMsgEvent extends ChatEvent {
  final String msg;

  SendUsrMsgEvent({required this.msg});

  @override
  List<Object?> get props => [msg];
}

class GetAIMsgEvent extends ChatEvent {
  final String msg;

  GetAIMsgEvent({required this.msg});

  @override
  List<Object?> get props => [msg];
}

class ChatClearEvent extends ChatEvent {
  @override
  List<Object?> get props => [];
}
