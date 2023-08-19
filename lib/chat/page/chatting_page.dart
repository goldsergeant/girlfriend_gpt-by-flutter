import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:girlfriend_gpt/home/model/character.dart';
import 'package:girlfriend_gpt/main.dart';
import 'package:girlfriend_gpt/chat/service/chat_service.dart';

class ChattingPage extends StatefulWidget {
  Character character;
  ChattingPage({Key? key, required this.character}) : super(key: key);

  @override
  _ChattingPageState createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  List<Widget> _messages = [];
  TextEditingController _textController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  ScrollController _scrollController = ScrollController();

  _buildImage(String imagePath) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Image.network(
          imagePath,
          width: 50,
          height: 50,
        ));
  }

  _sendMessage(String message) async {
    if (_messages.isEmpty) {
      _addMessage(DateChip(date: DateTime.now()));
    }

    BubbleNormal myBubble = BubbleNormal(
      text: message,
      isSender: true,
      tail: true,
      color: Theme.of(context).primaryColor,
      textStyle: TextStyle(color: Colors.white),
    );

    _addMessage(myBubble);

    _textController.text = '';
    String response = await ChatService()
        .sendToLover(context, 'chat/${widget.character.id}/message/', message);

    BubbleSpecialOne loverBubble = BubbleSpecialOne(
      text: response,
      isSender: false,
      tail: true,
      color: Colors.blue,
      textStyle: TextStyle(color: Colors.white),
    );

    _addMessage(Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImage(widget.character.image!),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(widget.character.name!), loverBubble],
        )
      ],
    ));

    _scrollToLastMessage();
  }

  void _addMessage(Widget widget) {
    setState(() {
      _messages.add(widget);
    });
    _scrollToLastMessage();
  }

  _scrollToLastMessage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent,
      );
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
              title: Text(widget.character.name!),
              centerTitle: true,
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  physics: ScrollPhysics(),
                  controller: _scrollController,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 60.0),
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
