
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_media_application/bloc/add_new_post_bloc.dart';
import 'package:social_media_application/resources/dimens.dart';

class PostButtonView extends StatelessWidget {
  const PostButtonView(
      {Key? key, required this.formSate, required this.newsFeedID})
      : super(key: key);
  final GlobalKey<FormState> formSate;
  final int newsFeedID;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewPostBloc>(
      builder: (context, bloc, child) => MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MARGIN_MEDIUM_1X)),
          color: bloc.themeColor,
          textColor: Colors.white,
          minWidth: MediaQuery.of(context).size.width,
          child: Text(newsFeedID == -1 ? 'POST' : 'EDIT'),
          onPressed: () {
            if (formSate.currentState?.validate() ?? false) {
              bloc.addPost().then((value) {
                Navigator.of(context).pop();
              });
            }
          }),
    );
  }
}

class PostTextFieldView extends StatelessWidget {
  const PostTextFieldView({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewPostBloc>(
      builder: (context, bloc, child) => Form(
          key: formKey,
          child: TextFormField(
            onChanged: (string) {
              bloc.setPostText = string;
            },
            validator: (string) {
              if (string?.isEmpty ?? true) {
                return 'Please enter something!!!';
              }
              return null;
            },
            controller: TextEditingController(text: bloc.getPostText),
            decoration: InputDecoration(
                hintText: "What is on your mind",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(MARGIN_MEDIUM_1X),
                )),
            maxLines: MAX_LINE,
          )),
    );
  }
}

class ProfileImageAndNameView extends StatelessWidget {
  const ProfileImageAndNameView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewPostBloc>(builder: (context, bloc, child) {
      String url = bloc.profilePicture.isEmpty
          ? 'https://st3.depositphotos.com/5392356/13703/i/1600/depositphotos_137037020-stock-photo-professional-software-developer-working-in.jpg'
          : bloc.profilePicture;
      return Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
              url,
            ),
          ),
          const SizedBox(
            width: MARGIN_MEDIUM_1X,
          ),
          Text(
            bloc.userName,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: TEXT_REGULAR_2X),
          )
        ],
      );
    });
  }
}

class PostImageView extends StatelessWidget {
  const PostImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewPostBloc>(
      builder: (context, bloc, child) => Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(MARGIN_MEDIUM_1X),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(TEXT_REGULAR_3X),
                border: Border.all(width: 1, color: Colors.black)),
            child: (bloc.chooseImageFile==null)? ClipRRect(
              borderRadius: BorderRadius.circular(TEXT_REGULAR_3X),
              child: GestureDetector(
                onTap: ()async{
                  print('Tap');
                  final imagePicker=ImagePicker();


                  final  image=await imagePicker.pickImage(
                      source: ImageSource.gallery
                  );
                  print('Data $image');
                  if(image!=null){
                    bloc.onImageChoose(File(image.path));
                    print('Not null');
                  }else{
                    print('null');
                    return;
                  }


                },
                child: Image.network(
                  'https://www.chanchao.com.tw/images/default.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ):Container(
              padding: const EdgeInsets.all(MARGIN_MEDIUM_1X),
              child: Image.file(
                bloc.chooseImageFile??File(''),
                fit: BoxFit.cover,
              ),
            )

          ),
          Align(
            alignment: Alignment.topRight,
            child: Visibility(
              visible: bloc.chooseImageFile!=null,
              child: IconButton(
                onPressed: (){
                  bloc.onTapDeleteImage();
                },
                icon: const Icon(Icons.delete),
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}
