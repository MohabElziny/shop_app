import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/search_model.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/search_screen/search_states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialStates());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel searchModel;

  void search(String text) {
    emit(SearchLoadingStates());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value)
    {
      searchModel = SearchModel.fromJson(value.data);

      emit(SearchSuccessStates());
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorStates(error));
    });
  }
}
