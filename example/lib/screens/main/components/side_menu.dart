import 'package:e_angel_game_admin_flutter/common/env.dart';
import 'package:flutter/material.dart';
import 'package:web3_example/controllers/menu_controller.dart';
import 'package:web3_example/controllers/auth_controller.dart';
import 'package:web3_example/models/menu_model.dart';
import 'package:web3_example/shared/constants.dart';
import 'package:web3_example/shared/responsive.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../common/env.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String flavor = IS_ENV == PROD ? PROD.toUpperCase() : DEV.toUpperCase();
    String version = IS_ENV == PROD ? PROD_VERSION : DEV_VERSION;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Container(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  children:[
                    TextSpan(
                      text: "$flavor ", style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold,
                      )),
                    TextSpan(
                        text: version , style: TextStyle(
                      color: Colors.white54, fontWeight: FontWeight.bold,
                    )),
                  ]
                ),
              ),
            ),
          ),
          Consumer<MenuController>(
            builder: (context, menuController, child) => DrawerListTile(listOfModel: menuController.menuModelList),
          )
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.listOfModel,
  }) : super(key: key);

  final List<MenuModel> listOfModel;

  @override
  Widget build(BuildContext context) {
    List<Widget> ListOfListTile = [];
    for (int i = 0; i < listOfModel.length; i++) {
      ListOfListTile.add(InkWell(
        hoverColor: Colors.grey.withOpacity(0.3),
        child: Container(
          color: listOfModel[i].isselected! ? Colors.grey.withOpacity(0.3) : secondaryColor,
          child: ListTile(
            selected: true,
            selectedColor: Colors.grey.shade400,
            onTap: () async {
              context.read<MenuController>().onChangeSelectedMenu(i);
              if (Responsive.isMobile(context) ||
                  Responsive.isBigMobile(context) ||
                  Responsive.isTablet(context)) Navigator.pop(context);
              // if (i != listOfModel.length) {
              //   context.read<MenuController>().onChangeSelectedMenu(i);
              //   if (Responsive.isMobile(context) ||
              //       Responsive.isBigMobile(context) ||
              //       Responsive.isTablet(context)) Navigator.pop(context);
              // }
              // else {
              //   context.read<AuthController>().SignOut().then((value) {
              //       context.read<MenuController>().buildMenu();
              //     });
              // }
            },
            horizontalTitleGap: 0.0,
            leading: SvgPicture.asset(
              listOfModel[i].svgSrc!,
              color: Colors.white54,
              height: 16,
            ),
            title: Text(
              listOfModel[i].title!,
              style: const TextStyle(color: Colors.white54),
            ),
          ),
        ),
      ));
    }
    return Column(
      children: [...ListOfListTile],
    );
  }
}

