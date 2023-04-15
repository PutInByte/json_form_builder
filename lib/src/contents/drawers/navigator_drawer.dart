import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_form_builder/src/controllers/json_form_controller.dart';
import 'package:json_form_builder/src/controllers/navigator_controller.dart';
import 'package:json_form_builder/src/controllers/pager_controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NavigatorDrawer extends StatelessWidget {

  const NavigatorDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final PagerController pagerController = Provider.of<JsonFormController>(context, listen: false).pagerController;

    DeviceScreenType deviceScreenType = getDeviceType(MediaQuery.of(context).size);

    bool isMobile = !(deviceScreenType == DeviceScreenType.tablet || deviceScreenType == DeviceScreenType.desktop);

    double containerHeight = isMobile ? 68.0 : 80.0;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxHeight: containerHeight),
      height: containerHeight,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 24),
      color: const Color.fromRGBO(242, 243, 243, 1),
      child: ChangeNotifierProvider<NavigatorController>.value(
        value: pagerController.navigator,
        child: Consumer<NavigatorController>(
          builder: (context, navigatorController, _) {
            return Row(
              mainAxisAlignment: isMobile ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [

                Flexible(
                  child: TextButton(
                      onPressed: () {

                        if (!navigatorController.canNavigatePrev) return;

                        pagerController.changePage(next: false);

                      },
                      style: ButtonStyle(
                        minimumSize: const MaterialStatePropertyAll(Size(48, 48)),
                        maximumSize: const MaterialStatePropertyAll(Size(203, 48)),
                        overlayColor: MaterialStateProperty.all<Color>(isMobile ? Theme.of(context).colorScheme.primary : Colors.white12),
                        backgroundColor: MaterialStateProperty.all<Color>(isMobile ? Colors.transparent : Theme.of(context).colorScheme.primary),
                        shape: isMobile ? MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1,
                            ),
                          ),
                        ) : null,
                      ),
                      child: getPrevChild(context, navigatorController, isMobile),
                    )
                ),


                const SizedBox(width: 10),
                // if (!isMobile) ...[
                //   SizedBox(width: gapSize),
                //
                //   Expanded(
                //     flex:  0,
                //     child: TextButton(
                //       onPressed: controller.save,
                //       style: ButtonStyle(
                //         backgroundColor: MaterialStatePropertyAll(Theme.of(context).drawerTheme.backgroundColor),
                //         minimumSize: MaterialStatePropertyAll(const Size(203, 48)),
                //         maximumSize: MaterialStatePropertyAll(const Size(203, 48)),
                //         overlayColor: MaterialStateProperty.all<Color>(Colors.white12),
                //       ),
                //       child: Row(
                //         mainAxisSize: MainAxisSize.min,
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //
                //           Flexible(
                //             child: FittedBox(
                //               fit: BoxFit.fitWidth,
                //               child: const Text(
                //                 'Сохранить и выйти',
                //                 maxLines: 1,
                //                 style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                //               ),
                //             ),
                //           ),
                //
                //
                //           if (controller.saveProcessing) ...[
                //             const SizedBox(width: 12),
                //             const SizedBox(
                //               height: 16,
                //               width: 16,
                //               child: ColorFiltered(
                //                 colorFilter: ColorFilter.mode(
                //                   Colors.white,
                //                   BlendMode.srcATop,
                //                 ),
                //                 child: CupertinoActivityIndicator(),
                //               ),
                //             )
                //           ]
                //
                //         ],
                //       ),
                //     ),
                //   ),
                //
                //   SizedBox(width: gapSize),
                // ],

                // if (controller.nextHided)
                //   const SizedBox(width: 80,),
                //
                // if (!controller.nextHided)

                Flexible(
                  child: TextButton(
                      onPressed: () {

                        if (!navigatorController.canNavigateNext) return;

                        pagerController.changePage(next: true);

                      },
                      style: ButtonStyle(
                        minimumSize: const MaterialStatePropertyAll(Size(48, 48)),
                        maximumSize: const MaterialStatePropertyAll(Size(203, 48)),
                        overlayColor: MaterialStateProperty.all<Color>(Colors.white12),
                        backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
                        shape: isMobile ? MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ) : null,
                      ),
                      child: getNextChild(context, navigatorController, isMobile),
                    )
                )


              ],
            );
          }
        ),
      ),
    );

  }


  Widget getPrevChild(context, NavigatorController controller, bool isMobile) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [

         Flexible(
          child: Text(
            'Назад',
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),

        // if (controller.processing) ...[
        //   const SizedBox(width: 12),
        //   const SizedBox(
        //     height: 16,
        //     width: 16,
        //     child: ColorFiltered(
        //       colorFilter: ColorFilter.mode(
        //         Colors.white,
        //         BlendMode.srcATop,
        //       ),
        //       child: CupertinoActivityIndicator(),
        //     ),
        //   )
        // ]

      ],
    );
  }

  Widget getNextChild(context, NavigatorController controller, bool isMobile) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        const Flexible(
          child: Text(
            "Вперед",
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),

        if (controller.processing) ...[
          const SizedBox(width: 12),
          const SizedBox(
            height: 16,
            width: 16,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.white,
                BlendMode.srcATop,
              ),
              child: CupertinoActivityIndicator(),
            ),
          )
        ]

      ],
    );
  }


}

