import 'package:flutter/material.dart';
import 'package:social_media_application/resources/dimens.dart';

class ButtonAndLoginOrRegisterWidget extends StatelessWidget {
  const ButtonAndLoginOrRegisterWidget(
      {Key? key,
        required this.buttonText,
        required this.buttonAction,
        required this.loginOrRegisterText,
        required this.loginOrRegisterAction
      })
      : super(key: key);
  final String buttonText;
  final Function buttonAction;
  final String loginOrRegisterText;
  final Function loginOrRegisterAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MARGIN_MEDIUM_3)),
          minWidth: double.infinity,
          height: BUTTON_SIZE_HEIGHT,
          onPressed: () => buttonAction(),
          color: Colors.black,
          child: Text(
            buttonText,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_3,
        ),
        Container(
          alignment: Alignment.center,
          child: const Text(
            'OR',
            style: TextStyle(
              fontSize: MARGIN_CARD_MEDIUM_2,
            ),
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              loginOrRegisterText == 'Register'
                  ? 'Don\'t have a account? '
                  : 'Already have a account? ',
              style: const TextStyle(
                fontSize: MARGIN_CARD_MEDIUM_2,
              ),
            ),
            GestureDetector(
              onTap: () =>loginOrRegisterAction(),
              child: Text(
                loginOrRegisterText,
                style: const TextStyle(
                    fontSize: MARGIN_CARD_MEDIUM_3,
                    decoration: TextDecoration.underline,
                    color: Colors.blueAccent),
              ),
            )
          ],
        )
      ],
    );
  }
}