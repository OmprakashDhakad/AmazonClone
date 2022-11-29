import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:myapp/constants/errorhandling.dart';
import 'package:myapp/constants/globalvariables.dart';
import 'package:myapp/constants/utils.dart';
import 'package:myapp/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
    // required List<Uint8List> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('opdhakad25', 'n4onwbck');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        // print('length---${images[i].first}');

        CloudinaryResponse res = await cloudinary.uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));

        // CloudinaryResponse res = await cloudinary.uploadFile(CloudinaryFile.fromBytesData(images[i],folder: name,));

        // print('length${images.length}');
        // print(res);
        imageUrls.add(res.secureUrl);
      }
      // for (int i = 0; i < images.length; i++) {
      //   print('length---${images.length}');

      //   CloudinaryResponse res = await cloudinary.uploadFile(CloudinaryFile.fromBytesData(images[i], folder: name));
      //   print('length${images.length}');
      //   print(res);
      //   imageUrls.add(res.secureUrl);
      // }
      // print('length${imageUrls.length}');
      // for (int i = 0; i < imageUrls.length; i++) {
      //   print(i);
      //   //imageUrls.add(res.secureUrl.toString());
      // }
      Product product = Product(name: name, description: description, quantity: quantity, images: imageUrls, category: category, price: price);
      //print(product);
      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product Added Successfully!');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-products'),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList.add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

// {
//   "name" : "Dreamerrr",
//   "price" : 20,
//   "description" : " hhshfkjwekfnkwenfkj",
//   "quantity" : 4,
//   "category":"Mobiles",
//   "images":["https://unsplash.com/photos/Ete0zMKPWys","https://unsplash.com/photos/Ete0zMKPWys"]
// }
