import 'dart:async';
import 'dart:io';

import 'package:drosak_app/core/Database/sqflite/education_stage_data_base.dart';
import 'package:drosak_app/model/education/education_model.dart';
import 'package:drosak_app/view/education/widgets/bottom_sheet/custom_bottom_sheet.dart';
import 'package:drosak_app/view/education/widgets/dialog/show_dialog_of_pick.dart';
import 'package:drosak_app/view/education/widgets/search/custom_list_search.dart';
import 'package:drosak_app/view/education/widgets/search/custom_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class EducationController {
  List<EducationModel> listEducatin = [];
  TextEditingController educationStageNameController = TextEditingController();
  TextEditingController educationStageDescController = TextEditingController();
  EducationStageDataBase educationStageDataBase = EducationStageDataBase();
  String? pathImage;
  late StreamController<List<EducationModel>> listEducationstreamcontroller;
  late Sink<List<EducationModel>> listEducationInput;
  late Stream<List<EducationModel>> listEducationOutput;
  late StreamController<String?> imageController;
  late Sink<String?> imageInput;
  late Stream<String?> imageOutput;
  GlobalKey<FormState> formKey = GlobalKey();

  EducationController() {
    getAllEducation();
    init();
  }

  init() {
    listEducationstreamcontroller = StreamController();
    listEducationInput = listEducationstreamcontroller.sink;
    listEducationOutput = listEducationstreamcontroller.stream
        .asBroadcastStream();
    listEducationInput.add(listEducatin);
    imageController = StreamController();
    imageInput = imageController.sink;
    imageOutput = imageController.stream.asBroadcastStream();
    imageInput.add(pathImage);
  }

  dispose() {
    listEducationstreamcontroller.close();
    listEducationInput.close();
    imageController.close();
    imageInput.close();
    educationStageNameController.dispose();
    educationStageDescController.dispose();
  }

  pickImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image = await picker.pickImage(source: imageSource);
    if (image?.path != null) {
      pathImage = image!.path;
      saveCopyImageInApp(image);
    }
    imageInput.add(pathImage);
  }

  saveCopyImageInApp(XFile image) async {
    Directory directory = await getApplicationDocumentsDirectory();

    String directoryPath = directory.path;
    String finalPath = "$directoryPath/${image.name}";
    File fileImage = await File(image.path).copy(finalPath);
    pathImage = fileImage.path;
  }

  educationshowModalSheet(BuildContext context) {
    educationStageDescController.clear;
    educationStageNameController.clear;
    pathImage == null;

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        print("Keyboard height: ${MediaQuery.of(context).viewInsets.bottom}");

        return CustomBottomSheet(
          formKey: formKey,
          imagePath: pathImage,
          educationStageNameController: educationStageNameController,
          educationStageDescController: educationStageDescController,
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              await addNewEducation();

              await getAllEducation();
              Navigator.pop(context);
              educationStageNameController.clear();
              educationStageDescController.clear();
            }
          },
          pickonPressed: () {
            showDialogOfPickImage(
              context: context,
              onPressedPickCamera: () {
                pickImage(ImageSource.camera);
              },
              onPressedPickGallery: () {
                pickImage(ImageSource.gallery);
              },
            );
          },
          removeOnPressed: () {
            pathImage = null;
            imageInput.add(pathImage);
            Navigator.pop(context);
          },
          outPut: imageOutput,
        );
      },
    );
  }

  Future<bool> addNewEducation() async {
    EducationStageDataBase educationStageDataBase = EducationStageDataBase();
    bool inserted = await educationStageDataBase.insertToEducation(
      EducationModel(
        image: pathImage == null ? " " : pathImage!,
        title: educationStageNameController.text,
        subTitle: educationStageDescController.text,
      ),
    );
    return inserted;
  }

  Future<List<EducationModel>> getAllEducation() async {
    EducationStageDataBase educationStageDataBase = EducationStageDataBase();
    List<EducationModel> data = await educationStageDataBase
        .selectFromEducation();
    listEducatin = data;

    listEducationInput.add(listEducatin);
    print(listEducatin);

    return listEducatin;
  }

  showSeacrh(BuildContext context) {
    showSearch(
      context: context,
      delegate: CustomSearch(
        myBuildResult: (query) {
          EducationStageDataBase educationStageDataBase =
              EducationStageDataBase();
          Future<List<EducationModel>> data = educationStageDataBase.getSearch(
            query,
          );
          return CustomListSearch(
            searchList: data,
            deleteFun: (EducationModel ed) => delete(ed),
            editFun: (EducationModel educationModel) {
              return editItem(context, educationModel);
            },
          );
        },
      ),
    );
  }

  Future<bool> delete(EducationModel ed) async {
    bool delete = await educationStageDataBase.softDelete(ed);
    listEducatin.removeWhere((e) => e.id == ed.id);
    print(listEducatin);
    print(delete);
    return delete;
  }

  editItem(BuildContext context, EducationModel educationModel) async {
    educationStageNameController.text = educationModel.title;
    educationStageDescController.text = educationModel.subTitle;
    pathImage = educationModel.image;
    imageInput.add(pathImage);

    showModalBottomSheet(
      isScrollControlled: true,

      context: context,
      builder: (context) {
        print("Keyboard height: ${MediaQuery.of(context).viewInsets.bottom}");

        return CustomBottomSheet(
          edit: true,
          formKey: formKey,
          imagePath: pathImage,
          educationStageNameController: educationStageNameController,
          educationStageDescController: educationStageDescController,
          onPressed: () async {
            await onPressedEdit(educationModel, context);
          },
          pickonPressed: () {
            showDialogOfPickImage(
              context: context,
              onPressedPickCamera: () {
                pickImage(ImageSource.camera);
              },
              onPressedPickGallery: () {
                pickImage(ImageSource.gallery);
              },
            );
          },
          removeOnPressed: () {
            pathImage = null;
            imageInput.add(pathImage);
            Navigator.pop(context);
          },
          outPut: imageOutput,
        );
      },
    );
  }

  Future onPressedEdit(
    EducationModel educationalModel,
    BuildContext context,
  ) async {
    if (formKey.currentState!.validate()) {
      bool edit = await update(educationalModel);

      if (edit) {
        int index = listEducatin.indexWhere((e) => e.id == educationalModel.id);

        if (index != -1) {
          listEducatin[index] = EducationModel(
            id: educationalModel.id, // نفس الـ ID
            image: pathImage ?? educationalModel.image,
            title: educationStageNameController.text,
            subTitle: educationStageDescController.text,
          );
        }

        Navigator.pop(context);
      }
    }
  }

  Future<bool> update(EducationModel educationalModel) async {
    EducationStageDataBase educationStageDataBase = EducationStageDataBase();
    bool edit = await educationStageDataBase.edit(
      EducationModel(
        id: educationalModel.id,
        image: pathImage == null ? "" : pathImage!,
        title: educationStageNameController.text,
        subTitle: educationStageDescController.text,
      ),
    );
    print(edit);
    return edit;
  }
}
