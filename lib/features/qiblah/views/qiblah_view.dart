// import 'dart:math' as math;
// import 'package:depiproject/core/constants/assets.dart';
// import 'package:depiproject/core/widgets/main_app_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_compass/flutter_compass.dart';

// class QiblahView extends StatefulWidget {
//   const QiblahView({super.key});

//   @override
//   State<QiblahView> createState() => _QiblahViewState();
// }

// class _QiblahViewState extends State<QiblahView> {
//   double? _direction;

//   @override
//   void initState() {
//     super.initState();
//     FlutterCompass.events!.listen((event) {
//       setState(() {
//         _direction = event.heading;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           const MainAppBar(title: 'القبلة'),
//           const SizedBox(
//             height: 80,
//           ),

//           Column(
//             children: [
//               Text(
//                 "Degree: ${_direction == null ? 0 : _direction!.toInt()}°",
//                 style:
//                     const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               const Text("---------------------"),
//             ],
//           ),

//           // 🧭 Compass
//           Transform.rotate(
//             angle: ((_direction ?? 0) * (math.pi / 180) * -1),
//             child: Image.asset(
//               Imagespath.compass,
//               width: 250,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
