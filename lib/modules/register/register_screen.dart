import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/mode/mode_cubit.dart';
import 'package:shop_app/shared/cubit/register_screen/register_cubit.dart';
import 'package:shop_app/shared/cubit/register_screen/register_states.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.loginModel.status) {
              CacheHelper.saveData(
                  key: 'token', value: state.loginModel.data.token)
                  .then((value) {
                token = state.loginModel.data.token;
                navigateAndFinish(
                  context,
                  LoginScreen(),
                );
              });
              showToast(
                message: state.loginModel.message,
                backGroundColor: Colors.green,
              );
              print(state.loginModel.message);
              print(state.loginModel.data.token);
            } else {
              showToast(
                  message: state.loginModel.message,
                  backGroundColor: Colors.red);
              print(state.loginModel.message);
            }
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          bool mode = ModeCubit.get(context).mode;
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: mode ? Colors.white : Colors.black,
                              ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Register now to browse our hot offers!',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: mode ? Colors.grey.shade50 : Colors.grey,
                              ),
                        ),
                        SizedBox(
                          height: 30.0,
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
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Email Address must not be empty';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email,
                          isModeLabel: mode ? Colors.white : Colors.black,
                          isModeText: mode ? Colors.white : Colors.black,
                          isModeBorder: mode ? Colors.white : Colors.black,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Phone must not be empty';
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
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Password must not be empty';
                            }
                            return null;
                          },
                          label: 'Password',
                          prefix: Icons.lock,
                          isPassword: cubit.isPassword,
                          onSubmit: (value) {
                            if (formKey.currentState.validate()) {
                              cubit.userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          suffixPressed: () {
                            cubit.changePasswordVisibility();
                          },
                          suffix: cubit.suffix,
                          isModeLabel: mode ? Colors.white : Colors.black,
                          isModeText: mode ? Colors.white : Colors.black,
                          isModeBorder: mode ? Colors.white : Colors.black,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                cubit.userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'register',
                            isUpperCase: true,
                            radius: 5,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
