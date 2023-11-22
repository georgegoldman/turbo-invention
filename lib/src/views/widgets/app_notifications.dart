import 'package:flutter/material.dart';

mixin Notification {
  void showModalSheet(String message, BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("ok"))
              ],
            ),
          );
        });
  }
}
