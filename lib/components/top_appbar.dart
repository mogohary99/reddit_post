import 'package:flutter/material.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Text(
            'MechanicalKeyboards',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        //Spacer(),
        Icon(
          Icons.more_vert_outlined,
          color: Colors.white,
        ),
      ],
    );
  }
}
