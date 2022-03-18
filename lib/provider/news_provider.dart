import 'package:flutter/material.dart';
import 'package:ichat/data/info.dart';

import '../database/boxes.dart';
import '../database/news_db.dart';

class NewsProvider with ChangeNotifier {
  Iterable<News> getAllNews() {
    return newsBox.values.toList().reversed;
  }

  News getLastNews() {
    return newsBox.values.last;
  }

  int getCountNews() {
    return newsBox.values.where((element) => element.createAt > getMyInfo().lastNotify).length;
  }

  Future<void> addNews(News news) async {
    await newsBox.add(news);
    notifyListeners();
  }

  Future<void> clearNews() async {
    await newsBox.clear();
    notifyListeners();
  }
}
