

 import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:webview_flutter/webview_flutter.dart';


 abstract class WebViewState extends Equatable {}

 class WebViewInitial extends WebViewState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

 class WebViewLoading extends WebViewState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

 class WebViewLoaded extends WebViewState {



   WebViewLoaded();

  @override
  // TODO: implement props
  List<Object?> get props => [];
 }


