import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/login_screen/login_cubit.dart';
import 'package:shop_app/shared/cubit/login_screen/login_states.dart';
import 'package:shop_app/shared/cubit/mode/mode_cubit.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status) {
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data.token)
                  .then((value) {
                    token = state.loginModel.data.token;
                navigateAndFinish(
                  context,
                  ShopLayout(),
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
          var cubit = LoginCubit.get(context);
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
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: Colors.black,
                              ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Login now to browse our hot offers!',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        SizedBox(
                          height: 30.0,
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
                              LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
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
                          condition: state is! LoginLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            text: 'login',
                            isUpperCase: true,
                            radius: 5,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextButton(
                                function: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                text: 'Register Now')
                          ],
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
