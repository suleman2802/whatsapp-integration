// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class WhatsappSender extends StatelessWidget {
//   const WhatsappSender({super.key});
//
//   sendMessage() async {
//     String phoneNumber = "03184482240";
//
//      var url = Uri.parse( 'https://wa.me/${phoneNumber}?text=HelloWorld');
//
//     await launchUrl(url);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Whatsapp Sender"),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(onPressed: sendMessage, child: Text("Send Message"))
//         ],
//       ),
//     );
//   }
// }
