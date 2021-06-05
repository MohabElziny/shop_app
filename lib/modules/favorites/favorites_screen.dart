import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/shop_layout/shop_cubit.dart';
import 'package:shop_app/shared/cubit/shop_layout/shop_states.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildListProduct(
              ShopCubit.get(context).favoritesModel.data.data[index].product,
              context,
            ),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: ShopCubit.get(context).favoritesModel.data.data.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
