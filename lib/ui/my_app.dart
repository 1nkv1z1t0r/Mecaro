import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mecaro_test/ui/block/my_app_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => MyAppBloc(), child: const MyAppView());
  }
}

class MyAppView extends StatefulWidget {
  const MyAppView({super.key});

  @override
  State<MyAppView> createState() => _MyAppView();
}

class _MyAppView extends State<MyAppView> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MyAppBloc>();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Mecaro"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              BlocBuilder<MyAppBloc, MyAppState>(builder: (context, state) {
                return ElevatedButton(
                  onPressed: state.isLoading
                      ? null
                      : () {
                          bloc.add(LoadingData());
                        },
                  child: state.isLoading
                      ? const Text("Идёт получуние сообщений")
                      : const Text("Подключение"),
                );
              }),
              const SizedBox(height: 20),
              BlocBuilder<MyAppBloc, MyAppState>(builder: (context, state) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.decodedMessages.length,
                    itemBuilder: (context, index) {
                      final message = state.decodedMessages[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        elevation: 4,
                        child: ListTile(
                          leading: Icon(message.icon, color: Colors.blue),
                          title: message.description != null
                              ? Text(message.description!)
                              : null,
                          subtitle: Text(message.text),
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
