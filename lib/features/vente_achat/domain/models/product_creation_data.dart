import 'package:image_picker/image_picker.dart';

class ProductCreationData {
  final List<XFile> photos;
  final String      name;
  final int         price;
  final String      description;
  final String      categoryUuid;
  final String      categoryName;
  final String      location;
  final String      condition;
  final String                  shopUuid;
  final Map<String, dynamic>?   features;
  final int                     stock;

  const ProductCreationData({
    required this.photos,
    required this.name,
    required this.price,
    required this.description,
    required this.categoryUuid,
    required this.categoryName,
    required this.location,
    required this.condition,
    required this.shopUuid,
    this.features,
    this.stock = 1,
  });
}
