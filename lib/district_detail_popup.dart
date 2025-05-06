import 'package:flutter/material.dart';

class DistrictDetailPopup extends StatefulWidget {
  final String districtName;

  const DistrictDetailPopup({super.key, required this.districtName});

  @override
  State<DistrictDetailPopup> createState() => _DistrictDetailPopupState();
}

class _DistrictDetailPopupState extends State<DistrictDetailPopup> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];
  bool _isLoading = false;

  void callGeminiModel() async{
    try{
      if(_controller.text.isNotEmpty){
        _messages.add(Message(text: _controller.text, isUser: true));
        _isLoading = true;
        setState(() {});
      }

      // final model = GenerativeModel(model: 'gemini-pro', apiKey: dotenv.env['GOOGLE_API_KEY']!);
      final prompt = _controller.text.trim();
      // final content = [Content.text(prompt)];
      // final response = await model.generateContent(content);

      setState(() {
        // _messages.add(Message(text: response.text!, isUser: false));
        _messages.add(Message(text: "Xin chao\nXin chao", isUser: false));
        _isLoading = false;
      });

      _controller.clear();
    }
    catch(e){
      print("Error : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 500,
        height: 500,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index){
                    final message = _messages[index];
                    return ListTile(
                      title: Align(
                        alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: message.isUser ?
                                Theme.of(context).colorScheme.primary :
                                Theme.of(context).colorScheme.secondary,
                                borderRadius: message.isUser ?
                                const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20)
                                ) :
                                const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)
                                )
                            ),
                            child: Text(
                                message.text,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)
                            )
                        ),
                      ),
                    );
                  }
              ),
            ),
            // user input
            Padding(
              padding: const EdgeInsets.only(bottom: 16,top: 16.0, left: 16.0, right: 16),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3)
                      )
                    ]
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: Theme.of(context).textTheme.titleSmall,
                        decoration: InputDecoration(
                            hintText: 'Write your message',
                            hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: Colors.grey
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20)
                        ),
                      ),
                    ),
                    const SizedBox(width: 8,),
                    _isLoading ?
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(),
                      ),
                    ) :
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
                        onTap: callGeminiModel,
                        child: const Icon(Icons.send),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Message {
  final String text;
  final bool isUser;

  Message({required this.text, required this.isUser});
}