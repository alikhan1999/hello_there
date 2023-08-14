import 'dart:convert';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:empathyGenerator/all_utils.dart';
import 'package:empathyGenerator/utils/text_to_speach.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart';

class VoiceAssistance extends StatefulWidget {
  const VoiceAssistance({super.key});

  @override
  State<VoiceAssistance> createState() => _VoiceAssistanceState();
}

class _VoiceAssistanceState extends State<VoiceAssistance> {
  late ColorModel color;
  double padValue = 300.0;
  String responseText='How may I help you';
  String speakText='';
  bool isListening=false;
  double accuracy= 1.0;
  SpeechToText _speechToText = SpeechToText();
  // late ResponseModel responseModel;
  final userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    TextToSpeech.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: const Color(0xff343541),
      appBar: AppBar(
        title: const Text(
          'Conversation with ChatGPT',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff343541),
      ),
      body: Column(
        children: [
          PromptBldr( responseText: responseText),
          // GladTextField(
          //   controller: userNameController,
          //   maxLines: 1,
          //   // prefixWidget:
          //   //     Image.asset('assets/userlogo.png', width: 22, height: 21),
          //   hintText: 'google',
          //   onFieldTap: () {},
          //   suffixWidget: IconButton(onPressed: ()async { await completionFun(); }, icon: Icon(Icons.send),),
          //   circleRadius: 10,
          //   // validator: Validator.emailValidator,
          // ),
          // TextFormFieldBldr(
          //     promptController: promptController, btnFun: completionFun),
        ],
      ),
      floatingActionButton:AvatarGlow(endRadius: 75.0,
      animate:isListening,
      repeat: true,
      showTwoGlows: true,

      child: GestureDetector(

        onTapDown: (details) async{
        if(!isListening){
          final available=await _speechToText.initialize();
          if(available){
            isListening =true;
            _speechToText.listen(
                onResult: (result){
                  accuracy=result.confidence;
                  print(result.recognizedWords.trim());
                  print(result.confidence);
                  setState(() =>
                    speakText =result.recognizedWords.trim());


                },
                // listenFor: Duration(seconds: 5)

            );
          }
        }
        // print(speakText);
        },
        onTapUp: (details)async{
          setState(() {
            isListening =false;
          });

         await _speechToText.stop();
          await completionFun();
        },
        child: CircleAvatar(
          backgroundColor: Colors.green,
          radius: 35,
          child: Icon(isListening ? Icons.mic : Icons.mic_none, color :Colors.white),
        ),
      ),) ,
      
    );

  }
  completionFun() async {

    setState(() => responseText = 'Loading...');

    //   final response = await http.post(
    //     Uri.parse('https://api.openai.com/v1/completions'),
    //     headers: {
    //       'Content-Type': 'application/json',
    //       'Authorization': 'Bearer ${'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'}'
    //     },
    //     body: jsonEncode(
    //       {
    //         "model": "text-davinci-003",
    //         "prompt": userNameController.text,
    //         "max_tokens": 250,
    //         "temperature": 0,
    //         "top_p": 1,
    //       },
    //     ),
    //   );
    //
    //   setState(() {
    //     _responseModel = ResponseModel.fromJson(response.body);
    //     responseText = _responseModel.choices[0]['text'];
    //     debugPrint(responseText);
    //   });
    // }
    var url = 'https://api.openai.com/v1/completions';

    var maxTokens = 250;

    var requestBody = {
      "model": "text-davinci-003",
      //         "prompt": userNameController.text,
      //         "max_tokens": 250,
      "temperature": 0,
      "top_p": 1,
      'prompt': speakText,
      'max_tokens': maxTokens,
    };

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${'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'}'
    };

    var response = await http.post(
        Uri.parse(url), headers: headers, body: jsonEncode(requestBody));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var completedText = jsonResponse['choices'][0]['text'];
      print('Generated Text: $completedText');
      print('speak Text: $speakText');
      setState(() {
        responseText =completedText;
      });
      // TextToSpeech.speak(responseText);
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

}

class _responseModel {


}

class PromptBldr extends StatelessWidget {
  final String responseText;
  const PromptBldr({Key? key, this.responseText ='How may I help you'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Center(
            child: Text(responseText, style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}


