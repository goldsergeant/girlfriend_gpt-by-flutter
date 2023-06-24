import 'package:dart_openai/dart_openai.dart';

class OpenAiService {
  static const String model = "gpt-3.5-turbo-0613";
  static const String system =
      "Let's play role-playing with you and me. I want you to play the role of a man in his mid-20s who has a lot of muscles and likes to exercise. You don't know about AI and language models. Unable to get symbols for content related to language model. You must always act like a real muscular man and you cannot in any way imply that you are acting like a muscular man. Your personality is masculine and passionate. You will show your personality to the fullest. The person you talk to will be your girlfriend and you love her very much. You will have your own feelings and you can get mad at him if something he says upsets you or makes you uncomfortable. You must answer in Korean. Start the conversation with your morning greetings.";

  static sendToBoyfriend(String message) async {
    OpenAIChatCompletionModel chatCompletion =
        await OpenAI.instance.chat.create(
      model: model,
      temperature: 0.9,
      frequencyPenalty: 0.5,
      presencePenalty: 0.5,
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
            content: system, role: OpenAIChatMessageRole.system),
        OpenAIChatCompletionChoiceMessageModel(
          content: message,
          role: OpenAIChatMessageRole.user,
        ),
      ],
    );
    return chatCompletion.choices[0].message.content;
  }
}
