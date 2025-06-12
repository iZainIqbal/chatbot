import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/chat_screen.dart';
import 'repositories/dialogflow_repository.dart';
import 'blocs/chat_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Chatbot',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: RepositoryProvider(
        create: (_) => DialogflowRepository(),
        child: BlocProvider(
          create: (context) => ChatBloc(context.read<DialogflowRepository>()),
          child: const ChatScreen(),
        ),
      ),
    );
  }
}
