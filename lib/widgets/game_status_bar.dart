import 'package:flutter/material.dart';
import 'package:mindmerge/constants/colours.dart';

class GameStatusBar extends StatelessWidget {
  final int level;
  final int hearts;
  final int stars;
  final int numPlayersVotingStar;
  final void Function()? onStarPressed;

  const GameStatusBar({
    required this.level,
    required this.hearts,
    required this.stars,
    required this.numPlayersVotingStar,
    required this.onStarPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Level $level'.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'BalooBhai',
            fontSize: 36,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 50,
          child: Row(
            children: [
              const Icon(
                Icons.favorite,
              ),
              const SizedBox(width: 10),
              Text(
                '$hearts',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        InkWell(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ElevatedButton(
                onPressed: onStarPressed,
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '$hearts',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              if (numPlayersVotingStar > 0)
                Positioned(
                  top: -5,
                  right: -5,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$numPlayersVotingStar',
                      style: const TextStyle(
                        fontSize: 12,
                        color: lightColor,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
