import 'package:erp_whatsapp/whatsapp_sender.dart';
import 'package:flutter/material.dart';
import 'Screens/home_screen.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
          )
        ),
        textTheme: TextTheme(
          titleSmall: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          titleMedium: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        )
      ),
      home: HomeScreen(),
      // home: WhatsappSender(),
    );
  }
}
//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatelessWidget {
//   Future<void> _sendPDFToWhatsApp() async {
//     final String pdfUrl = "https://www.irs.gov/pub/irs-pdf/f1040.pdf"; //'https://drive.google.com/file/d/1Ar082oEw7TsIiyKCEJTtWSyLauanxIUa/view?usp=sharing';
//
//     final phoneNumber = '923237455727'; // Replace with the recipient's phone number
//
//     final url = 'whatsapp://send?phone=$phoneNumber&text=$pdfUrl';
//     if (await canLaunchUrl(Uri.parse(url))) {
//       await launchUrl(Uri.parse(url));
//     } else {
//       throw 'Could not launch WhatsApp.';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Send PDF via WhatsApp'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _sendPDFToWhatsApp,
//           child: Text('Send PDF via WhatsApp'),
//         ),
//       ),
//     );
//   }
// }
