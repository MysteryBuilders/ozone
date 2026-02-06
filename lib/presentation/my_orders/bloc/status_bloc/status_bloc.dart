import 'dart:math';

import 'package:bloc/bloc.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/status_model.dart';

import '../../../resources/strings_manager.dart';

part 'status_event.dart';
part 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {

  String? selectedStatus;

  List<StatusModel> statusList =[
 StatusModel("pending", AppStrings.pending.tr(),false),
  StatusModel("pending_payment", AppStrings.pendingPayment.tr(),false),
  StatusModel("processing", AppStrings.processing.tr(),false),
  StatusModel("complete", AppStrings.compeletedOrders.tr(),false),
  StatusModel("closed", AppStrings.closed.tr(),false),
  StatusModel("canceled", AppStrings.cancel.tr(),false),
  StatusModel("holded", AppStrings.holded.tr(),false),
  StatusModel("payment_review", AppStrings.payment_review.tr(),false),
    // StatusModel("fraud", AppStrings.fraud.tr(),false)
  ];
  StatusBloc() : super(StatusState(statusList: [
    StatusModel("pending", AppStrings.pending.tr(),false),
    StatusModel("pending_payment", AppStrings.pendingPayment.tr(),false),
    StatusModel("processing", AppStrings.processing.tr(),false),
    StatusModel("complete", AppStrings.compeletedOrders.tr(),false),
    StatusModel("closed", AppStrings.closed.tr(),false),
    StatusModel("canceled", AppStrings.cancel.tr(),false),
    StatusModel("holded", AppStrings.holded.tr(),false),
    StatusModel("payment_review", AppStrings.payment_review.tr(),false),
    // StatusModel("fraud", AppStrings.fraud.tr(),false)
  ])) {

    on<StatusChanged>((event, emit) {
      emit(StatusState(currentIndex:event.index,statusList: statusList));
    });
  }



}
