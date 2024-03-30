import 'package:flutter/material.dart';
import 'package:trip_xpense/presentasion/staff/staffListPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StaffListPage()
    );
  }
}
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             // Panggil Navigator untuk membuka halaman StaffPage
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => StaffListPage(staffList: [],)),
//             );
//           },
//           child: Text('Staff List Page'),
//         ),
//       ),
//     );
//   }
// }