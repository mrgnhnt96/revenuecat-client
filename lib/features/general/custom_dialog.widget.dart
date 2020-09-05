import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final Widget image;
  final Widget child;
  final String button;
  final Function pressed;
  final Function dismissed;
  final bool permanent;

  const CustomDialog(
    this.title,
    this.message, {
    this.image,
    this.child,
    this.button,
    this.pressed,
    this.dismissed,
    this.permanent = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      clipBehavior: Clip.hardEdge,
      backgroundColor: Get.isDarkMode ? Colors.grey.shade900 : Colors.white,
      titlePadding: EdgeInsets.zero,
      scrollable: true,
      title: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 30, 25, 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 25),
                  if (image != null) ...[
                    image,
                    const SizedBox(height: 20),
                  ],
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Linkify(
                    onOpen: (link) => launch(link.url),
                    text: message,
                    style: TextStyle(fontSize: 15, fontFamily: 'Roboto'),
                    textAlign: TextAlign.center,
                    linkStyle: TextStyle(color: Colors.blue),
                  ),
                  const SizedBox(height: 20),
                  if (child != null) ...[
                    child,
                    const SizedBox(height: 20),
                  ],
                  if (button != null && pressed != null) ...[
                    const Divider(height: 0),
                    FlatButton(
                      color: Colors.transparent,
                      child: Text(
                        button,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.blue,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      onPressed: () {
                        if (!permanent) Get.back();
                        pressed?.call();
                      },
                    )
                  ] else ...[
                    const SizedBox(height: 20),
                  ]
                ],
              ),
            ),
          ),
          if (!permanent) ...[
            IconButton(
                icon: const Icon(Icons.close, size: 18),
                onPressed: () {
                  Get.back();
                  dismissed?.call();
                })
          ]
        ],
      ),
    );
  }
}
