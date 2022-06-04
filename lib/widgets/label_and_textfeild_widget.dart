import 'package:flutter/material.dart';
import 'package:social_media_application/resources/dimens.dart';

class LabelAndTextFieldWidget extends StatelessWidget {
  const LabelAndTextFieldWidget({Key? key,required this.labelText,required this.hintText,required this.formKey,required this.onChange,this.isPassword=false}) : super(key: key);
  final String labelText;
  final String hintText;
  final Function(String) onChange;
  final bool isPassword;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
         Text(labelText,style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: MARGIN_MEDIUM_2,
        ),),
       const SizedBox(
          height: MARGIN_MEDIUM_1X,
        ),
        Form(
          key: formKey,
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (string){
                if(string?.isEmpty??false){
                  return 'Please enter this field';
                }
                return null;
              },
              obscureText: isPassword,
              onChanged: (string)=>onChange(string),
              decoration: InputDecoration(
                  hintText: hintText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(MARGIN_SMALL),
                  )
              ),
            )
        ),
      ],
    );
  }
}
