import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sigma/helper/dio_repository.dart';
import 'package:sigma/models/published_transaction_response.dart';

class AllTransactionsController extends GetxController {
  int pn = 1;
  final int pl = 5;
  int total = 0;

  var transactions = <Transactions>[].obs;
  var isLoading = true.obs;
  var hasMore = true.obs;
  var isFetchingMore = false;
  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    getTransactions();

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && hasMore.value && !isFetchingMore) {
        getTransactions();
      }
    });
  }

  Future<void> getTransactions() async {
    if (isFetchingMore) return;
    isFetchingMore = true;
    isLoading(true);
    pn++;

    final response = await DioClient.instance.getPublishedTransactions(pl: pl, pn: pn);

    if (response?.message == 'OK') {
      total = int.tryParse(response?.count ?? '0') ?? 0;
      transactions.addAll(response?.transactions ?? []);
      hasMore.value = total > transactions.length;
    } else {
      hasMore.value = false;
    }
    isFetchingMore = false;
    isLoading(false);
  }
}
