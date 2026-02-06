import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/status_model.dart';

part 'check_status_event.dart';
part 'check_status_state.dart';

class CheckStatusBloc extends Bloc<CheckStatusEvent, CheckStatusState> {
  CheckStatusBloc() : super(CheckStatusInitial()) {
    on<CheckStatusFetched>((event, emit) {
      // Clone the list manually to avoid modifying the original one
      List<StatusModel> mStatusList = event.statusList.map((e) => StatusModel(
        e.statusKey,
        e.statusString,
        e.isChecked,
      )).toList();

      String mStatus = event.status;
      int foundIndex = -1;

      // Find index of the matched status
      for (int i = 0; i < mStatusList.length; i++) {
        if (mStatus == mStatusList[i].statusKey) {
          foundIndex = i;
          break;
        }
      }

      if (foundIndex != -1) {
        // Set all before and at the foundIndex as checked
        for (int i = 0; i <= foundIndex; i++) {
          mStatusList[i].isChecked = true;
        }
        // Set all after as unchecked
        for (int i = foundIndex + 1; i < mStatusList.length; i++) {
          mStatusList[i].isChecked = false;
        }
      }

      emit(CheckStatusSuccess(statusModel: mStatusList));
    });


  }
}
