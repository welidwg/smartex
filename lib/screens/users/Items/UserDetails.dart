import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartex/Api/users/UsersRequestManager.dart';
import 'package:smartex/components/Button.dart';
import 'package:smartex/components/CustomDropdown.dart';
import 'package:smartex/components/Input.dart';
import 'package:smartex/components/Loading.dart';
import 'package:smartex/constants.dart';

class UserDetails extends StatefulWidget {
  Map<String, dynamic> user = {};
  late Function? updateView;

  UserDetails({super.key, required this.user,this.updateView});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  late int selectedRole =0;
  late Map<int, dynamic> roles = {};
  TextEditingController username = TextEditingController();
  TextEditingController newPass = TextEditingController();
  UsersRequestManager manager = UsersRequestManager();
  bool isLoading=false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    roles[0] = "Administrateur";
    roles[1] = "Technicien";
    selectedRole=widget.user["role"];
    username=TextEditingController(text: widget.user["username"]);
  }
  _setRole(int value) {
    setState(() {
      selectedRole = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person,
              color: kPrimaryColor,
            ),
            Text(
              widget.user['username'],
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
            controller: username,
            onChange: (value) {}),
        const SizedBox(
          height: 8,
        ),
        Input(
            label: "Nouveau Mot de passe",
            is_Password: true,
            controller: newPass,
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
            CustomDropdown(items: roles, defaultItem: selectedRole,setter: _setRole,),
            const SizedBox(
              height: 8,
            ),
            isLoading ? Center(child: LoadingComponent()) :
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: MyActionButton(
                      isLoading: isLoading,
                  label: "",
                  color: kPrimaryColor,
                  icon: Icons.save_as,
                      onPressed: ()async{
                        setState(() {
                          isLoading=true;
                        });
                        await _saveUserData(context);
                      },
                )),
                const SizedBox(
                  width: 10,
                ),
                MyActionButton(
                  label: "",
                  isLoading: isLoading,
                  color: Colors.pink,
                  icon: Icons.delete_sweep,
                  onPressed: ()async{
                    setState(() {
                      isLoading=true;
                    });
                    await _deleteUser(context);
                  },
                )
              ],
            )
          ],
        )
      ],
    );
  }
  _deleteUser(BuildContext context)async{
    Map<String,dynamic> data={
      "id":widget.user["id"],
    };
    var res=await manager.deleteUser(data);
    if (res['type'] == "success") {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res['message'])));
      widget.updateView!();
      setState(() {
        isLoading=false;
      });

    } else {
      print(res['message']);
    }

  }
  _saveUserData(BuildContext context)async{
    Map<String,dynamic> data={
      "id":widget.user["id"],
      "username":username.text,
      "newPass":newPass.text,
      "role":selectedRole
    };
    var res=await manager.editUser(data);
    if (res['type'] == "success") {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res['message'])));
      widget.updateView!();

    } else {
      print(res['message']);
    }
    setState(() {
      isLoading=false;
    });
  }
}
