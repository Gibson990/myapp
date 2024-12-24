// import 'package:flutter/material.dart';

// class OrderCard extends StatelessWidget {
//   final int count;
//   final String title;
//   final String subtitle;
//   final Color? color;
//   final VoidCallback onTap;

//   const OrderCard({
//     super.key,
//     required this.count,
//     required this.title,
//     required this.subtitle,
//     this.color,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cardColor = color ?? Theme.of(context).primaryColor;

//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               blurRadius: 6,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 24,
//               backgroundColor: cardColor.withOpacity(0.2),
//               child: Text(
//                 count.toString(),
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: cardColor,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     subtitle,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: cardColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Icon(
//               Icons.arrow_forward_ios,
//               size: 16,
//               color: Colors.grey,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
