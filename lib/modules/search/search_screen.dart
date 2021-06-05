
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/mode/mode_cubit.dart';
import 'package:shop_app/shared/cubit/search_screen/search_cubit.dart';
import 'package:shop_app/shared/cubit/search_screen/search_states.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    bool mode = ModeCubit.get(context).mode;

    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'enter text to search';
                        }

                        return null;
                      },
                      onSubmit: (String text) {
                        SearchCubit.get(context).search(text);
                      },
                      label: 'Search',
                      prefix: Icons.search,
                      isModeLabel: mode ? Colors.white : Colors.black,
                      isModeText: mode ? Colors.white : Colors.black,
                      isModeBorder: mode ? Colors.white : Colors.black,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoadingStates) LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchSuccessStates)
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) =>
                              buildListProduct(
                                SearchCubit.get(context)
                                    .searchModel
                                    .data
                                    .data[index],
                                context,
                                isOldPrice: false,
                              ),
                          separatorBuilder: (context, index) =>
                              myDivider(),
                          itemCount: SearchCubit.get(context)
                              .searchModel
                              .data
                              .data
                              .length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
