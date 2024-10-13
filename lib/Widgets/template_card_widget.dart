import 'package:flutter/material.dart';

class TemplateCardWidget extends StatelessWidget {
  String message;
  String url;

  TemplateCardWidget(this.message, this.url);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          RowWidget(context,"Text Message : ", message),
          RowWidget(context,"URL : ", url),
        ],
      ),
    );
  }

  Widget RowWidget(BuildContext context,String heading, String data) {
    return Row(
      children: [
        Text(
         heading,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Text(data),
      ],
    );
  }
}
