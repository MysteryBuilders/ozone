import 'dart:io';

import 'package:bloc/bloc.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationBloc(this.flutterLocalNotificationsPlugin) : super(NotificationInitial()) {
    on<NotificationReceived>((event, emit) {
      _showLocalNotification(event.message);
      emit(NotificationReceivedState(event.message));
    });

    on<NotificationsCleared>((event, emit) {
      emit(NotificationsClearedState());
    });
    on<GetToken>((event, emit) async {
      String token ="";
      // if(Platform.isIOS) {
      //    token = await _firebaseMessaging.getAPNSToken() ?? "";
      // }else{
      //   token = await _firebaseMessaging.getToken() ?? "";
      // }
      try{
        token = await _firebaseMessaging.getToken()??"";
      }catch(e){
        token = "";
      }

      print("token ---> ${token}");
      // if (token != null) {
        emit(TokenReceivedState(token));
      // }
    });
    _initializeFirebaseMessaging();
  }

  void _initializeFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      add(NotificationReceived(message));
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      add(NotificationReceived(message));
    });

    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        add(NotificationReceived(message));
      }
    });
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',

    channelDescription:   'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? 'No Title',
      message.notification?.body ?? 'No Body',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }
}
