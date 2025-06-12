import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/message_model.dart';
import '../repositories/dialogflow_repository.dart';

abstract class ChatEvent {}

class SendMessageEvent extends ChatEvent {
  final String userMessage;
  SendMessageEvent(this.userMessage);
}

abstract class ChatState {}

class ChatInitial extends ChatState {
  final List<Message> messages;
  ChatInitial(this.messages);
}

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final DialogflowRepository repository;

  final List<Message> _messages = [];

  ChatBloc(this.repository) : super(ChatInitial([])) {
    on<SendMessageEvent>(_onSendMessage);
  }

  void _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
    _messages.add(Message(text: event.userMessage, isUser: true));
    emit(ChatInitial(List.from(_messages)));

    final botResponse = await repository.getBotResponse(event.userMessage);
    _messages.add(Message(text: botResponse, isUser: false));
    emit(ChatInitial(List.from(_messages)));
  }
}
