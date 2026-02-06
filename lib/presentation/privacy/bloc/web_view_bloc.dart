
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ozon/presentation/privacy/bloc/web_view_event.dart';
import 'package:ozon/presentation/privacy/bloc/web_view_state.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';


class WebViewBloc extends Bloc<WebViewEvent, WebViewState> {
  WebViewBloc() : super(WebViewInitial()) {
    on<EmitLoadingState>((event, emit)  {
      emit(WebViewLoading());

    });

    on<EmitLoadedState>((event, emit)  {
      emit(WebViewLoaded());

    });


    // add(initialEvent());

    // Load the initial URL when the bloc is created

  }




}