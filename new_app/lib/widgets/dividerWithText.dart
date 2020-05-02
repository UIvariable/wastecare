import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DividerWithText extends StatelessWidget {
  final String dividerText;

  const DividerWithText({Key key, this.dividerText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return dividerText != null ? dividerWithText(dividerText) : Container();
  }
}

Widget dividerWithText(String dividerText) {
  return Padding(
    padding: const EdgeInsets.all(30.0),
    child: Row(
      children: <Widget>[
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Divider(
            color: Colors.black,
          ),
        )),
        Text(
          dividerText,
          style: GoogleFonts.roboto(
            //textStyle: Theme.of(context).textTheme.headline1,
            fontSize: 20,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.normal,
            color: Colors.grey.shade500,
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Divider(
            color: Colors.black,
          ),
        )),
      ],
    ),
  );
}
