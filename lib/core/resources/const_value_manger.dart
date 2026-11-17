import 'package:drosak_app/core/resources/asset_value_manager.dart';
import 'package:drosak_app/model/explore/explore_model.dart';
import 'package:drosak_app/model/on_boarding/on_boarding_model.dart';

class ConstValue {
  static const String kText1 = "يمكنك إضافة  بعض المراحل التعليمية ";
  static const String kText2 =
      "يمكنك إضافة  بعض المجموعات لكل مرحلة من المراحل التعليمية";

  static const String kText3 =
      "يمكنك إضافة  بعض الطلاب لكل جروب الموجودة في كل مرحلة تعليمية";

  static const String kText4 = "يمكنك اضافة حضور وغياب لكل طالب";

  static const String kText5 =
      "يمكنك إضافة  ما إذا كان الطالب دفع هذا الشهر أم لا وإضافة تاريخ الدفع";

  static const String kExploreText1 = "المراحل التعليمية";
  static const String kExploreText2 = "المجموعات";
  static const String kExploreText3 = "الطلاب";
  static const String kExploreText4 = "الحضور";
  static const String kExploreText5 = "الدفع";
}

class ConstValueManger {
  static List<OnBoardingModel> listValue = [
    OnBoardingModel(
      text: ConstValue.kText1,
      image: AssetValueManager.kOnBoardingImage1,
    ),
    OnBoardingModel(
      text: ConstValue.kText2,
      image: AssetValueManager.kOnBoardingImage2,
    ),
    OnBoardingModel(
      text: ConstValue.kText3,
      image: AssetValueManager.kOnBoardingImage3,
    ),
    OnBoardingModel(
      text: ConstValue.kText4,
      image: AssetValueManager.kOnBoardingImage4,
    ),
    OnBoardingModel(
      text: ConstValue.kText5,
      image: AssetValueManager.kOnBoardingImage5,
    ),
  ];

  static List<ExploreModel> exploreListValue = [
    ExploreModel(
      text: ConstValue.kExploreText1,
      image: AssetValueManager.kOnBoardingImage1,
    ),
    ExploreModel(
      text: ConstValue.kExploreText2,
      image: AssetValueManager.kOnBoardingImage2,
    ),
    ExploreModel(
      text: ConstValue.kExploreText3,
      image: AssetValueManager.kOnBoardingImage3,
    ),
    ExploreModel(
      text: ConstValue.kExploreText4,
      image: AssetValueManager.kOnBoardingImage4,
    ),
    ExploreModel(
      text: ConstValue.kExploreText5,
      image: AssetValueManager.kOnBoardingImage5,
    ),
  ];

  static List<String> dayList = [
    "السبت",
    "الاحد",
    "الاتنين",
    "الثلاثاء",
    "الاربعاء",
    "الخميس",
    "الجمعة",
  ];
}
