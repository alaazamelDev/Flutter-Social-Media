import 'package:flutter/material.dart';
import 'package:flutter_social_app/config/app_theme.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SendMessageTextWidget extends StatefulWidget {
  const SendMessageTextWidget(
      {Key? key,
      required this.getImage,
      required this.messageFunc,
      required this.controller})
      : super(key: key);
  final Function getImage;
  final Function messageFunc;
  final TextEditingController controller;

  @override
  State<SendMessageTextWidget> createState() => _SendMessageTextWidgetState();
}

class _SendMessageTextWidgetState extends State<SendMessageTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 8, right: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.2),
                      offset: const Offset(0.0, 0.50),
                      spreadRadius: 1,
                      blurRadius: 1,
                    )
                  ]),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      widget.getImage();
                    },
                    icon: const Icon(Icons.link),
                    color: Theme.of(context).bottomAppBarColor,
                    padding: const EdgeInsets.all(0),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 60),
                      child: Scrollbar(
                        child: TextField(
                          style: const TextStyle(fontSize: 14),
                          controller: widget.controller,
                          maxLines: null,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type a message"),
                        ),
                      ),
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     Icon(
                  //       Icons.link,
                  //       color: Colors.grey[500],
                  //     ),
                  //     const SizedBox(
                  //       width: 10,
                  //     ),
                  //     _messageController.text.isEmpty
                  //         ? Icon(
                  //             Icons.camera_alt,
                  //             color: Colors.grey[500],
                  //           )
                  //         : const Text(""),
                  //   ],
                  // ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              if (widget.controller.text.isEmpty) {
                Fluttertoast.showToast(
                    msg: 'Nothing to send', backgroundColor: Colors.grey);
              } else {
                widget.messageFunc();
                setState(() {
                  widget.controller.clear();
                });
              }
            },
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(50))),
              child: const Icon(
                Icons.send,
                color: whiteTextStyle,
              ),
            ),
          )
        ],
      ),
    );
  }
}
