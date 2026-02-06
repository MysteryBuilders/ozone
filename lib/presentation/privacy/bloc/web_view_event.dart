

 import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewEvent extends Equatable {
  const WebViewEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class initialEvent extends WebViewEvent{

}


 class EmitLoadingState extends WebViewEvent {}

 class EmitLoadedState extends WebViewEvent {}

