import 'package:dart_openai/dart_openai.dart';

class OpenAiService {
  static const String model = "gpt-3.5-turbo";

  static sendToBoyfriend(String message) {
    Stream<OpenAIStreamChatCompletionModel> chatStream =
        OpenAI.instance.chat.createStream(
      model: model,
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          content: message,
          role: OpenAIChatMessageRole.user,
        )
      ],
    );

    chatStream.listen((chatStreamEvent) {
      print(chatStreamEvent); // ...
    });
  }
}
