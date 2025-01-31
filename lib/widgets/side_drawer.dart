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
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            //Home Screen
            SizedBox(
              height: 40,
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: kBlackColor,
                  )
                )
              ),
              child: ListTile(
                title: const Wrap(
                  children: [
                    Text('Welcome to the ', style:kSideMenuLightTextStyle),
                    Text('Pet Adoption Center App', style:kSideMenuDarkTextStyle,),
                  ],
                ),
              ),
            ),
            //Home Screen
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: kBlackColor,
                  )
                )
              ),
              child: ListTile(
                title: const Wrap(
                  children: [
                    Text('Home ', style:kSideMenuLightTextStyle),
                    Text('Page', style:kSideMenuDarkTextStyle,),
                  ],
                ),
                onTap: (){
                  Navigator.pushNamed(context, '/home_page');
                },
              ),
            ),
            //All Listings
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: kBlackColor,
                      )
                  )
              ),
              child: ListTile(
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
            ),
          ],
        ),
      )
    );
  }
}
