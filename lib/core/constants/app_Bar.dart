import 'package:flutter/material.dart';

appBarWidget({required String text, required void Function() onPress}) {
  return AppBar(
    actions: [
      IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
    ],
    title: Text(text,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Lateef',
            fontSize: 18,
            color: Colors.green)),
    centerTitle: true,
  );
}
