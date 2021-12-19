import 'package:flutter/material.dart';
import 'package:mindmerge/models/player.dart';

class OtherPlayerStatus extends StatefulWidget {
  Player player;

  OtherPlayerStatus({
    required this.player,
    Key? key,
  }) : super(key: key);

  @override
  State<OtherPlayerStatus> createState() => _OtherPlayerStatusState();
}

class _OtherPlayerStatusState extends State<OtherPlayerStatus> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Row(
        children: [
          if (widget.player.starCard != null)
            Column(
              children: [
                Icon(
                  Icons.star,
                ),
                Text('${widget.player.starCard}'),
              ],
            ),
        ],
      ),
    );
  }
}
