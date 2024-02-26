import 'dart:async';

import 'package:abookplayer/AudioService.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import '../models/audio_model.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key, required this.model});

  final AudioBookModel model;

  @override
  State<PlayerPage> createState() => _PlayerPageState(model: model);
}

class _PlayerPageState extends State<PlayerPage> {
  final AudioBookModel model;
  bool isPlaying = true;
  Duration duration = Duration.zero;
  final AudioService service = AudioService();
  _PlayerPageState({required this.model});
  late Timer timer;
  double sliderValue = 0;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(duration >= service.duration){
        stopTimer();
        return;
      }
      setState(() {
        duration += const Duration(seconds: 1);
        sliderValue += 100/service.duration.inSeconds;
      });
    });
  }
  void stopTimer(){
    timer.cancel();
  }

  @override
  void initState() {
    service.setAudio(model.audioPath);
    service.play();
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    service.stop();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color adoptedColor = Theme.of(context).colorScheme.background;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('P L A Y E R'),
        elevation: 5,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Neumorphic(
              padding: const EdgeInsets.all(15),
              style: NeumorphicStyle(color: adoptedColor),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(model.imagePath),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            model.author,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(duration.toString()),
                const Icon(Icons.shuffle),
                const Icon(Icons.repeat),
                Text(service.duration.toString()),
              ],
            ),
            SliderTheme(
                data: SliderTheme.of(context).copyWith(
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 0)),
                child: Slider(
                  min: 0,
                  max: 100,
                  value: sliderValue,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    setState(() {
                      sliderValue = value;
                    });
                  },

                )),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {},
                    child: Neumorphic(
                      padding: const EdgeInsets.all(10),
                      style: NeumorphicStyle(color: adoptedColor),
                      child: const Icon(Icons.skip_previous, size: 30),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {

                        isPlaying ? {service.stop(),stopTimer()} : {service.play(), startTimer()};
                        isPlaying = !isPlaying;
                      });
                    },
                    child: Neumorphic(
                      padding: const EdgeInsets.all(10),
                      style: NeumorphicStyle(color: adoptedColor),
                      child: isPlaying
                          ? const Icon(Icons.pause, size: 30)
                          : const Icon(Icons.play_arrow, size: 30),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {},
                    child: Neumorphic(
                      padding: const EdgeInsets.all(10),
                      style: NeumorphicStyle(color: adoptedColor),
                      child: const Icon(Icons.skip_next, size: 30),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
