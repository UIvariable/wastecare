import 'package:flutter/material.dart';

class CustomTextRow extends StatelessWidget {
  final String label;
  final String content;
  final double containerHeight;
  final IconData iconData;

  CustomTextRow(this.containerHeight, this.label, this.content, this.iconData);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      height: containerHeight,
      child: ListTile(
        leading: Icon(iconData, color: Color(0xFFFFB0BB)),
        title: new Text(content),
      ),

      //     Row(children: <Widget>[
      //   Container(
      //     width: (MediaQuery.of(context).size.width - 86) * 0.45,
      //     padding: const EdgeInsets.only(right: 20.0),
      //     child: Text('$label', style: new TextStyle(fontSize: 18.0)),
      //   ),
      //   Container(
      //     //color: Colors.red,
      //     width: (MediaQuery.of(context).size.width - 86) * 0.55,
      //     alignment: Alignment.centerLeft,
      //     child: Text(
      //       '$content',
      //       style: new TextStyle(fontSize: 17.0),
      //       overflow: TextOverflow.visible,
      //     ),
      //   ),
      // ]),
    );
  }
}
