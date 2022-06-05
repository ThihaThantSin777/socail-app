import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_application/bloc/test_detection_bloc.dart';
import 'package:images_picker/images_picker.dart';
class TextDetectionPage extends StatelessWidget {
  const TextDetectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TextDetectionBloc>(
      create: (context)=>TextDetectionBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: ()=>Navigator.of(context).pop(),
            icon: const Icon(Icons.chevron_left,color: Colors.black,),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('Text Detected',style: TextStyle(color: Colors.black),),
        ),
        body: Center(
          child: Consumer<TextDetectionBloc>(
            builder: (context,bloc,child)=>
             Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                     bloc.chooseImageFile==null?
                        Container():Container(
                       padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                       child: Image.file(bloc.chooseImageFile??File('')),
                     ),


                  MaterialButton(onPressed: ()async{
                    List<Media>? res = await ImagesPicker.pick(
                        count: 3,
                        pickType: PickType.image,
                    );
                    if (res != null) {
                     bloc.onImageChoose( File(res[0].path));
                    }
                    },
                    textColor: Colors.white,
                    color: Colors.black,
                  child: const Text('Choose Image'),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
