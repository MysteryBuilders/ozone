import 'package:firebase_messaging/firebase_messaging.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationReceivedState extends NotificationState {
  final RemoteMessage message;
  NotificationReceivedState(this.message);
}

class NotificationsClearedState extends NotificationState {}
class TokenReceivedState extends NotificationState {
  final String token;
  TokenReceivedState(this.token);
}