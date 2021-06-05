import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/mode/mode_cubit.dart';
import 'package:shop_app/shared/cubit/shop_layout/shop_cubit.dart';
import 'package:shop_app/shared/cubit/shop_layout/shop_states.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool mode = ModeCubit.get(context).mode;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateUserDataState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Name must not be empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: Icons.person,
                      isModeLabel: mode ? Colors.white : Colors.black,
                      isModeText: mode ? Colors.white : Colors.black,
                      isModeBorder: mode ? Colors.white : Colors.black,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Email must not be empty';
                        }
                        return null;
                      },
                      label: 'Email',
                      prefix: Icons.email,
                      isModeLabel: mode ? Colors.white : Colors.black,
                      isModeText: mode ? Colors.white : Colors.black,
                      isModeBorder: mode ? Colors.white : Colors.black,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'phone must not be empty';
                        }
                        return null;
                      },
                      label: 'Phone',
                      prefix: Icons.phone,
                      isModeLabel: mode ? Colors.white : Colors.black,
                      isModeText: mode ? Colors.white : Colors.black,
                      isModeBorder: mode ? Colors.white : Colors.black,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                      function: () {
                        if (formKey.currentState.validate()) {
                          ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                      text: 'update',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                      function: () {
                        LogOut(context);
                      },
                      text: 'Logout',
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
