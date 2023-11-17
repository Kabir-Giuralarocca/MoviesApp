import 'package:flutter/material.dart';

class DownloadProvider extends ChangeNotifier {
  int progress = 0;

  void setProgress(int percentage) {
    progress = percentage;
    notifyListeners();
  }

  void resetProgress() => progress = 0;
}
