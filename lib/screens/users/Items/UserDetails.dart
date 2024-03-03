import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomDropdown.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/constants.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  String? selectedRole = 'Technicien';

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.person,
              color: kPrimaryColor,
            ),
            Text(
              "Username",
              style: kTitleTextStyle(
                  customFontSize:
                      width > kMobileWidth ? kTabletFont - 2 : kMobileFont),
            )
          ],
        ),
        const SizedBox(
          height: 7,
        ),
        Input(
            label: "Nom d'utilisateur",
            is_Password: false,
            value: "Username",
            onChange: (value) {}),
        const SizedBox(
          height: 8,
        ),
        Input(
            label: "Nouveau Mot de passe",
            is_Password: true,
            onChange: (value) {}),
        const SizedBox(
          height: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Sélectionnez un role :',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: width > kMobileWidth ? 18 : 13),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const CustomDropdown(
                items: ['Administrateur', 'Technicien'],
                defaultItem: 'Administrateur'),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: MyActionButton(
                  label: "",
                  color: kPrimaryColor,
                  icon: Icons.save_as,
                )),
                const SizedBox(
                  width: 10,
                ),
                MyActionButton(
                  label: "",
                  color: Colors.pink,
                  icon: Icons.delete_sweep,
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
