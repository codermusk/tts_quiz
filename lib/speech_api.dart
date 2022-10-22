import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_to_text.dart';
class speechapi{
 static  final _speech = SpeechToText();
  static Future<bool> tooglerecording({
  required Function(String text) onresult,
    required ValueChanged<bool> onListening ,
})async{
   final _isAvailable = await _speech.initialize(
     onStatus: (Status)=>onListening(_speech.isListening )
         ,
     onError: (e)=>print('error')
   );
   if(_isAvailable){
     _speech.listen(onResult: (value)=>onresult(value.recognizedWords));
   }
return _isAvailable;
}
}