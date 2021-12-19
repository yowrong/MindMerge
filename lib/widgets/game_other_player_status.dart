import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindmerge/constants/colours.dart';
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
      width: 100,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.player.starCard != null)
              Column(
                children: [
                  const Icon(
                    Icons.star,
                    color: secondaryColor,
                  ),
                  Text('${widget.player.starCard}'),
                ],
              ),
            const SizedBox(width: 5),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: lightColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Opacity(
                    opacity: 0.5,
                    child: SvgPicture.asset(
                      'assets/icons/shrimp.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  child: Text(
                    widget.player.name.toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'BalooBhai',
                      color: secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
