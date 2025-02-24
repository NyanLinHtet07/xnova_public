// import 'package:flutter/material.dart';
// import 'package:xnova/Model/bar_detail_model.dart';

// class BarDetailMenu extends StatefulWidget {
//   final BarDetailData barDetail;

//   const BarDetailMenu(this.barDetail, {super.key});

//   @override
//   State<BarDetailMenu> createState() => _BarDetailMenuState();
// }

// class _BarDetailMenuState extends State<BarDetailMenu> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 16),
//         Expanded(
//           child: ListView.builder(
//             itemCount: widget.barDetail.menus.length,
//             itemBuilder: (context, index) {
//               final category = widget.barDetail.menus[index];
//               return Padding(
//                   padding: EdgeInsets.all(10.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         category.title,
//                         style: const TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 8),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: category.menus.length,
//                         itemBuilder: (context, itemIndex) {
//                           final item = category.menus[itemIndex];
//                           return Container(
//                             margin: const EdgeInsets.symmetric(vertical: 8.0),
//                             padding: const EdgeInsets.all(12.0),
//                             decoration: BoxDecoration(
//                               color: Colors.grey[50],
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     const Icon(Icons.wine_bar,
//                                         color: Colors.black),
//                                     const SizedBox(width: 10),
//                                     Text(
//                                       item.name,
//                                       style: const TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                                 Text(
//                                   '${item.price} MMK',
//                                   style: const TextStyle(
//                                       fontSize: 16, color: Colors.black45),
//                                 )
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                       const SizedBox(height: 16),
//                     ],
//                   ));
//             },
//           ),
//         )
//       ],
//     );
//   }
// }
