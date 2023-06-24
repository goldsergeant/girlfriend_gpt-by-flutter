import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:girlfriend_gpt/main.dart';
import 'package:girlfriend_gpt/services/openai_service.dart';

class BoyfriendChatPage extends StatefulWidget {
  BoyfriendChatPage({Key? key}) : super(key: key);

  @override
  _BoyfriendChatPageState createState() => _BoyfriendChatPageState();
}

class _BoyfriendChatPageState extends State<BoyfriendChatPage> {
  final now = new DateTime.now();
  List<Widget> _messages = [];
  TextEditingController _textController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  ScrollController _scrollController = ScrollController();

  _sendMessage(String message) async {
    if (_messages.isEmpty) {
      _addMessage(DateChip(date: now));
    }
    BubbleNormal bubble = BubbleNormal(
      text: message,
      isSender: true,
      tail: true,
      color: Theme.of(context).primaryColor,
      textStyle: TextStyle(color: Colors.white),
    );

    _addMessage(bubble);
    _textController.text = '';

    String? response = await OpenAiService.sendToBoyfriend(message);

    print(response);
    _scrollToLastMessage();
  }

  void _addMessage(Widget widget) {
    setState(() {
      _messages.add(widget);
    });
  }

  _scrollToLastMessage() async {
    setState(() {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  Widget _buildMessageBar() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(navigatorKey.currentState!.context).primaryColor,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                focusNode: _focusNode,
                controller: _textController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(24.0, 0, 0, 10.0),
                    hintText: "사랑의 메시지를 담아...",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none),
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                onSubmitted: (message) {
                  if (_textController.text.trim() != '') {
                    _sendMessage(message.trim());
                  }
                  _focusNode.requestFocus();
                },
              ),
            ),
            SizedBox(
              width: 15,
            ),
            IconButton(
              onPressed: () {
                if (_textController.text.trim() != '')
                  _sendMessage(_textController.text.trim());
              },
              icon: Icon(Icons.send),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now();
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/cherryblossom.gif"),
        )),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text('나만 바라봐주는 남자친구'),
              centerTitle: true,
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  physics: ScrollPhysics(),
                  controller: _scrollController,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 100.0),
                    child: Column(
                      children: _messages,
                    ),
                  ),
                ),
                _buildMessageBar()
              ],
            )));
  }
}
