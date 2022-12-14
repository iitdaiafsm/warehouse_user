// import 'package:flutter/cupertino.dart';
//
// import '../utils/app_size.dart';
//
// class CustomGridView extends StatefulWidget {
//   final int crossAxisCount;
//   final double mainAxisSpacing;
//   final int numberOfRows;
//
//   const CustomGridView(
//       {Key? key,
//       required this.crossAxisCount,
//       required this.mainAxisSpacing,
//       required this.numberOfRows})
//       : super(key: key);
//
//   @override
//   State<CustomGridView> createState() => _CustomGridViewState();
// }
//
// class _CustomGridViewState extends State<CustomGridView> {
//   @override
//   Widget build(BuildContext context) {
//     // return GridView.builder(
//     //   physics: const NeverScrollableScrollPhysics(),
//     //   shrinkWrap: true,
//     //   gridDelegate:
//     //   SliverGridDelegateWithFixedCrossAxisCount(
//     //       crossAxisCount: widget.crossAxisCount,
//     //       crossAxisSpacing: 0,
//     //       mainAxisSpacing: getWidth(widget.mainAxisSpacing),
//     //       childAspectRatio: 2),
//     //   itemCount: (widget.crossAxisCount*widget.numberOfRows),
//     //   itemBuilder: (context, index) {
//     //     return Image.asset("asset/wheat_sack.png");
//     //   },
//     // );
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(
//           widget.crossAxisCount,
//           (index) => Column(
//                 children: List.generate(
//                   widget.numberOfRows,
//                   (index) => Padding(
//                     padding: EdgeInsets.all(getWidth(0.3)),
//                     child: Image.asset(
//                       "asset/wheat_sack.png",
//                       height: getHeight(8),
//                       width: getHeight(8),
//                     ),
//                   ),
//                 ),
//               )),
//     );
//   }
// }
