import 'package:flutter/material.dart';

class ContentInformationCard extends StatelessWidget {

  const ContentInformationCard({
    Key? key,
    this.title,
    this.subTitle,
    this.body
  }) : super(key: key);


  final String? title;
  final String? subTitle;
  final String? body;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
          minHeight: 400
      ),
      padding: EdgeInsets.all(32),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title == null ? ""  : title!,
                style: Theme.of(context).textTheme.titleLarge
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [

              Flexible(child: Text(
                body == null ? '' : body!,
                maxLines: 13,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ))

            ],
          )

        ],
      ),
    );
  }
}
