import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  final connectivity = Connectivity();
  bool dialogOpen = true;
  final isConnected = true.obs;
  late final StreamSubscription stream;

  @override
  void onInit() {
    super.onInit();
    checkInternet();
    // listen for connection
    stream =
        connectivity.onConnectivityChanged.listen(handleConnectivityChange);
  }

// check connection status
  Future<void> checkInternet() async {
    final connections = await connectivity.checkConnectivity();
    // check connection to available networks
    handleConnectivityChange(connections);
  }

  void handleConnectivityChange(List<ConnectivityResult> connections) {
    if (connections.contains(ConnectivityResult.none)) {
      isConnected.value = false;
      // show no internet dialog
      showInternetDialog();
    } else {
      isConnected.value = true;
      closeDialog();
    }
  }

  void closeDialog() {
    if (dialogOpen && Get.isDialogOpen == true) {
      Get.back();
      dialogOpen = false;
    }
  }

  void showInternetDialog() {
    if (dialogOpen) return;
    dialogOpen = true;
    final textTheme = Theme.of(Get.context!).textTheme;
    Get.dialog(
      AlertDialog(
        title: Text(
          'Offline...',
          style: textTheme.titleLarge?.copyWith(),
        ),
        content: Text(
          'You are currently not connected to the internet! Please connect and try again...',
          style: textTheme.bodyLarge?.copyWith(),
        ),
        actions: [
          Container(
            height: 40,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ElevatedButton(
              onPressed: () => checkInternet(),
              child: const Text('Retry'),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    ).then((_) {
      dialogOpen = false;
    });
  }

  @override
  void onClose() {
    stream.cancel();
    closeDialog();
    super.onClose();
  }
}
