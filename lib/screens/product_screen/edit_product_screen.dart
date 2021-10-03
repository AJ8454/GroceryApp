import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/provider/product_provider.dart';
import 'package:grocery_app/utility/constant.dart';
import 'package:grocery_app/widget/snack_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  File? _image;
  var _isLoading = false;
  final FocusScopeNode _node = FocusScopeNode();
  final _form = GlobalKey<FormState>();

  var _editProduct = Product(
    id: null,
    title: '',
    description: '',
    rate: 0.0,
    imageUrl: '',
  );

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    await uploadImage();
    await Provider.of<ProductProvider>(context, listen: false)
        .addProduct(_editProduct)
        .then(
          (_) => SnackBarWidget.showSnackBar(
            context,
            'Product Saved',
          ),
        );

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Add/Update',
          style: kAppbarTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () => _submitForm(),
            icon: const Icon(FontAwesomeIcons.save),
          )
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      FocusScope(
                        node: _node,
                        child: Form(
                          key: _form,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    children: [
                                      TextFormField(
                                        decoration: const InputDecoration(
                                            labelText: 'Title'),
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: _node.nextFocus,
                                        onSaved: (value) {
                                          _editProduct = Product(
                                            title: value!,
                                            id: _editProduct.id,
                                            description:
                                                _editProduct.description,
                                            imageUrl: _editProduct.imageUrl,
                                            rate: _editProduct.rate,
                                          );
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter a title.';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        decoration: const InputDecoration(
                                            labelText: 'Price'),
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: _node.nextFocus,
                                        keyboardType: TextInputType.number,
                                        onSaved: (value) {
                                          _editProduct = Product(
                                            title: _editProduct.title,
                                            id: _editProduct.id,
                                            description:
                                                _editProduct.description,
                                            imageUrl: _editProduct.imageUrl,
                                            rate: double.parse(value!),
                                          );
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter price.';
                                          }

                                          return null;
                                        },
                                      ),
                                    ],
                                  )),
                                  Expanded(
                                    child: SizedBox(
                                      height: 150,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () => _showPicker(context),
                                            child: CircleAvatar(
                                              radius: 55,
                                              backgroundColor: Colors.grey[200],
                                              child: _image != null
                                                  ? ClipOval(
                                                      child: Image.file(
                                                        _image!,
                                                        width: 100,
                                                        height: 100,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )
                                                  : SizedBox(
                                                      width: 100,
                                                      height: 100,
                                                      child: SvgPicture.asset(
                                                        'assets/icons/camera.svg',
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Product Image',
                                            style: TextStyle(
                                              color: kGreyColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Description'),
                                textInputAction: TextInputAction.next,
                                onEditingComplete: _node.nextFocus,
                                onSaved: (value) {
                                  _editProduct = Product(
                                    title: _editProduct.title,
                                    id: _editProduct.id,
                                    description: value,
                                    imageUrl: _editProduct.imageUrl,
                                    rate: _editProduct.rate,
                                  );
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a description.';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 25),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 40),
                                  elevation: 8,
                                  shape: const StadiumBorder(),
                                ),
                                onPressed: () => _submitForm(),
                                child: const Text(
                                  'save',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Photo Library'),
              onTap: () {
                _imgFromGallery();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Camera'),
              onTap: () {
                _imgFromCamera();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  _imgFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 40,
      );
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => _image = imageTemporary);
    } catch (e) {
      rethrow;
    }
  }

  _imgFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 40,
      );
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => _image = imageTemporary);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> uploadImage() async {
    if (_image != null) {
      String? fileName = _image!.path.split('/').last;
      Reference ref = FirebaseStorage.instance.ref().child(fileName);
      await ref.putFile(_image!);
      String? _imageUrl = await ref.getDownloadURL();
      _editProduct = Product(
        title: _editProduct.title,
        id: _editProduct.id,
        description: _editProduct.description,
        imageUrl: _imageUrl,
        rate: _editProduct.rate,
      );
    }
  }
}
