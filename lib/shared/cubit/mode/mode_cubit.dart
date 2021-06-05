
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/cubit/mode/mode_states.dart';


class ModeCubit extends Cubit<ModeStates> {
  ModeCubit() : super (InitialAppModeState());

  // object mn AppCubit
  static ModeCubit get(context) => BlocProvider.of(context);

  bool mode = false;

  void changeAppMode({bool fromShared})
  {
    if (fromShared != null)
    {
      mode = false;
      emit(ChangeAppModeState());
    } else
    {
      mode = !mode;
      CacheHelper.saveData(key: 'mode', value: mode).then((value) {
        emit(ChangeAppModeState());
      });
    }
  }
}