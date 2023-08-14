import 'dart:convert';

import 'package:empathyGenerator/all_utils.dart';
import 'package:empathyGenerator/utils/text_to_speach.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  static const String routeName = '/HomePage';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ColorModel color;
  double padValue = 300.0;
  String responseText='How may I help you';
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
      backgroundColor: const Color(0xff343541),
      appBar: AppBar(
        title: const Text(
          'Flutter and ChatGPT',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff343541),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PromptBldr( responseText: responseText),
          GladTextField(
            controller: userNameController,
            maxLines: 1,
            // prefixWidget:
            //     Image.asset('assets/userlogo.png', width: 22, height: 21),
            hintText: 'google',
            onFieldTap: () {},
            suffixWidget: IconButton(onPressed: ()async { await completionFun(); }, icon: Icon(Icons.send),),
            circleRadius: 10,
            // validator: Validator.emailValidator,
          ),
          // TextFormFieldBldr(
          //     promptController: promptController, btnFun: completionFun),
        ],
      ),
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

    var prompt = 'This is indeed a test';
    var maxTokens = 250;

    var requestBody = {
      "model": "text-davinci-003",
      //         "prompt": userNameController.text,
      //         "max_tokens": 250,
              "temperature": 0,
              "top_p": 1,
      'prompt': userNameController.text,
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
      setState(() {
        responseText =completedText;
      });
      TextToSpeech.speak(responseText);
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


