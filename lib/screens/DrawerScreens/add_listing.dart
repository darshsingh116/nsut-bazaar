import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:nsutbazaar/constants/purpleTheme.dart';
import 'package:nsutbazaar/models/SellProductModel.dart';
import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsutbazaar/repositories/firebase_storage_repo.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_bloc.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_event.dart';
import 'package:nsutbazaar/screens/DrawerScreens/my_listings.dart';
import 'package:nsutbazaar/utils/product_firestore.dart';
import 'package:nsutbazaar/screens/BottomNavBarScreens/listings/bloc/listings_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nsutbazaar/widgets/core/backgroundContainer.dart';

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
  int _contactNumber = 0;
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

  String? selectedCategory;

  late TextEditingController contactNumberController;
 
   @override
  void initState() {
    super.initState();
    final authRepository = context.read<FirebaseRepository>();
    contactNumberController = TextEditingController(
      text: authRepository.userModel.phoneNumber.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authRepository = context.read<FirebaseRepository>();
    final productFirestore =
        new ProductFirestore(authRepository.firebaseFirestore);

    final firebaseStoreageRepo = context.read<FirebaseStorageRepo>();




    return backgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Add Listing'),
          backgroundColor: Colors.transparent,
        ),
        body: WillPopScope(
          onWillPop: () async {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => MyListings()),
            // );

            return true;
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          'Product Name',
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 36, 28,
                                  41), // Set background color to gray
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                  color: Color.fromARGB(
                                      255, 74, 56, 87)) // Set border radius
                              ),
                          child: Center(
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: ' Ex: Gaming Mouse',
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 176, 153, 189),
                                    fontSize:
                                        16.sp), // Set hint text color to white
                                border: InputBorder
                                    .none, // Remove border from input decoration
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0), // Set content padding
                              ),
                              style: TextStyle(
                                  color:
                                      Colors.white), // Set text color to white
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
                          ),
                        ),
                        Text(
                          'Price',
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 36, 28, 41),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: Color.fromARGB(255, 74, 56, 87),
                            ),
                          ),
                          child: Center(
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Enter Price',
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 176, 153, 189),
                                  fontSize: 16.sp,
                                ),
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16.0),
                              ),
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.white),
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
                          ),
                        ),
                        SizedBox(height: 20.h), // Add spacing between fields
                        Text(
                          'Contact Number',
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 36, 28, 41),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: Color.fromARGB(255, 74, 56, 87),
                            ),
                          ),
                          child: Center(
                            child: TextFormField(
                              controller: contactNumberController,
                              decoration: InputDecoration(
                                hintText: 'Enter Contact Number',
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 176, 153, 189),
                                  fontSize: 16.sp,
                                ),
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16.0),
                              ),
                              keyboardType: TextInputType.phone,
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter contact number';
                                }
                                // You can add additional validation logic for contact number format here if needed
                                return null;
                              },
                              onSaved: (value) {
                                _contactNumber = int.parse(value!);
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h), // Add spacing between fields
                        Text(
                          'Description',
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          height:
                              110.h, // Increase height for description field
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 36, 28, 41),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: Color.fromARGB(255, 74, 56, 87),
                            ),
                          ),
                          child: TextFormField(
                            maxLines: 3, // Allow multiple lines for description
                            decoration: InputDecoration(
                              hintText: 'Enter Description',
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 176, 153, 189),
                                fontSize: 16.sp,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 12.0), // Adjust vertical padding
                            ),
                            style: TextStyle(color: Colors.white),
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
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        DropdownButton<String>(
                          value: selectedCategory,
                          focusColor: Colors.white,
                          icon:
                              Icon(Icons.arrow_drop_down, color: Colors.white),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.white),
                          dropdownColor: Colors.purple,
                          underline: Container(
                            height: 2,
                            color: Colors.white,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCategory = newValue;
                              print(
                                  selectedCategory); // Ensure that selectedCategory is updated
                            });
                          },
                          items: <String>[
                            'Books',
                            'Sports',
                            'Academic Tool',
                            'Others'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                        ),

                        SizedBox(
                          height: 10.h,
                        ),
                        GestureDetector(
                          child: SizedBox(
                            height: 55.h,
                            child: Row(
                              children: [
                                Container(
                                  height: 40.h,
                                  width: 40.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        8.r), // Set border radius
                                    color: Color.fromARGB(255, 36, 28,
                                        41), // Set background color
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(0, 0, 2.w, 2.h),
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Colors.white,
                                      size: 24.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16.w,
                                ),
                                SizedBox(
                                  width: 260.w,
                                  child: Text(
                                    (file == null)
                                        ? "Upload Photo"
                                        : path.basename(file!.path),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0),
                                    overflow: TextOverflow
                                        .ellipsis, // Wrap the text if it's too long
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () async {
                            final tempfile = await pickMedia(
                              cropImage: cropSquareImage,
                            );
                            print("check2");
                            print(tempfile);
                            setState(() {
                              file = tempfile;
                            });
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 50.h),
                      child: SizedBox(
                          height: 48.h,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              String? imgUrl = null;
                              print(
                                  "~~~~~~~~~~~~~~~~~~~1~~~~~~~~~~~~~~~~~~${selectedCategory}");
                              if (file != null) {
                                imgUrl =
                                    await firebaseStoreageRepo.uploadImageFile(
                                        file!, authRepository.userModel);
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();

                                  DateTime now = DateTime.now();
                                  int timestamp = now.millisecondsSinceEpoch;
                                  bool isBooks = false;
                                  bool isSports = false;
                                  bool isAcademicTool = false;
                                  bool isOthers = false;
                                  print(
                                      "~~~~~~~~~~~~~~~~~~~2~~~~~~~~~~~~~~~~~~${selectedCategory}");

                                  if (selectedCategory == 'Books') {
                                    isBooks = true;
                                  } else if (selectedCategory ==
                                      'Academic Tool') {
                                    isAcademicTool = true;
                                  } else if (selectedCategory == 'Sports') {
                                    isSports = true;
                                  } else {
                                    isOthers = true;
                                  }
                                  SellProductModel product = SellProductModel(
                                      spid: authRepository.userModel.uid +
                                          timestamp.toString(),
                                      userid: authRepository.userModel.uid,
                                      productName: _productName,
                                      price: _price,
                                      description: _description,
                                      imageUrl: imgUrl!,
                                      contactNumber: _contactNumber,
                                      isBooks: isBooks,
                                      isAcademicTool: isAcademicTool,
                                      isOthers: isOthers,
                                      isSports: isSports,
                                      timestamp: timestamp.toString());

                                  productFirestore.addSellProduct(product);
                                  Navigator.pop(context);
                                  context
                                      .read<ListingsBloc>()
                                      .emit(ListingsStateInitial());
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: PurpleTheme
                                  .ButtonLightPurpleColor, // Set button background color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    12.r), // Set border radius
                              ),
                            ),
                            child: Text(
                              'Post',
                              style: TextStyle(
                                color: Colors.white, // Set text color to white
                                fontSize: 16.sp, // Set text size
                                fontWeight:
                                    FontWeight.bold, // Set text weight to bold
                              ),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
