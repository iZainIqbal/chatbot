import 'package:dialogflow_flutter/dialogflowFlutter.dart';
import 'package:dialogflow_flutter/googleAuth.dart';
import 'package:dialogflow_flutter/language.dart';

class DialogflowRepository {
  Future<String> getBotResponse(String query) async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/dialogflow_keys.json").build();
    DialogFlow dialogFlow = DialogFlow(
      authGoogle: authGoogle,
      language: Language.english,
    );
    AIResponse response = await dialogFlow.detectIntent(query);
    return response.getMessage() ?? "I didn’t understand that.";
  }
}
