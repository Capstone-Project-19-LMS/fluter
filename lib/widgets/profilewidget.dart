import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String title;
  const ProfileWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.black26,
            size: 18,
          )
        ],
      ),
    );
  }
}
