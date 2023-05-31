import 'package:flutter/material.dart';

void showSnackBar(context, IconData? icon, Color? iconColor, String? message,
    Color? messageColor) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Flexible(
              child: Text(
                message!,
                style: TextStyle(
                  color: messageColor!,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
}
