import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merlin/services/chatroomService.dart';
import 'package:merlin/utils/Constants.dart';

import 'conversation.dart';

class MessageList extends StatefulWidget {
  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  Stream userDirectChats;
  TextEditingController friendsSearch;
  String searchQuery = "";
  void initState() {
    getUserChats(); //Getting the chats of the particular user
    super.initState();
    friendsSearch = new TextEditingController();
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
    print("searched " + newQuery);
  }

  getUserChats() async {
    ChatroomService().getUsersDirectChats().then((snapshots) {
      setState(() {
        userDirectChats = snapshots;
        print("we got the data for user direct chats");
      });
    });
  }

  Widget getDirectChats() {
    return StreamBuilder(
      stream: userDirectChats,
      builder: (context, asyncSnapshot) {
        print("Working");
        if (asyncSnapshot.hasData) {
          if (asyncSnapshot.data.docs.length > 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView.builder(
                itemCount: asyncSnapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  int indexOfOtherUser = 0;
                  if (Constants.prefs.getString('name') ==
                      asyncSnapshot.data.docs[index].get('usersNames')[0]) {
                    indexOfOtherUser = 1;
                  }
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(0),
                        onTap: () {
                          //Sending the user to the chat room
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Conversation(
                                chatRoomId: asyncSnapshot.data.docs[index]
                                    .get('chatRoomId'),
                                usersNames: asyncSnapshot.data.docs[index]
                                    .get('usersNames'),
                                users:
                                    asyncSnapshot.data.docs[index].get('users'),
                              ),
                            ),
                          );
                        },
                        title: Text(
                          asyncSnapshot.data.docs[index]
                              .get('usersNames')[indexOfOtherUser],
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: GestureDetector(
              onTap: () {
                showSearch(context: context, delegate: UserSearchDirect());
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).inputDecorationTheme.fillColor,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: Theme.of(context).iconTheme.color.withOpacity(0.5),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Search",
                      style: TextStyle(
                        color: Theme.of(context)
                            .inputDecorationTheme
                            .hintStyle
                            .color,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[getDirectChats()],
            ),
          ),
        ],
      ),
    );
  }
}

class UserSearchDirect extends SearchDelegate<ListView> {
  getUser(String query) {
    print("getUser");
    return FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: query)
        .limit(1)
        .snapshots();
  }

  getUserFeed(String query) {
    print("getUserFeed");
    return FirebaseFirestore.instance
        .collection("users")
        .where("userSearchParam", arrayContains: query)
        .limit(5)
        .snapshots();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.exit_to_app),
        onPressed: () {
          query = '';
        },
      ),
    ];
    // throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
    // throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
        stream: getUser(query),
        builder: (context, asyncSnapshot) {
          return asyncSnapshot.hasData
              ? ListView.builder(
                  itemCount: asyncSnapshot.data.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 16.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Card(
                          child: ListTile(
                            title: Text(
                              asyncSnapshot.data.docs[index].get('name'),
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : Container(
                  child: Center(
                    child: Image(
                      image: AssetImage("assets/search-illustration.png"),
                    ),
                  ),
                );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder(
        stream: getUserFeed(query),
        builder: (context, asyncSnapshot) {
          print("Working");
          return asyncSnapshot.hasData
              ? ListView.builder(
                  itemCount: asyncSnapshot.data.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          print("creating a chat room");
                          //Creating a chatroom for the user he searched for
                          // Can get any information of that other user here.
                          createChatRoom(
                              asyncSnapshot.data.docs[index].get('userId'),
                              context,
                              asyncSnapshot.data.docs[index].get('name'));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(0),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image(
                                  image: NetworkImage(asyncSnapshot
                                      .data.docs[index]
                                      .get('profileImage')
                                      .toString()),
                                ),
                              ),
                              title: Text(
                                  asyncSnapshot.data.docs[index].get('name')),
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : Container();
        });
    // throw UnimplementedError();
  }
}

createChatRoom(String userId, BuildContext context, String username) {
  print(userId);
  print(Constants.prefs.getString('userId'));
  if (userId != Constants.prefs.getString('userId')) {
    List<String> users = [userId, Constants.prefs.getString('userId')];
    String chatRoomId =
        getUsersInvolved(userId, Constants.prefs.getString('userId'));
    List<String> usersNames = [username, Constants.prefs.getString('name')];

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
      "usersNames": usersNames,
    };
    ChatroomService().addChatRoom(chatRoom, chatRoomId);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Conversation(
                  chatRoomId: chatRoomId,
                  usersNames: usersNames,
                  users: users,
                )));
  } else {
    print("Cannot do that");
  }
}

getUsersInvolved(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
