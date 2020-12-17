import 'package:flutter/material.dart';

// bottomsupScreen simple wrapper to reduce code on the modal sheets
void bottomsupScreen(BuildContext context, Widget panel) async {
  // Note, its possible to make it full screen
  // Control how to dismiss it (navigator.pop)
  await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Padding(
                    padding: EdgeInsets.all(20.0), // content padding
                    child: panel)));
      });
}
