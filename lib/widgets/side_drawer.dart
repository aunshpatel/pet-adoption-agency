import 'package:flutter/material.dart';

import 'consts.dart';
class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kBackgroundColor,
      elevation: 20,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: ListView(
          children: [
            //Home Screen
            DrawerHeader(
              decoration: BoxDecoration(
                color: kBackgroundColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "The Pet Adoption Agency",
                    style: kSideMenuDarkTextStyle
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Find and adopt your pet here!",
                    style: kDarkAndW500Font
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: kDarkTitleColor, size: 30,),
              title:  const Wrap(
                children: [
                  Text('Home ', style:kSideMenuLightTextStyle),
                  Text('Page', style:kSideMenuDarkTextStyle,),
                ],
              ),
              onTap: (){
                Navigator.pushNamed(context, '/home_page');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.history, color: kDarkTitleColor, size:30,),
              title: const Wrap(
                children: [
                  Text('History ', style:kSideMenuLightTextStyle),
                  Text('Page', style:kSideMenuDarkTextStyle,),
                ],
              ),
              onTap: (){
                Navigator.pushNamed(context, '/history_page');
              },
            ),
          ],
        ),
      )
    );
  }
}
