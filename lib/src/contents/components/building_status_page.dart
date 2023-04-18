import 'package:flutter/cupertino.dart';


class BuildingStatusPage extends StatelessWidget {

  const BuildingStatusPage({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [

          Text( "Пожалуйста, подождите пока идет отрисовка страницы", textAlign: TextAlign.center ),

          SizedBox( height: 16 ),

          CupertinoActivityIndicator( )

        ],
      ),
    );


  }
}
