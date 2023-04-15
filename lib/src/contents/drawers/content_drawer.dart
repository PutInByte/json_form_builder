import 'package:flutter/material.dart';
import 'package:json_form_builder/src/contents/components/aside_information_card.dart';
import 'package:json_form_builder/src/contents/drawers/pager_drawer.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_grid/responsive_grid.dart';


class ContentDrawer extends StatefulWidget {

  const ContentDrawer({ Key? key }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ContentDrawerState();
}

class _ContentDrawerState extends State<ContentDrawer> {

  @override
  Widget build(BuildContext context) {

    DeviceScreenType deviceScreenType = getDeviceType(MediaQuery.of(context).size);
    bool isDesktop = deviceScreenType == DeviceScreenType.desktop;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        ResponsiveGridCol(
          lg: 7,
          md: 6,
          child: const PagerDrawer(),
        ),

        if (isDesktop)
          ResponsiveGridCol(
            lg: 4,
            md: 6,
            child: Container(
              margin: EdgeInsets.only(bottom: isDesktop ? 32.0 : 16.0, left: 32.0, top: 0),
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: BorderRadius.circular(8)),
              child: const AsideInformationCard(
                title: 'Информация',
                subTitle: "user?.fullName",
                body: 'С помощью данного электронного сервиса задекларируйте товары, валюту или транспортные средства, которые будут пересекать таможенную границу, распечатайте декларацию и предъявите сотруднику таможни.',
              ),
            )
          )

      ],
    );

  }


}
