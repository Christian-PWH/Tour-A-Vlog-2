import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';

Future<void> showAlertDialog(
    {required BuildContext context,
    required IconData icon,
    required String title,
    required String content,
    required String defaultActionText,
    required VoidCallback? onButtonPressed}) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      icon: ShaderMask(
        shaderCallback: (bounds) {
          return const LinearGradient(
                  colors: gradient,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)
              .createShader(bounds);
        },
        child: Icon(
          icon,
          size: 75.0,
          color: Colors.lightBlue,
        ),
      ),
      title: Text(title),
      content: SizedBox(
        height: 150.0,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Text(
            content,
            style: const TextStyle(fontSize: 14.0),
          ),
        ),
      ),
      actions: <Widget>[
        // ElevatedButton(
        //   style: Theme.of(context).elevatedButtonTheme.style,
        //   onPressed: () => onButtonPressed!(),
        //   child: SizedBox(
        //     width: 75.0,
        //     height: 30.0,
        //     child: Center(
        //       child: Text(
        //         defaultActionText,
        //       ),
        //     ),
        //   ),
        // ),
        GestureDetector(
          onTap: onButtonPressed!,
          child: Container(
            width: 100.0,
            height: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: gradient,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.25),
                  blurRadius: 5,
                )
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              defaultActionText,
              style: semibold18white,
            ),
          ),
        )
      ],
    ),
  );
}
