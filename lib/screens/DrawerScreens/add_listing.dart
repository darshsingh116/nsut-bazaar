import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:nsutbazaar/models/ProductModel.dart';
import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsutbazaar/repositories/firebase_storage_repo.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_bloc.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_event.dart';
import 'package:nsutbazaar/utils/product_firestore.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_state.dart';
import 'package:image_picker/image_picker.dart';

class AddListingScreen extends StatefulWidget {
  const AddListingScreen({Key? key}) : super(key: key);

  @override
  _AddListingScreenState createState() => _AddListingScreenState();
}

class _AddListingScreenState extends State<AddListingScreen> {
  final _formKey = GlobalKey<FormState>();

  String _productName = '';
  double _price = 0.0;
  String _description = '';
  File? file = null;

  Future<File?> cropSquareImage(File imageFile) async {
    await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [CropAspectRatioPreset.square],
      compressQuality: 70,
      compressFormat: ImageCompressFormat.jpg,
      androidUiSettings: androidUiSettingsLocked(),
      iosUiSettings: iosUiSettingsLocked(),
    );
  }

  IOSUiSettings iosUiSettingsLocked() => IOSUiSettings(
        rotateClockwiseButtonHidden: false,
        rotateButtonsHidden: false,
      );

  AndroidUiSettings androidUiSettingsLocked() => AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.red,
        toolbarWidgetColor: Colors.white,
        hideBottomControls: true,
      );

  Future<File?> pickMedia({
    required Future<File?> Function(File file) cropImage,
  }) async {
    final source = ImageSource.camera;
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile == null) return null;
    final file = File(pickedFile.path);
    final crop = await cropImage(file);
    print("huehue");
    print(crop);
    if (crop == null) {
      return File(pickedFile.path);
    } else {
      // Create an instance of the state class
      return crop; // Call cropImage on the instance
    }
  }

  @override
  Widget build(BuildContext context) {
    final authRepository = context.read<FirebaseRepository>();
    final productFirestore =
        new ProductFirestore(authRepository.firebaseFirestore);

    final firebaseStoreageRepo = context.read<FirebaseStoreageRepo>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Listing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _productName = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  return null;
                },
                onSaved: (value) {
                  _price = double.parse(value!);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    final tempfile = await pickMedia(
                      cropImage: cropSquareImage,
                    );
                    print("check2");
                    print(tempfile);
                    setState(() {
                      file = tempfile;
                    });
                  },
                  child: const Text('+'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    String? imgUrl = null;
                    if (file != null) {
                      imgUrl =
                          await firebaseStoreageRepo.uploadImageFile(file!);
                    }
                    print(imgUrl);

                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      // Create ProductModel instance
                      ProductModel product = ProductModel(
                        userid: authRepository.userModel.uid,
                        productName: _productName,
                        price: _price,
                        description: _description,
                      );

                      productFirestore.addSellProduct(product);
                    }

                    // Optionally, you can navigate back to previous screen
                    Navigator.pop(context);
                    context.read<ListingsBloc>().emit(ListingsStateInitial());
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
