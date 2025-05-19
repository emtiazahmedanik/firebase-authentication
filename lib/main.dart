import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practicing_firebase_authentication/services/FcmService.dart';

import 'app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FcmService().initFcm();
  runApp(const MyApp());
}



