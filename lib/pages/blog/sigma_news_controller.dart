import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/models/blog_response_model.dart';

class AllBlogsController extends GetxController {
  int pn = 1;
  final int pl = 20;
  int total = 0;

  var newsList = <News>[].obs;
  var isLoading = true.obs;
  var hasMore = true.obs;
  var isFetchingMore = false;

  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    getBlogs();

    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100 &&
          hasMore.value &&
          !isFetchingMore) {
        getBlogs();
      }
    });
  }

  Future<void> getBlogs() async {
    if (isFetchingMore) return;

    isFetchingMore = true;
    if (newsList.isEmpty) isLoading(true);

    pn++;
    final response = await DioClient.instance.getBlogs(pn: pn, pl: pl);

    if (response?.message == 'OK') {
      total = int.tryParse(response?.count ?? '0') ?? 0;
      newsList.addAll(response?.news ?? []);
      hasMore.value = newsList.length < total;
    } else {
      hasMore.value = false;
    }

    isLoading(false);
    isFetchingMore = false;
  }
}
