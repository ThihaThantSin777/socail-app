import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_application/bloc/login_bloc.dart';
import 'package:social_media_application/pages/news_feed_page.dart';
import 'package:social_media_application/pages/register_page.dart';
import 'package:social_media_application/resources/dimens.dart';
import 'package:social_media_application/widgets/button_and_login_or_register_widget.dart';
import 'package:social_media_application/widgets/label_and_textfeild_widget.dart';
import 'package:social_media_application/utils/extension.dart';

import '../widgets/loading_view_widget.dart';

class LoginPage extends StatelessWidget {
  final formKeyForEmailTextField = GlobalKey<FormState>();
  final formKeyForEmailPasswordField = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginBloc>(
      create: (context)=>LoginBloc(),
      child: Selector<LoginBloc,bool>(
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
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: MARGIN_XLARGE,
                      ),
                    ),
                    const SizedBox(
                      height: MARGIN_XXLARGE,
                    ),
                    Consumer<LoginBloc>(
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
                    Consumer<LoginBloc>(
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
                    Consumer<LoginBloc>(
                      builder: (context,bloc,child)=>
                       ButtonAndLoginOrRegisterWidget(
                        buttonAction: () {
                          bool cond=(formKeyForEmailTextField.currentState?.validate()??false) || (formKeyForEmailPasswordField.currentState?.validate()??false);
                          if(cond){
                            bloc.onTapLogin().then((value) {
                              navigatePushReplacement(context, const NewsFeedPage());
                            }).catchError((error)=> showSnackBarWithMessage(context, error.toString()));
                          }
                        },
                        buttonText: 'Login',
                        loginOrRegisterAction: () {
                          navigatePushReplacement(context, RegisterPage());
                        },
                        loginOrRegisterText: 'Register',
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
