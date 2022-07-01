import 'package:com_noopeshop_app/models/option_model.dart';
import 'package:com_noopeshop_app/repositories/abstracts/options_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';

class SampleOptionsRepository extends OptionsRepositoryAbstract {
  SampleOptionsRepository(
    FirebaseStorage firebaseStorage,
    FirebaseAuth firebaseAuth,
  ) : super(
          firebaseStorage: firebaseStorage,
          firebaseAuth: firebaseAuth,
        );
}

void main() {
  group("OptionsRepositoryAbstract.createOptions", () {
    test("Should return an array with size type option (1)", () {
      final SampleOptionsRepository sampleOptionsRepository =
          SampleOptionsRepository(
        FirebaseStorage.instance,
        FirebaseAuth.instance,
      );

      expect(
          sampleOptionsRepository.createOptions({
            "type": "size",
            "optionId": {
              "s": true,
              "m": false,
              "l": false,
              "xl": false,
            },
          }),
          [
            const OptionModel(key: "s", value: true),
          ]);
    });

    test("Should return an array with size type option (2)", () {
      final SampleOptionsRepository sampleOptionsRepository =
          SampleOptionsRepository(
        FirebaseStorage.instance,
        FirebaseAuth.instance,
      );

      expect(
          sampleOptionsRepository.createOptions({
            "type": "size",
            "optionId": {
              "s": true,
              "m": true,
              "l": false,
              "xl": false,
            },
          }),
          [
            const OptionModel(key: "s", value: true),
            const OptionModel(key: "m", value: true),
          ]);
    });

    test("Should return an array with size type option (3)", () {
      final SampleOptionsRepository sampleOptionsRepository =
          SampleOptionsRepository(
        FirebaseStorage.instance,
        FirebaseAuth.instance,
      );

      expect(
          sampleOptionsRepository.createOptions({
            "type": "customsize",
            "optionId": [
              "200x300",
              "300x400",
            ],
          }),
          [
            const OptionModel(key: "0", value: "200x300"),
            const OptionModel(key: "1", value: "300x400"),
          ]);
    });
  });
}
