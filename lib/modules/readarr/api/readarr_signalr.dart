library readarr;

import 'package:lunasea/core/utilities/logger.dart';
import 'package:signalr_netcore/ihub_protocol.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'models.dart';

typedef MessageCallback = void Function(SignalRMessage message);
typedef ReconnectCallback = void Function();

class ReadarrSignalR {
  HubConnection? _hub;

  final Map<String, MessageCallback> _messageCallbacks = {};
  final Map<String, ReconnectCallback> _reconnectCallbacks = {};

  ReadarrSignalR(
      {required String host,
      required String apiKey,
      Map<String, dynamic>? headers,
      MessageCallback? messageCallback,
      ReconnectCallback? reconnectCallback}) {
    if (messageCallback != null) {
      _messageCallbacks['constructor'] = messageCallback;
    }
    if (reconnectCallback != null) {
      _reconnectCallbacks['constructor'] = reconnectCallback;
    }

    final defaultHeaders = MessageHeaders();
    headers?.forEach((key, value) {
      defaultHeaders.setHeaderValue(key, value as String);
    });

    final httpOptions = HttpConnectionOptions(headers: defaultHeaders);

    final hub = HubConnectionBuilder()
        .withUrl(_signalRUrl(host, apiKey), options: httpOptions)
        .withAutomaticReconnect()
        .build();
    hub.onclose(_onClose);
    hub.onreconnected(_onReconnect);
    hub.on('receiveMessage', _onReceiveMessage);
    hub.start()?.then(
        (value) => LunaLogger().debug("ReadarrSignalR: connected"),
        onError: (error, stack) => LunaLogger()
            .error("ReadarrSignalR: failed to connect", error, stack));

    _hub = hub;
  }

  Future<void> stop() {
    if (_hub != null) {
      return _hub!.stop();
    }
    return Future.value();
  }

  void subscribeToMessages(String key, MessageCallback callback) {
    if (_messageCallbacks.containsKey(key)) {
      return;
    }

    _messageCallbacks[key] = callback;
  }

  void unsubscribeFromMessages(String key) {
    if (_messageCallbacks.containsKey(key)) {
      return;
    }

    _messageCallbacks.remove(key);
  }

  void subscribeToReconnect(String key, ReconnectCallback callback) {
    if (_reconnectCallbacks.containsKey(key)) {
      return;
    }

    _reconnectCallbacks[key] = callback;
  }

  void unsubscribeFromReconnect(String key) {
    if (_reconnectCallbacks.containsKey(key)) {
      return;
    }

    _reconnectCallbacks.remove(key);
  }

  void _onClose({Exception? error}) {
    LunaLogger().debug("ReadarrSignalR: connection closed:\n$error");
  }

  void _onReconnect({String? connectionId}) {
    LunaLogger().debug("ReadarrSignalR: reconnected");
    _reconnectCallbacks.values.forEach((m) => m());
  }

  void _onReceiveMessage(List<Object>? args) {
    final message = SignalRMessage.fromJson(args![0] as Map<String, dynamic>);

    LunaLogger().debug(
        "ReadarrSignalR: Got message of type ${message.name} with body:\n${message.body}");

    _messageCallbacks.values.forEach((m) => m(message));
  }

  String _signalRUrl(host, apiKey) {
    final path = 'signalr/messages?access_token=$apiKey';
    return host.endsWith('/') ? '$host$path' : '$host/$path';
  }
}
