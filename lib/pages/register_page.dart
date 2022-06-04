import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_application/bloc/register_bloc.dart';
import 'package:social_media_application/resources/dimens.dart';
import 'package:social_media_application/widgets/button_and_login_or_register_widget.dart';
import 'package:social_media_application/widgets/label_and_textfeild_widget.dart';
import 'package:social_media_application/utils/extension.dart';
import 'package:social_media_application/widgets/loading_view_widget.dart';

import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  final formKeyForEmailTextField = GlobalKey<FormState>();
  final formKeyForUserNameTextField = GlobalKey<FormState>();
  final formKeyForEmailPasswordField = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterBloc>(
      create: (context)=>RegisterBloc(),
      child: Selector<RegisterBloc,bool>(
        selector: (context,bloc)=>bloc.isLoading,
        builder: (context,isLoading,child)=>
       Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: MARGIN_MEDIUM_3, vertical: MARGIN_EXTRA_LARGE),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Register',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: MARGIN_XLARGE,
                      ),
                    ),
                    const SizedBox(
                      height: MARGIN_XXLARGE,
                    ),
                    Consumer<RegisterBloc>(
                      builder: (context,bloc,child)=>
                   LabelAndTextFieldWidget(
                          labelText: 'Email',
                          hintText: 'Please enter your email',
                          formKey: formKeyForEmailTextField,
                          onChange: (string) {
                            bloc.onEmailChange(string);
                          }),
                    ),
                    const SizedBox(
                      height: MARGIN_LARGE,
                    ),
                    Consumer<RegisterBloc>(
                        builder: (context,bloc,child)=>
                    LabelAndTextFieldWidget(
                          labelText: 'UserName',
                          hintText: 'Please enter your username',
                          formKey: formKeyForUserNameTextField,
                          onChange: (string) {
                            bloc.onUserNameChange(string);
                          }),
                    ),
                    const SizedBox(
                      height: MARGIN_LARGE,
                    ),
                    Consumer<RegisterBloc>(
                      builder: (context,bloc,child)=>
                       LabelAndTextFieldWidget(
                          isPassword: true,
                          labelText: 'Password',
                          hintText: 'Please enter your password',
                          formKey: formKeyForEmailPasswordField,
                          onChange: (string) {
                            bloc.onPasswordChange(string);
                          }),
                    ),
                    const SizedBox(
                      height: MARGIN_XXLARGE,
                    ),
                    Consumer<RegisterBloc>(
                      builder: (context,bloc,child)=>
                       ButtonAndLoginOrRegisterWidget(
                        buttonAction: () {
                          bool cond=(formKeyForEmailPasswordField.currentState?.validate()??false) || (formKeyForEmailTextField.currentState?.validate()??false) || (formKeyForUserNameTextField.currentState?.validate()??false);
                          if(cond){
                            bloc.onTapRegister().then((value) {
                              navigatePushReplacement(context,  LoginPage());
                            }).catchError((error)=> showSnackBarWithMessage(context, error.toString()));
                          }

                        },
                        buttonText: 'Register',
                        loginOrRegisterAction: () {
                          navigatePushReplacement(context, LoginPage());
                        },
                        loginOrRegisterText: 'Login',
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
                visible: isLoading,
                child: Container(
                  color: Colors.black12,
                  child:  const Center(
                      child: LoadingViewWidget()
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
