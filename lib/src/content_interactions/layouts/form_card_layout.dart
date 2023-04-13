import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';


class FormCardLayout extends StatelessWidget {

  const FormCardLayout({
    Key? key,
    required this.children,
    this.title,
    this.responsive = false,
    this.hasBottomTitle = true,
    this.hasBottomMargin = false
  }) : super(key: key);


  final String? title;
  final bool hasBottomTitle;
  final bool responsive;
  final bool hasBottomMargin;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {

    DeviceScreenType deviceScreenType = getDeviceType(MediaQuery.of(context).size);
    final double size = (deviceScreenType == DeviceScreenType.mobile) ? 16.0 : 32.0;

    return Container(
      constraints: BoxConstraints(
        minHeight: responsive ? 0.0 : 400.0,
      ),
      margin: EdgeInsets.only(bottom: hasBottomMargin ? size : 0),
      padding: EdgeInsets.all(size),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 14,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          if (title != null)
            ...[
              Text(
                title!,
                maxLines: 4,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: hasBottomTitle ? size : 0)
            ],

          ...children

        ],
      ),
    );

  }
}
