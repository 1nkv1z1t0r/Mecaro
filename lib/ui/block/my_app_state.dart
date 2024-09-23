part of 'my_app_bloc.dart';

class MyAppState extends Equatable {
  final List<DecodedMessage> decodedMessages;
  final bool isLoading;

  const MyAppState({required this.decodedMessages, required this.isLoading});

  @override
  List<Object?> get props => [decodedMessages, isLoading];
}