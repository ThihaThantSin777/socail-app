import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:social_media_application/ml_kit/ml_kit_text_recognition.dart';

class TextDetectionBloc extends ChangeNotifier{
File? chooseImageFile;

final MLKitTextRecognition _mlKitTextRecognition=MLKitTextRecognition();

onImageChoose(File imageFile){
  chooseImageFile=imageFile;
  _mlKitTextRecognition.detectTexts(imageFile);
  notifyListeners();
}
}