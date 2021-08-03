import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/product_provider.dart';

class EditeScreen extends StatefulWidget {
  static const routeName = '/edit-screen';
  @override
  _EditeScreenState createState() => _EditeScreenState();
}

class _EditeScreenState extends State<EditeScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: 'm',
    title: '',
    description: '',
    price: 0.0,
    imageUrl: '',
    isShirt: false,
    isJean: false,
    isPan: false,
    isScarf: false,
  );
  var _initValues = {
    'title': '',
    'price': '',
    'discription': '',
    'imageUrl': '',
  };
  var _isInit = true;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      if (productId.length > 2) {
        _editedProduct = Provider.of<ProductProvider>(context, listen: false)
            .findById(productId);
        _initValues = {
          'title': _editedProduct.title as String,
          'price': _editedProduct.price.toString(),
          'discription': _editedProduct.description as String,
          // 'imageUrl': _editedProduct.imageUrl as String,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl as String;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if ((_imageUrlController.text.isEmpty) ||
        (!_imageUrlController.text.startsWith('http') &&
            !_imageUrlController.text.startsWith('https')) ||
        (!_imageUrlController.text.endsWith('.png') &&
            !_imageUrlController.text.endsWith('.jpeg') &&
            !_imageUrlController.text.endsWith('.jpg'))) {
      return;
    } else {
      if (!_imageUrlFocusNode.hasFocus) {
        setState(() {});
      }
    }
  }

  void _saveForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    if (_editedProduct.id!.length > 2) {
      Provider.of<ProductProvider>(context, listen: false)
          .updateProduct(_editedProduct.id as String, _editedProduct);
    } else {
      Provider.of<ProductProvider>(context, listen: false)
          .addProduct(_editedProduct);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Products'),
        actions: [
          ElevatedButton(
            onPressed: _saveForm,
            child: Text('Save'),
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValues['title'],
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    isFavorate: _editedProduct.isFavorate,
                    title: value,
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                    isShirt: _editedProduct.isShirt,
                    isJean: _editedProduct.isJean,
                    isPan: _editedProduct.isPan,
                    isScarf: _editedProduct.isScarf,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['price'],
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide your price.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please provide valid price.';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please provide a price that be above ziro.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    isFavorate: _editedProduct.isFavorate,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    price: double.parse(value as String),
                    imageUrl: _editedProduct.imageUrl,
                    isShirt: _editedProduct.isShirt,
                    isJean: _editedProduct.isJean,
                    isPan: _editedProduct.isPan,
                    isScarf: _editedProduct.isScarf,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['discription'],
                decoration: InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a discription.';
                  }
                  if (value.length < 10) {
                    return 'Please discribe more.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    isFavorate: _editedProduct.isFavorate,
                    title: _editedProduct.title,
                    description: value,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                    isShirt: _editedProduct.isShirt,
                    isJean: _editedProduct.isJean,
                    isPan: _editedProduct.isPan,
                    isScarf: _editedProduct.isScarf,
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(width: 3, color: Colors.grey),
                    ),
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(top: 15, right: 10),
                    alignment: Alignment.topCenter,
                    child: _imageUrlController.text.isEmpty
                        ? Text(
                            'Enter your image url',
                            textAlign: TextAlign.center,
                          )
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide image URL.';
                        }
                        if (!value.startsWith('http') &&
                            !value.startsWith('https')) {
                          return 'Please provide a valid image URL.';
                        }
                        if (!value.endsWith('.png') &&
                            !value.endsWith('.jpeg') &&
                            !value.endsWith('.jpg')) {
                          return 'Please provide a image URL with image format.';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        _updateImageUrl();
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          isFavorate: _editedProduct.isFavorate,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: value,
                          isShirt: _editedProduct.isShirt,
                          isJean: _editedProduct.isJean,
                          isPan: _editedProduct.isPan,
                          isScarf: _editedProduct.isScarf,
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
