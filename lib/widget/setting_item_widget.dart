import 'package:flutter/material.dart';

class SettingItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onClick;
  SettingItemWidget({@required this.icon, @required this.title, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          onClick();
        },
        child: Container(
          // color: Colors.black12,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Row(
            children: <Widget>[
              Icon(icon, size: 20.0, color: Colors.white70),
              SizedBox(width: 16.0),
              Expanded(
                child: Text(title,
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal)),
              ),
              Icon(Icons.arrow_forward_ios, size: 16.0, color: Colors.white38)
            ],
          ),
        ),
      ),
    );
  }
}
