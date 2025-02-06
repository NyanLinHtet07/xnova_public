import 'package:flutter/material.dart';
import 'package:xnova/Model/bar_detail_model.dart';

class BarDetailComment extends StatefulWidget {
  final BarDetailData barDetail;

  const BarDetailComment(this.barDetail, {super.key});

  @override
  _BarDetailCommentState createState() => _BarDetailCommentState();
}

class _BarDetailCommentState extends State<BarDetailComment> {
  final List<Map<String, dynamic>> commentList = [
    {
      'id': 1,
      'comment':
          "Great atmosphere and friendly staff—perfect spot for a night out"
    },
    {
      'id': 2,
      'comment':
          "ဒီဘားမှာ အရသာရှိတဲ့ ကော်တေ့လ်တွေကို အတူတကွ ရင်းနှီးပြီး ခံစားနိုင်ပါတယ်။"
    },
    {
      'id': 3,
      'comment':
          "I love the vibe of this bar—chill, but with enough energy to keep things fun"
    },
  ];

  final TextEditingController _commentController = TextEditingController();

  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        commentList.add({
          'id': commentList.length + 1,
          'comment': _commentController.text,
        });

        _commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: commentList.length,
                itemBuilder: (context, index) {
                  final item = commentList[index];
                  return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 350,
                            ),
                            child: Text(item['comment'],
                                style: const TextStyle(fontSize: 12)),
                          )
                        ],
                      ));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: 'Add a comment ...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _addComment,
                  )
                ],
              ),
            )
          ],
        ));
  }
}
