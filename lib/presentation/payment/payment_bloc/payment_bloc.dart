import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:ozon/app/app_prefrences.dart';
import 'package:ozon/presentation/payment/payment_bloc/payment_event.dart';
import 'package:ozon/presentation/payment/payment_bloc/payment_state.dart';
import 'package:ozon/presentation/resources/color_manager.dart';
import 'package:ozon/presentation/resources/strings_manager.dart';

import '../config/config.dart';
import '../view/api_keys.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  AppPreferences _appPreferences;
  PaymentBloc(this._appPreferences) : super(PaymentInitial()) {
    on<FetchPaymentMethods>(_fetchPaymentMethods);
    on<ExecuteSelectedPayment>(_executePayment);
  }
List<MFPaymentMethod> paymentMethods =[];
  String formatText(String input) {
    String cleaned = input.replaceAll('-', ''); // Remove all hyphens
    if (cleaned.isEmpty) return '';
    return cleaned[0].toUpperCase() + cleaned.substring(1).toLowerCase();
  }
  Future<void> _fetchPaymentMethods(
      FetchPaymentMethods event, Emitter<PaymentState> emit) async {
    emit(PaymentLoading());
    String sourceCode = await _appPreferences.getSourceCode();
    print("sourceCode Payment: $sourceCode");

    // PaymentGateWayMethod? method = PaymentGateWayMethodHelper.fromKey(formatText(sourceCode));
    PaymentGateWayMethod? method = PaymentGateWayMethodHelper.fromKey('test');
    try {
      MFSDK.init(
        method!.displayName,
        MFCountry.KUWAIT, // Replace with your token
        MFEnvironment.TEST,
      );
      MFSDK.setUpActionBar(
          toolBarTitle: AppStrings.payNow.tr(),
          toolBarTitleColor: '#262626',
          toolBarBackgroundColor: '#FFFFFF',
          isShowToolBar: true);
      var request = MFInitiatePaymentRequest(
          invoiceAmount: event.amount,
          currencyIso: MFCurrencyISO.KUWAIT_KWD);

      var result = await MFSDK.initiatePayment(
          request, MFLanguage.ARABIC
      );
      paymentMethods = result.paymentMethods!;
      if (result.paymentMethods != null) {
        for (var method in result.paymentMethods!) {
          print('--- Payment Method ---');
          print('ID: ${method.paymentMethodId}');
          print('Name (AR): ${method.paymentMethodAr}');
          print('Name (EN): ${method.paymentMethodEn}');
          print('Code: ${method.paymentMethodCode}');
          print('Is Direct Payment: ${method.isDirectPayment}');
          print('Service Charge: ${method.serviceCharge}');
          print('Total Amount: ${method.totalAmount}');
          print('Currency ISO: ${method.currencyIso}');
          print('Image URL: ${method.imageUrl}');
          print('Is Embedded Supported: ${method.isEmbeddedSupported}');
          print('Payment Currency ISO: ${method.paymentCurrencyIso}');
          print('-----------------------\n');
        }
      } else {
        print('No payment methods available.');
      }

      emit(PaymentMethodsLoaded(result.paymentMethods!,"Payment Methods Loaded",0));
    } catch (e) {
      emit(PaymentMethodsLoaded(paymentMethods,"Failed to load payment methods: $e",0));
    }
  }

  Future<void> _executePayment(
      ExecuteSelectedPayment event, Emitter<PaymentState> emit) async {
    emit(PaymentMethodsLoaded(paymentMethods,"loading",3));

    try {
      var request = MFExecutePaymentRequest(
        invoiceValue: event.amount,
        paymentMethodId: event.methodId,
      );

      MFGetPaymentStatusResponse value =  await     MFSDK.executePayment(

        request,
        MFLanguage.ARABIC,
        (invoiceId) {
          print("Invoice ID: $invoiceId");
        },
        // onPaymentResponse: (MFResult<MFPaymentStatusResponse> result) {
        //   if (result.isSuccess()) {
        //     emit(PaymentSuccess("Payment success! Invoice ID: ${result.response!.invoiceId}"));
        //   } else {
        //     emit(PaymentFailure("Payment failed: ${result.error!.message}"));
        //   }
        // },
      );
      if(value.invoiceStatus == "Paid"){
        emit(PaymentMethodsLoaded(paymentMethods,"Payment success! Invoice ID: ${value.invoiceId}",1));
      }else{
        emit(PaymentMethodsLoaded(paymentMethods,"Payment ${value.invoiceStatus}",2));
      }

         } catch (e) {
      if (e is MFError) {
        print("MyFatoorah Error: ${e.message} (Code: ${e.code})");
        emit(PaymentMethodsLoaded(paymentMethods,"MyFatoorah Error: ${e.message} (Code: ${e.code})",2));
      } else {
        emit(PaymentMethodsLoaded(paymentMethods,"Unexpected error: ${e}",2));
      }
         }


  }
}
