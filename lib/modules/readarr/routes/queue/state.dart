import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrQueueState extends ChangeNotifier {
  ReadarrSignalR? _signalr;

  ReadarrQueueState(BuildContext context) {
    if (context.read<ReadarrState>().enabled) {
      _signalr = context.read<ReadarrState>().signalr;
      if (_signalr != null) {
        _signalr!.subscribeToMessages(this.runtimeType.toString(),
            (message) => onMessage(message, context));
      }
      fetchQueue(context);
    }
  }

  @override
  void dispose() {
    if (_signalr != null) {
      _signalr!.unsubscribeFromMessages(this.runtimeType.toString());
    }
    super.dispose();
  }

  late Future<ReadarrQueue> _queue;
  Future<ReadarrQueue> get queue => _queue;
  set queue(Future<ReadarrQueue> queue) {
    this.queue = queue;
    notifyListeners();
  }

  void onMessage(SignalRMessage message, BuildContext context) {
    if (message.name == 'queue') {
      fetchQueue(context);
    }
  }

  Future<void> refreshQueue(BuildContext context) async {
    if (context.read<ReadarrState>().enabled) {
      await context
          .read<ReadarrState>()
          .api!
          .command
          .refreshMonitoredDownloads();
    }
  }

  Future<void> fetchQueue(BuildContext context) async {
    if (context.read<ReadarrState>().enabled) {
      _queue = context.read<ReadarrState>().api!.queue.get(
            includeBook: true,
            includeAuthor: true,
            pageSize: ReadarrDatabaseValue.QUEUE_PAGE_SIZE.data,
          );
    }
    notifyListeners();
  }
}
