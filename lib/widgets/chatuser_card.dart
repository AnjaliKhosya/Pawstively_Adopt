import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../models/chat_user.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;
  ChatUserCard(this.user);

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.only(right: 5.0,left: 5.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.white,
          elevation: 0.5,
          child: InkWell(
            onTap: (){},
            child: ListTile(
              leading:ClipRRect(
                borderRadius: BorderRadius.circular(nq.height*1.5),
                child: CachedNetworkImage(
                  width: nq.height*.064,
                  height: nq.width* .14,
                  fit: BoxFit.fill,
                  imageUrl:widget.user.image,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 20,
                    child: Icon(Icons.person),
                  ),
                ),
              ),
              title: Text(widget.user.name),
              subtitle: Text(widget.user.about,maxLines: 1,),
              trailing: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.lightGreenAccent,
                ),
              )
            ),
          ),
        )
    );
  }
}
