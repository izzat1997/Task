import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  //
  final scrollController = ScrollController().obs;
  final contents = [
    {'id': "0", 'content': 'Level 1 Content'},
    {'id': "1", 'content': 'Level 2 Content'},
    {'id': "2", 'content': 'Level 3 Content'},
    {'id': "3", 'content': 'Level 4 Content'},
    {'id': "4", 'content': 'Level 5 Content'},
  ].obs;

  final currentContents = {}.obs;
  final displayModal = false.obs;

  @override
  void onInit() {
    super.onInit();
    // currentContents.value = contents.value[0];
    contents().sort((b, a) => a['id']!.compareTo(b["id"]!));
    scrollController().addListener(_scrollListener);
  }

  void setContents(dynamic content) {
    currentContents.value = jsonDecode(content);
  }

  bool isOdd(String id) {
    int? number;

    var data = stdin.readLineSync();

    number = int.tryParse(data ?? id);

    if (number!.isEven) {
      return false;
    } else {
      return true;
    }
  }

  _scrollListener() {
    if (scrollController().position.userScrollDirection == ScrollDirection.forward) {
      if (scrollController().position.pixels < 1) {
        displayModal(false);
      }
    }
    if (scrollController().position.userScrollDirection == ScrollDirection.reverse) {
      displayModal(true);
    }
  }
}
