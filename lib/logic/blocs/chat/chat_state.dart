part of 'chat_bloc.dart';

enum ChatStatus {
  initial,
  loading,
  loaded,
  cleared,
  error,
}

class ChatState extends Equatable {
  final List<ChatModel>? msgs;
  final ChatStatus status;

  const ChatState({required this.status, required this.msgs});

  static ChatState initial() =>
      const ChatState(status: ChatStatus.initial, msgs: []);

  ChatState copyWith({ChatStatus? status, List<ChatModel>? msgs}) => ChatState(
        status: status ?? this.status,
        msgs: msgs ?? this.msgs,
      );

  @override
  List<Object?> get props => [status, msgs];
}
