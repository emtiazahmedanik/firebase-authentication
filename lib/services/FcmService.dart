import 'package:firebase_messaging/firebase_messaging.dart';

class FcmService{
  Future<void> initFcm() async{
    await FirebaseMessaging.instance.requestPermission();

    //foreground state
    FirebaseMessaging.onMessage.listen(_handleNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotification);
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
  }
  void _handleNotification(RemoteMessage message){
    String formatMsg = '''
    Title: ${message.notification?.title}
    Body: ${message.notification?.body}
    Data: ${message.data}
    ''';
    print(formatMsg);
  }
  Future<void> _handleBackgroundMessage(RemoteMessage message) async{

  }


}