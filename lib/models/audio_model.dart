class AudioBookModel{
  final String name;
  final String author;
  final String imagePath;
  final String audioPath;
  
  AudioBookModel({required this.name, required this.author, required this.audioPath, required this.imagePath});
  
  static List<AudioBookModel> list = [
    AudioBookModel(name: "Ya Qorial", author: 'No Name', audioPath: "assets/audios/YaQorial.mp3", imagePath:"assets/images/nasheed.jpg")
  ];
}