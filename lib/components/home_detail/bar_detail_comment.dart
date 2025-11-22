import 'package:flutter/material.dart';
import 'package:xnova/Model/bar_detail_model.dart';
import 'package:xnova/Model/user_review_model.dart';
import 'package:xnova/service/auth_service.dart';
import 'package:xnova/components/utility/no_auth_detail.dart';
import 'package:xnova/service/review_service.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BarDetailComment extends StatefulWidget {
  final BarDetailData barDetail;

  const BarDetailComment(this.barDetail, {super.key});

  @override
  State<BarDetailComment> createState() => _BarDetailCommentState();
}

class _BarDetailCommentState extends State<BarDetailComment> {
  final AuthService authService = AuthService();
  final ReviewService _reviewService = ReviewService();

  int _userRating = 0;
  final TextEditingController _reviewController = TextEditingController();
  bool _isSubmitting = false;

  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    loadReview();
  }

  List<Review> reviews = [];

  void checkLoginStatus() async {
    final loggedIn = await authService.isLoggedIn();
    if (loggedIn) {
      setState(() {
        isLoggedIn = true;
      });
    } else {
      setState(() {
        isLoggedIn = false;
      });
    }
  }

  void loadReview() async {
    try {
      final result = await _reviewService.fetchReviews(widget.barDetail.id);
      setState(() {
        reviews = result;
      });
    } catch (e) {
      //print('Error loading review:$e');
    }
  }

  void addReview() async {
    if (_reviewController.text.isNotEmpty && _userRating > 0) {
      setState(() {
        _isSubmitting = true;
      });

      bool success = await _reviewService.submitReview(
          barId: widget.barDetail.id,
          rating: _userRating,
          review: _reviewController.text);

      if (success) {
        _reviewController.clear();
        _userRating = 0;
        loadReview();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit review')),
        );
      }

      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoggedIn) {
      return const NoAuthDetail();
    }

    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
                child: reviews.isEmpty
                    ? const Center(child: Text('No Review Here'))
                    : ListView.builder(
                        itemCount: reviews.length,
                        itemBuilder: (context, index) {
                          final review = reviews[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 18,
                                  backgroundImage: review.user.profile != null
                                      ? NetworkImage(
                                          'https://xnova.nyanlinhtet.com/${review.user.profile}')
                                      : null,
                                  child: review.user.profile == null
                                      ? Text(
                                          review.user.name[0],
                                          style: const TextStyle(fontSize: 16),
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      review.user.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: List.generate(
                                          5,
                                          (starIndex) => Icon(
                                                Icons.star,
                                                color: starIndex < review.rating
                                                    ? Colors.amber
                                                    : Colors.grey[300],
                                                size: 16,
                                              )),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      review.review ?? '',
                                      style: const TextStyle(fontSize: 13),
                                    )
                                  ],
                                ))
                              ],
                            ),
                          );
                        },
                      )),
            Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Rating:',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 20.0)),
                        RatingBar.builder(
                          initialRating: _userRating.toDouble(),
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemSize: 30.0,
                          itemPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              _userRating = rating.toInt();
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _reviewController,
                            decoration: InputDecoration(
                                hintText: 'Add Comment ...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10)),
                          ),
                        ),
                        IconButton(
                          icon: _isSubmitting
                              ? CircularProgressIndicator()
                              : Icon(Icons.send),
                          onPressed: _isSubmitting ? null : addReview,
                        )
                      ],
                    )
                  ],
                ))
          ],
        ));
  }
}
