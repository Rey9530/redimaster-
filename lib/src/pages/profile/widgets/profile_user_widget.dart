import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileUserWidget extends StatelessWidget {
  final String name;
  final String user;
  final String roll;
  const ProfileUserWidget({
    super.key,
    required this.name,
    required this.user,
    required this.roll,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Información del cliente"),
                Icon(
                  FontAwesomeIcons.userLarge,
                  size: 13,
                )
              ],
            ),
            const Divider(),
            Row(
              children: [
                const CircleAvatar(
                  radius: 35,
                  child: FaIcon(
                    FontAwesomeIcons.userLarge,
                    size: 35,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nombre: $name",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Usuario: $user",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Rol: $roll",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
