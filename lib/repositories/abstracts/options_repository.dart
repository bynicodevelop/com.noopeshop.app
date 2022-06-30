import 'package:com_noopeshop_app/models/option_model.dart';
import 'package:com_noopeshop_app/repositories/abstracts/media_repository_abstract.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class OptionsRepositoryAbstract extends MediaRepositoryAbstract {
  OptionsRepositoryAbstract({
    required FirebaseStorage firebaseStorage,
    required FirebaseAuth firebaseAuth,
  }) : super(
          firebaseStorage: firebaseStorage,
          firebaseAuth: firebaseAuth,
        );

  List<OptionModel> createOptions(
    Map<String, dynamic> varianteData,
  ) {
    final List<OptionModel> options = [];

    if (varianteData["type"] == "size") {
      options.addAll(Map<String, dynamic>.from(varianteData["optionId"])
          .entries
          .map((e) => OptionModel(
                key: e.key,
                value: e.value,
              ))
          .where((option) => option.value == true));
    } else if (varianteData["type"] == "customsize") {
      options.addAll(List<String>.from(varianteData["optionId"])
          .asMap()
          .entries
          .map((e) => OptionModel(
                key: e.key.toString(),
                value: e.value,
              )));
    }

    return options;
  }
}
