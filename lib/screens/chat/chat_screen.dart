import 'package:chat_app/screens/chat/chat_bubble.dart';
import 'package:chat_app/screens/chat/data/message_model.dart';
import 'package:chat_app/shared/constants.dart';
import 'package:chat_app/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  static String id = 'Chat Page';
  var message = TextEditingController();
  var scroller = ScrollController();

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kAppLogo,
                    height: 50,
                  ),
                  const Text(
                    'Chat',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: scroller,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) =>
                        snapshot.data!.docs[index]['id'] == email
                            ? ChatBubble(
                                message: MessageModel.fromJson(
                                    snapshot.data!.docs[index]))
                            : ChatBubble2(
                                message: MessageModel.fromJson(
                                    snapshot.data!.docs[index])),
                  ),
                ),
                Container(
                  color: kPrimaryColor,
                  margin: EdgeInsets.only(top: 6),
                  padding: EdgeInsets.all(10),
                  child: AppFormField(
                    label: 'Message',
                    controller: message,
                    suffix: IconButton(
                        onPressed: () {
                          if (message.text != '') {
                            messages.add({
                              kMessage: message.text,
                              kCreatedAt: DateTime.now(),
                              'id': email,
                            });
                            message.clear();
                            scroller.jumpTo(0);
                          }
                        },
                        icon: Icon(Icons.send)),
                  ),
                )
              ],
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
