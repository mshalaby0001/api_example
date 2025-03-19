import 'dart:io';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/*
### Steps to Implement WebSocket in Flutter:
1. **Import Required Packages**  
   - `dart:io` for WebSocket support.  
   - `package:web_socket_channel/io.dart` and `package:web_socket_channel/web_socket_channel.dart` for WebSocket communication.

2. **Initialize WebSocket Connection**  
   - Use `WebSocketChannel.connect(Uri.parse('wss://ws.postman-echo.com/raw'))` to establish a WebSocket connection.

3. **Create a UI with a Stream Listener**  
   - Use `StreamBuilder` to listen for incoming messages from `_channel.stream`.

4. **Create a Text Input Field**  
   - Use `TextFormField` with a `TextEditingController` to allow user input.

5. **Send Messages Over WebSocket**  
   - Implement `_sendMessage()` that sends the text input via `_channel.sink.add()`.

6. **Close WebSocket Connection**  
   - Override `dispose()` to close `_channel.sink` when the widget is removed.

This ensures real-time communication between the app and the WebSocket server. 🚀
*/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GraphQLPage(),
    );
  }
}

class WebSocketPage extends StatefulWidget {
  const WebSocketPage({super.key});

  @override
  State<WebSocketPage> createState() => _WebSocketPageState();
}

class _WebSocketPageState extends State<WebSocketPage> {
  final _channel =
      WebSocketChannel.connect(Uri.parse('wss://ws.postman-echo.com/raw'));
  final _editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        actions: [],
        title: Text('WebSocketPage'),
      ),
      body: Center(
        child: Column(
          children: [
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('Received: ${snapshot.data}');
                }
                return Text('Waiting for messages...');
              },
            ),
            Form(
              child: TextFormField(
                decoration: InputDecoration(labelText: 'send message'),
                controller: _editingController,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _sendMessage, child: Icon(Icons.send)),
    );
  }

  void _sendMessage() {
    if (_editingController.text.isNotEmpty) {
      _channel.sink.add(_editingController.text);
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}


class GraphQLPage extends StatefulWidget {
  const GraphQLPage({super.key});

  @override
  State<GraphQLPage> createState() => _GraphQLPageState();
}

class _GraphQLPageState extends State<GraphQLPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GraphQL Page'),
        backgroundColor: Colors.grey[200],
      ),
    );
  }
}
