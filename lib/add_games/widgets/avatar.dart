import 'package:flutter/material.dart';
import 'package:ping_pong/constants.dart';

const _avatarSize = 100.0;

class Avatar extends StatelessWidget {
  const Avatar({Key? key, this.photo}) : super(key: key);

  final String? photo;

  @override
  Widget build(BuildContext context) {
    final photo = this.photo;
    return const Icon(
      Icons.person_rounded,
      size: _avatarSize,
      color: avatarsGreenColor,
    );
  }
}
