import 'package:flutter/material.dart';

class ForgetPasswordButtonWidget extends StatelessWidget {
  const ForgetPasswordButtonWidget({
    super.key,
    required this.btnIcon,
    required this.title,
    required this.subTitle,
    required this.onClick
  });
  final IconData btnIcon;
  final String title, subTitle;
  final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: onClick,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: isDarkMode ? Color(0xFF27374D): Color(0xFF9DB2BF),


          ),
          child: Row(
            children: [
              Icon(btnIcon,size: 60.0,),
              const SizedBox(width: 10.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,style: Theme.of(context).textTheme.headlineSmall),
                  Text(subTitle, style: Theme.of(context).textTheme.bodySmall),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}