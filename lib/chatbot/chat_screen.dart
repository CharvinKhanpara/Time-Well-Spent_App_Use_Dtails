import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _userMessage = TextEditingController();

  static const apiKey =
      "AIzaSyALmbNM0NUZQRdpQ_H-xG0SCwhLFSFDv0M"; // Use a secure method for managing API keys

  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  final List<Message> _messages = [];

  Future<void> sendMessage() async {
    final message = _userMessage.text;
    _userMessage.clear();

    setState(() {
      _messages
          .add(Message(isUser: true, message: message, date: DateTime.now()));
    });

    try {
      final content = [Content.text(message)];
      final response = await model.generateContent(content);
      setState(() {
        _messages.add(Message(
          isUser: false,
          message: response.text ?? "No response",
          date: DateTime.now(),
        ));
      });
    } catch (error) {
      setState(() {
        _messages.add(Message(
          isUser: false,
          message: "Error: $error",
          date: DateTime.now(),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TWS Chat Bot'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Messages(
                  isUser: message.isUser,
                  message: message.message,
                  date: DateFormat('HH:mm').format(message.date),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 15,
                  child: TextFormField(
                    controller: _userMessage,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      label: const Text("Enter your message"),
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  padding: const EdgeInsets.all(15),
                  iconSize: 30,
                  onPressed: sendMessage,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;

  const Messages({
    super.key,
    required this.isUser,
    required this.message,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 15).copyWith(
        left: isUser ? 100 : 10,
        right: isUser ? 10 : 100,
      ),
      decoration: BoxDecoration(
        color:
            isUser ? Color.fromARGB(255, 55, 148, 225) : Colors.grey.shade300,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(10),
          topRight: const Radius.circular(10),
          bottomLeft: Radius.circular(isUser ? 10 : 0),
          bottomRight: Radius.circular(isUser ? 0 : 10),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
              color: isUser ? Colors.white : Colors.black,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            date,
            style: TextStyle(
              color: isUser ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final bool isUser;
  final String message;
  final DateTime date;

  Message({required this.isUser, required this.message, required this.date});
}
