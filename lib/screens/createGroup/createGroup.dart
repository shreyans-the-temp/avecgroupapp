import 'package:avecgroupapp/services/database.dart';
import 'package:avecgroupapp/services/routes.dart';
import 'package:avecgroupapp/states/currentUser.dart';
import 'package:avecgroupapp/ui/colors.dart';
import 'package:avecgroupapp/ui/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  TextEditingController _nameController = TextEditingController();

//  TextEditingController _passwordController = TextEditingController();

  // bool controller = true;

  void _createGroup(BuildContext context, String groupName) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String? _result = await OurDatabase().createGroup(
        groupName: groupName, userId: _currentUser.getCurrentUser.uid);

    if (_result == "success") {
      _currentUser.getCurrentUser.groupId = OurDatabase.groupId;
      Navigator.pushNamedAndRemoveUntil(
          context, OurRoutes.rootId, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.arrowLeft),
          color: Colors.black,
          splashColor: themeBlueGreen,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  "assets/svg/social_friends.svg",
                  alignment: Alignment.topCenter,
                  height: MediaQuery.of(context).size.height * 0.33,
                  width: MediaQuery.of(context).size.width -
                      (MediaQuery.of(context).size.width * 0.25),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text("Create A Group", style: jcgHeading),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    FieldHeading("Enter Name"),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter name of group here",
                        ),
                        controller: _nameController,
                      ),
                    ),
                    // FieldHeading("Password"),
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                    //   child: TextFormField(
                    //     decoration: InputDecoration(
                    //         hintText: "Create A Group Password",
                    //         suffixIcon: IconButton(
                    //             icon: Icon(controller == true? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash),
                    //             onPressed: () {
                    //               setState(() {
                    //                 controller = !controller;
                    //               });
                    //             })),
                    //     obscureText: controller,
                    //     controller: _passwordController,
                    //   ),
                    // ),
                    SizedBox(
                      height: 25,
                    ),
                    TextButton(
                      onPressed: () =>
                          _createGroup(context, _nameController.text),
                      child: Text(
                        "Create",
                        style: jcgButton,
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(85, 10, 85, 10),
                        backgroundColor: themeBlueGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// TODO: Password Toggle: Change icon and obscureText via a bool value

class FieldHeading extends StatefulWidget {
  String display;

  FieldHeading(this.display);

  @override
  _FieldHeadingState createState() => _FieldHeadingState();
}

class _FieldHeadingState extends State<FieldHeading> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 8.0,
      ),
      child: Text(
        widget.display,
        style: loginStyle1,
      ),
    );
  }
}
