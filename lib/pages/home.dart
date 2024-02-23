import 'package:abookplayer/pages/player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/audio_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<AudioBookModel> list = AudioBookModel.list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('A U D I O F Y'),
        elevation: 5,
        centerTitle: true,
      ),
      drawer: const Drawer(),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(list[index].name),
              subtitle: Text(list[index].author),
              leading: ClipRRect(borderRadius: BorderRadius.circular(8),child: Image.asset(list[index].imagePath),),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlayerPage(model: list[index])));
              },
            );
          }),
    );
  }
}
