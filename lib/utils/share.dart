import 'package:flutter/material.dart';
import 'package:share/share.dart';

void shareVideo(BuildContext context, String title,String videoUrl, String videoName) {
  final String text = '$title $videoName\n$videoUrl';
  Share.share(text, subject: 'Assista ao vídeo - $videoName');
}
