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
            SizedBox(
              width: 20,
              child: widget.player.starCard != null
                  ? Column(
                      children: [
                        const Icon(
                          Icons.star,
                          color: secondaryColor,
                        ),
                        Text('${widget.player.starCard}'),
                      ],
                    )
                  : Container(),
            ),
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Opacity(
                        opacity: 0.3,
                        child: SvgPicture.asset(
                          'assets/icons/shrimp.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Text(
                      '${widget.player.cardsLeft}',
                      style: const TextStyle(
                        fontFamily: 'BalooBhai',
                        fontSize: 28,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(
                  width: 60,
                  child: Text(
                    widget.player.name.toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'BalooBhai',
                      color: darkColor,
                      shadows: [Shadow(offset: Offset.infinite)],
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
