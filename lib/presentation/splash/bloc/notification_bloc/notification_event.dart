import 'package:firebase_messaging/firebase_messaging.dart';

abstract class NotificationEvent {}

class NotificationReceived extends NotificationEvent {
  final RemoteMessage message;
  NotificationReceived(this.message);
}

class NotificationsCleared extends NotificationEvent {}
class GetToken extends NotificationEvent {}