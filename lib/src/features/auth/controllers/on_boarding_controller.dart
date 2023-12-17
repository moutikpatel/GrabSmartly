import 'package:get/get.dart';
import 'package:grabsmartly/src/features/auth/screen/home_page/home_page.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import '../../../strings/string_images.dart';
import '../../../strings/string_text.dart';
import '../../../strings/string_colors.dart';
import '../models/model_on_boarding.dart';
import '../screen/on_boarding_screen/on_boarding_widget.dart';

class OnBoardingController extends GetxController{
  final controller = LiquidController();
  RxInt currentPage = 0.obs;

  final tPages = [
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: tOnBoardingImage1,
        title: tOnBoardingTitle1,
        subTitle: tOnBoardingSubTitle1,
        counterText: tOnBoardingCounter1,
        bgColor: tOnBoardingPage_1,
        //height: size.height,
      ),
    ),
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: tOnBoardingImage2,
        title: tOnBoardingTitle2,
        subTitle: tOnBoardingSubTitle2,
        counterText: tOnBoardingCounter2,
        bgColor: tOnBoardingPage_2,
        //height: size.height,
      ),
    ),
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: tOnBoardingImage3,
        title: tOnBoardingTitle3,
        subTitle: tOnBoardingSubTitle3,
        counterText: tOnBoardingCounter3,
        bgColor: tOnBoardingPage_3,
        //height: size.height,
      ),
    ),
  ];

  onPageChangedCallBack(int activePageIndex) => currentPage.value = activePageIndex;
  animateToNextSlide() {
    int nextPage = controller.currentPage + 1;
    controller.animateToPage(page: nextPage);
    if(nextPage == 3){
      callHomePage();
    }
  }
  skip() => controller.jumpToPage(page: 2);
  Future callHomePage() async{

    await Future.delayed(const Duration(milliseconds: 200));
    Get.to(const HomePage());

  }

}