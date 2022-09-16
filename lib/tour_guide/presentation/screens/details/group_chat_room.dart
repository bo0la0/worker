import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';


class GroupChatRoom extends StatefulWidget {
  final String groupChatId, groupName,tourGuideName;

  const GroupChatRoom({required this.groupName, required this.groupChatId, Key? key, required this.tourGuideName})
      : super(key: key);

  @override
  State<GroupChatRoom> createState() => _GroupChatRoomState();
}

class _GroupChatRoomState extends State<GroupChatRoom> {
  final TextEditingController _message = TextEditingController();
  final translator = GoogleTranslator();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    List trans = [];
  translate(String text, String lang) async {
    await translator.translate(text, to: lang).then((value) {
      setState(() {
        trans.add(value);

      });
    });

  }

  @override
  Widget build(BuildContext context) {


    final Size size = MediaQuery
        .of(context)
        .size;

    void onSendMessage() async {
      if (_message.text.isNotEmpty) {
       await translate(_message.text,'en');
       await translate(_message.text,'es');
       await translate(_message.text,'it');
       await translate(_message.text,'fr');
       await translate(_message.text,'de');
       await translate(_message.text,'ru');


        Map<String, dynamic> chatData = {
          "sendBy": widget.tourGuideName,
          "message": _message.text,
          "en": trans[0].toString(),
          "es": trans[1].toString(),
          "it": trans[2].toString(),
          "fr": trans[3].toString(),
          "de": trans[4].toString(),
          "ru": trans[5].toString(),
          "time": FieldValue.serverTimestamp(),
        };
       trans = [];

        _message.clear();

        await _firestore
            .collection('Trips')
            .doc(widget.groupChatId)
            .collection('messages')
            .add(chatData);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName),
        backgroundColor: const Color(0XFF635f5e),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 1.27,
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('Trips')
                    .doc(widget.groupChatId)
                    .collection('messages')
                    .orderBy('time')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> chatMap =
                        snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;

                        return messageTile(size, chatMap, context);
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(
                  15.0,
                ),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                      ),
                      child: TextFormField(
                        maxLines: 3,
                        minLines: 1,
                        controller: _message,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'type your message here ...',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50.0,
                    color: const Color(0XFF635f5e),
                    child: MaterialButton(
                      onPressed: onSendMessage,
                      minWidth: 1.0,
                      child: const Icon(
                        Icons.send,
                        size: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messageTile(Size size, Map<String, dynamic> chatMap, context) {


    return Builder(builder: (_) {
      return Container(
        width: size.width,
        alignment: chatMap['sendBy'] == widget.tourGuideName
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Container(
            padding:  const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color:  chatMap['sendBy'] == widget.tourGuideName ? Colors.red : Colors.blue,
            ),
            child: Column(
              children: [
                Text(
                  chatMap['sendBy'],
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: size.height / 200,
                ),
                Text(
                  chatMap['message'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  '_____',
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                  ),
                ),
                Text(
                  chatMap['en'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
      );
    });
  }
}

