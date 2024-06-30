import 'package:flutter/material.dart';
import 'package:mosharkat_ayat_app/features/editor/view/widgets/editor_widget.dart';

class Editor_Screen extends StatelessWidget {
  const Editor_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mosharkat Ayat App'),
        ),
        body: Editor_Widget(gifUrl: "https://i.gifer.com/3zwT.gif"));
  }
}
