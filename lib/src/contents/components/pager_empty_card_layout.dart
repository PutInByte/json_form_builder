import 'package:flutter/material.dart';
import 'package:json_form_builder/src/contents/components/pager_card_layout.dart';

class PagerEmptyCardLayout extends StatelessWidget {

  const PagerEmptyCardLayout({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return PagerCardLayout(
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [

              Text(
                "Oops, что-то пошло не так!",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),

              SizedBox(height: 8),

              Text(
                  "No data found",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal
                  ),
              ),

            ],
          )

        ]
    );

  }
}
