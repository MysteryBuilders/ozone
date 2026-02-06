import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/domain/model/check_out_model.dart';
import 'package:ozon/presentation/payment/order_bloc/order_bloc.dart';
import 'package:ozon/presentation/payment/payment_bloc/payment_bloc.dart';
import 'package:ozon/presentation/payment/payment_bloc/payment_state.dart';
import 'package:ozon/presentation/widgets/loading_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../app/user_prefrences.dart';
import '../../main/bloc/cart_bloc/cart_bloc.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/langauge_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../widgets/appbar_iconbutton.dart';
import '../../widgets/appbar_title.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../payment_bloc/payment_event.dart';

class PaymentView extends StatefulWidget {
  final String url;
  final String invoiceId;
  final String paymentMethod;
  final double amount;

  const PaymentView(
      {super.key, required this.url, required this.invoiceId, required this.paymentMethod, required this.amount});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }

  late final WebViewController _controller;

  double progress = 0;
  OrderBloc orderBloc = instance<OrderBloc>();
  PaymentBloc paymentBloc = instance<PaymentBloc>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  init() {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
    WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.contains("KfastSuccess")) {
            //   UserPreferences userPreferences = GetIt.I<UserPreferences>();
            //   String userLoginToken = userPreferences.userToken!;
            //   Map<String,dynamic> paymentMethod ={};
            //   paymentMethod['method'] = widget.paymentMethod;
            //   Map<String,dynamic> map ={};
            //   map['paymentMethod'] = paymentMethod;
            //
            //   orderBloc.add(OrderFetched(userLoginToken, map));
            //   return NavigationDecision.prevent;
            // }
            // else if(request.url.contains("paymentcancel")){
            //
            //   return NavigationDecision.prevent;
            // }
            print(request.url);

            return NavigationDecision.navigate;
          },
          onHttpError: (HttpResponseError error) {
            debugPrint('Error occurred on page: ${error.response?.statusCode}');
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
          onHttpAuthRequest: (HttpAuthRequest request) {
            // openDialog(request);
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.url));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.w,
            title: AppbarTitle(
              text: AppStrings.payment.tr(),
            ),
            leading:

            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(4.w),
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                    color: ColorManager.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: ColorManager.grey)
                ),
                child: Center(
                  child: Icon(Icons.arrow_back_outlined,
                    color: ColorManager.titleColor,
                    size: 20.w,),
                ),
              ),
            ),


          ),
          backgroundColor: ColorManager.white,
          body: BlocConsumer<PaymentBloc, PaymentState>(
            bloc: paymentBloc..add(FetchPaymentMethods(widget.amount)),
            listener: (context, state) {
              if (state is PaymentMethodsLoaded) {
                if (state.successType == 1) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                    UserPreferences userPreferences = GetIt.I<UserPreferences>();
                    String userLoginToken = userPreferences.userToken!;
                    Map<String,dynamic> paymentMethod ={};
                    paymentMethod['method'] = widget.paymentMethod;
                    Map<String,dynamic> map ={};
                    map['paymentMethod'] = paymentMethod;


                  orderBloc.add(OrderFetched(userLoginToken, map));
                } else if (state.successType == 2) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                } else if (state.successType == 3) {
                  showLoadingDialog(context);
                }
              }
            },
            builder: (context, state) {
              if (state is PaymentLoading) {
                return Container(
                  alignment: AlignmentDirectional.center,
                  child: SizedBox(
                      height: 150.w,
                      width: 150.w,
                      child: Lottie.asset(ImageAssets.loadingView)),

                );
              } else if (state is PaymentMethodsLoaded) {
                return BlocListener<OrderBloc, OrderState>(
                  bloc: orderBloc,
                  listener: (context, orderState) {
                        if(orderState is OrderLoading){
                          showLoadingDialog(context);
                        }
                        else if(orderState is OrderFailure){
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(
                                state.message)),
                          );
                          Navigator.pop(context);

                        }
                        else if(orderState is OrderSuccess){
                          Navigator.pop(context);
                          Map<String,dynamic> map ={};
                          map['orderId'] =orderState.orderId;
                          map['title']= AppStrings.paymentstatu.tr();
                          Navigator.pushNamed(context, Routes.successRoute,arguments: map);

                        }

                  },
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(height: 10.w,),
                          Container(width: ScreenUtil().screenWidth,
                            height: 0.5,
                            color: ColorManager.seperatorColor,),
                          SizedBox(height: 10.w,),
                        ],
                      );
                    },
                    itemCount: state.methods.length,
                    itemBuilder: (context, index) {
                      final method = state.methods[index];
                      return ListTile(
                        leading: Container(
                            width: 50.w,
                            height: 30.w,
                            child: Image.network(method.imageUrl!,)),
                        title: Text(method.paymentMethodAr!,
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w500

                          ),),
                        onTap: () {
                          paymentBloc.add(
                              ExecuteSelectedPayment(
                                  widget.amount, method.paymentMethodId!));
                        },
                      );
                    },
                  ),
                );
              }
              return Container();
            },
          ),

          // appBar: AppBar(
          //   backgroundColor: Colors.white,
          //   elevation: 3.w,
          //   title: AppbarTitle(
          //     text: AppStrings.payment.tr(),
          //   ),
          //   leading:
          //   AppbarIconbutton(
          //       svgPath: isRtl() ?
          //       ImageAssets.imgArrowright : ImageAssets.imgArrowleft,
          //       onTap: () {
          //         Navigator.pop(context);
          //       }),
          //
          //
          // ),
          // body: BlocListener<OrderBloc, OrderState>(
          //   bloc: orderBloc,
          //   listener: (context, state) {
          //     if(state is OrderLoading){
          //       showLoadingDialog(context);
          //     }
          //     else if(state is OrderFailure){
          //       dismissLoadingDialog();
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         SnackBar(content: Text(
          //             state.message)),
          //       );
          //     }
          //     else if(state is OrderSuccess){
          //       dismissLoadingDialog();
          //     }
          //     // TODO: implement listener
          //   },
          //   child: WebViewWidget(controller: _controller),
          // ),


        ),
      ),
    );
  }
}
