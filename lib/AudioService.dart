
import 'package:just_audio/just_audio.dart';

class AudioService{
  late String mainUrl;
  Duration duration = Duration.zero;
  AudioPlayer player = AudioPlayer();

  setAudio(String url) async {
    mainUrl = url;
    duration = (await player.setAsset(url))!;
  }
  play() async{
    await player.play();
  }
  stop() async{
    await player.stop();
  }
  pause() async{
    await player.pause();
  }

}