import 'package:flutter/material.dart';
import '../../../../strings/string_size.dart';
import '../../models/model_on_boarding.dart';

class OnBoardingPageWidget extends StatelessWidget {

  const OnBoardingPageWidget({super.key, required this.model});
  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(tDefaultSize),
      color:model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(image: AssetImage(model.image), height: size.height * 0.3,),
          Column(
            children: [
              Text(model.title, style: Theme.of(context).textTheme.headlineMedium,),
              Divider(thickness: 4.0,),
              SizedBox(height: 10.0,),
              Text(model.subTitle,textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodySmall,),
            ],
          ),
          Text(model.counterText, style: Theme.of(context).textTheme.titleMedium,),
          const SizedBox(height: 50.0,)
        ],
      ),
    );
  }
}