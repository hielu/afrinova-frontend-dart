import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:uuid/uuid.dart';
import 'package:afrinova/utils/constants/colors.dart';
import 'models/product.dart';
import 'services/mock_service.dart';

// Wrapper class to handle the XFile type conflict
class ImageFile {
  final String path;
  ImageFile(this.path);

  static ImageFile? fromXFile(image_picker.XFile? xFile) {
    if (xFile == null) return null;
    return ImageFile(xFile.path);
  }
}

class ProductFormScreen extends StatefulWidget {
  final Product? product;

  const ProductFormScreen({super.key, this.product});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text controllers
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Categories
  final List<String> _categories = [
    'Clothing',
    'Electronics',
    'Home & Kitchen',
    'Beauty & Personal Care',
    'Toys & Games',
    'Sports & Outdoors',
    'Books',
    'Food & Beverages',
    'Other'
  ];
  String? _selectedCategory;

  // Active status
  bool _isActive = true;

  // Image handling
  ImageFile? _pickedImage;
  final image_picker.ImagePicker _picker = image_picker.ImagePicker();

  // Variant handling
  bool _hasVariants = false; // Toggle for variant support
  List<ProductVariant> _variants = [];
  final _variantNameController = TextEditingController();
  final _variantStockController = TextEditingController();
  bool _variantSectionExpanded = false;

  // Attributes
  List<MapEntry<String, String>> _attributes = [];
  final _attributeKeyController = TextEditingController();
  final _attributeValueController = TextEditingController();
  bool _attributeSectionExpanded = false;

  // Flags
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill form if editing existing product
    if (widget.product != null) {
      _nameController.text = widget.product!.name;
      _stockController.text = widget.product!.stock.toString();
      _priceController.text = widget.product!.price.toString();
      _descriptionController.text = widget.product!.description;
      _isActive = widget.product!.isActive;

      // Set category if it exists in our list
      _selectedCategory = widget.product!.category ?? _categories.last;

      // Set variants if available
      if (widget.product!.variants != null &&
          widget.product!.variants!.isNotEmpty) {
        _hasVariants = true;
        _variants = List.from(widget.product!.variants!);
        _variantSectionExpanded = true;
      }

      // Set attributes if available
      if (widget.product!.attributes != null &&
          widget.product!.attributes!.isNotEmpty) {
        _attributes = widget.product!.attributes!.entries.toList();
        _attributeSectionExpanded = true;
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _descriptionController.dispose();
    _variantNameController.dispose();
    _variantStockController.dispose();
    _attributeKeyController.dispose();
    _attributeValueController.dispose();
    super.dispose();
  }

  // Pick image from gallery or camera
  Future<void> _pickImage(image_picker.ImageSource source) async {
    try {
      final image_picker.XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _pickedImage = ImageFile(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Show image source selection dialog
  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Text(
              'Select Image Source',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageSourceOption(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(image_picker.ImageSource.gallery);
                  },
                ),
                _buildImageSourceOption(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(image_picker.ImageSource.camera);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSourceOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          color: TColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: TColors.primary,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    if (_pickedImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(
          File(_pickedImage!.path),
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.camera_alt,
            size: 48,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 8),
          Text(
            'Tap to add product image',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      );
    }
  }

  void _addVariant() {
    final name = _variantNameController.text.trim();
    final stockText = _variantStockController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Variant name cannot be empty'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (stockText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Variant stock cannot be empty'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final stock = int.tryParse(stockText);
    if (stock == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Variant stock must be a number'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _variants.add(
        ProductVariant(
          id: const Uuid().v4(),
          name: name,
          stock: stock,
        ),
      );
      _variantNameController.clear();
      _variantStockController.clear();
    });
  }

  void _removeVariant(String id) {
    setState(() {
      _variants.removeWhere((variant) => variant.id == id);
    });
  }

  void _addAttribute() {
    final key = _attributeKeyController.text.trim();
    final value = _attributeValueController.text.trim();

    if (key.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Attribute name cannot be empty'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _attributes.add(MapEntry(key, value));
      _attributeKeyController.clear();
      _attributeValueController.clear();
    });
  }

  void _removeAttribute(int index) {
    setState(() {
      _attributes.removeAt(index);
    });
  }

  void _updateAttribute(int index, String key, String value) {
    setState(() {
      _attributes[index] = MapEntry(key, value);
    });
  }

  // Handle form submission
  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final name = _nameController.text.trim();
      final stockText = _stockController.text.trim();
      final priceText = _priceController.text.trim();
      final description = _descriptionController.text.trim();

      final stock = int.tryParse(stockText) ?? 0;
      final price = double.tryParse(priceText) ?? 0.0;

      // This would be handled by a proper API in a real app
      // Using mocked image URL for now
      final imageUrl = _pickedImage?.path ??
          widget.product?.imageUrl ??
          'https://example.com/placeholder.jpg';

      // Only include variants if the feature is enabled and there are variants
      List<ProductVariant>? productVariants;
      if (_hasVariants && _variants.isNotEmpty) {
        productVariants = _variants;
      }

      // Only include attributes if there are any
      Map<String, String>? productAttributes;
      if (_attributes.isNotEmpty) {
        productAttributes = Map.fromEntries(_attributes);
      }

      final product = Product(
        id: widget.product?.id ?? const Uuid().v4(),
        name: name,
        imageUrl: imageUrl,
        stock: stock,
        price: price,
        description: description,
        category: _selectedCategory,
        isActive: _isActive,
        viewCount: widget.product?.viewCount ?? 0,
        soldCount: widget.product?.soldCount ?? 0,
        variants: productVariants,
        attributes: productAttributes,
      );

      if (widget.product != null) {
        await mockService.updateProduct(product);
      } else {
        await mockService.addProduct(product);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('${widget.product != null ? 'Updated' : 'Added'}: $name'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditing = widget.product != null;
    final title = isEditing ? 'Edit Product' : 'Add Product';

    return Scaffold(
      backgroundColor: TColors.light,
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: TColors.primary,
        foregroundColor: TColors.textWhite,
        elevation: 0,
        actions: [
          if (isEditing)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                // Show delete confirmation
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Product'),
                    content: const Text(
                      'Are you sure you want to delete this product? This action cannot be undone.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('CANCEL'),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context); // Close dialog
                          await mockService.deleteProduct(widget.product!.id);
                          if (mounted) {
                            Navigator.pop(context); // Close form screen
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Product deleted'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        style:
                            TextButton.styleFrom(foregroundColor: Colors.red),
                        child: const Text('DELETE'),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: _isLoading
              ? const LinearProgressIndicator(
                  backgroundColor: Colors.transparent,
                )
              : const SizedBox(height: 4),
        ),
      ),
      body: Stack(
        children: [
          // Top decorative container that extends from app bar
          Container(
            height: 20,
            decoration: const BoxDecoration(
              color: TColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image picker
                    Center(
                      child: GestureDetector(
                        onTap: _showImageSourceDialog,
                        child: Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                          child: _buildImagePreview(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Name field
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Product Name',
                        hintText: 'Enter product name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.shopping_bag),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a product name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Price and Stock fields in a row
                    Row(
                      children: [
                        // Price field
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: _priceController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Price',
                              hintText: 'Enter price',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixText: 'UGX ',
                              prefixIcon: const Icon(Icons.attach_money),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter a price';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Enter a valid price';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Stock field
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: _stockController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Stock',
                              hintText: 'Quantity',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: const Icon(Icons.inventory),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Enter stock';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Enter valid number';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Category dropdown
                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      decoration: InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.category),
                      ),
                      items: _categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Description field
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'Enter product description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(bottom: 60),
                          child: Icon(Icons.description),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a product description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Variants toggle
                    Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SwitchListTile(
                        title: const Text(
                          'This product has variants',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text(
                          'e.g., sizes, colors, styles',
                          style: TextStyle(fontSize: 14),
                        ),
                        value: _hasVariants,
                        onChanged: (value) {
                          setState(() {
                            _hasVariants = value;
                            if (value) {
                              _variantSectionExpanded = true;
                            }
                          });
                        },
                        secondary: Icon(
                          Icons.style,
                          color: _hasVariants ? TColors.primary : Colors.grey,
                        ),
                        activeColor: TColors.primary,
                      ),
                    ),

                    // Variants section (only show if _hasVariants is true)
                    if (_hasVariants) _buildVariantsSection(),

                    // Attributes section
                    _buildAttributesSection(),

                    // Active toggle
                    _buildActiveToggleSection(),

                    // Save button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Save Product',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Add this section for variants
  Widget _buildVariantsSection() {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  _variantSectionExpanded = !_variantSectionExpanded;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.style,
                        color: TColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Product Variants',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (_variants.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: TColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${_variants.length}',
                            style: const TextStyle(
                              color: TColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Icon(
                    _variantSectionExpanded
                        ? Icons.expand_less
                        : Icons.expand_more,
                    color: TColors.primary,
                  ),
                ],
              ),
            ),
            if (_variantSectionExpanded) ...[
              const SizedBox(height: 16),
              const Text(
                'Add variants for this product (e.g., size, color, style)',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: _variantNameController,
                      decoration: const InputDecoration(
                        labelText: 'Variant Name',
                        hintText: 'e.g., Small, Red, 256GB',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _variantStockController,
                      decoration: const InputDecoration(
                        labelText: 'Stock',
                        hintText: 'e.g., 10',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _addVariant,
                    icon: const Icon(Icons.add_circle),
                    color: TColors.primary,
                    tooltip: 'Add Variant',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (_variants.isEmpty)
                Center(
                  child: Text(
                    'No variants added yet',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _variants.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final variant = _variants[index];
                    return ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        variant.name,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text('Stock: ${variant.stock}'),
                      trailing: IconButton(
                        icon:
                            const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => _removeVariant(variant.id),
                        tooltip: 'Remove Variant',
                      ),
                    );
                  },
                ),
            ],
          ],
        ),
      ),
    );
  }

  // Add this section for attributes
  Widget _buildAttributesSection() {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  _attributeSectionExpanded = !_attributeSectionExpanded;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.format_list_bulleted,
                        color: TColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Additional Attributes',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (_attributes.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: TColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${_attributes.length}',
                            style: const TextStyle(
                              color: TColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Icon(
                    _attributeSectionExpanded
                        ? Icons.expand_less
                        : Icons.expand_more,
                    color: TColors.primary,
                  ),
                ],
              ),
            ),
            if (_attributeSectionExpanded) ...[
              const SizedBox(height: 16),
              const Text(
                'Add additional attributes for this product (e.g., material, brand, weight)',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _attributeKeyController,
                      decoration: const InputDecoration(
                        labelText: 'Attribute Name',
                        hintText: 'e.g., Material, Brand',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: _attributeValueController,
                      decoration: const InputDecoration(
                        labelText: 'Value',
                        hintText: 'e.g., Cotton, Nike',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _addAttribute,
                    icon: const Icon(Icons.add_circle),
                    color: TColors.primary,
                    tooltip: 'Add Attribute',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (_attributes.isEmpty)
                Center(
                  child: Text(
                    'No attributes added yet',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _attributes.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final attribute = _attributes[index];
                    return ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        attribute.key,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(attribute.value),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon:
                                const Icon(Icons.edit, color: TColors.primary),
                            onPressed: () {
                              _editAttribute(index, attribute);
                            },
                            tooltip: 'Edit Attribute',
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline,
                                color: Colors.red),
                            onPressed: () => _removeAttribute(index),
                            tooltip: 'Remove Attribute',
                          ),
                        ],
                      ),
                    );
                  },
                ),
            ],
          ],
        ),
      ),
    );
  }

  void _editAttribute(int index, MapEntry<String, String> attribute) {
    _attributeKeyController.text = attribute.key;
    _attributeValueController.text = attribute.value;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Attribute'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _attributeKeyController,
              decoration: const InputDecoration(
                labelText: 'Attribute Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _attributeValueController,
              decoration: const InputDecoration(
                labelText: 'Value',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _attributeKeyController.clear();
              _attributeValueController.clear();
            },
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              final key = _attributeKeyController.text.trim();
              final value = _attributeValueController.text.trim();

              if (key.isNotEmpty) {
                setState(() {
                  _updateAttribute(index, key, value);
                });
                Navigator.pop(context);
                _attributeKeyController.clear();
                _attributeValueController.clear();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Attribute name cannot be empty'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('SAVE'),
          ),
        ],
      ),
    );
  }

  // Add this section for active toggle
  Widget _buildActiveToggleSection() {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              _isActive ? Icons.visibility : Icons.visibility_off,
              color: _isActive ? TColors.primary : Colors.grey,
              size: 20,
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product Visibility',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Inactive products will be hidden from customers',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Switch(
              value: _isActive,
              onChanged: (value) {
                setState(() {
                  _isActive = value;
                });
              },
              activeColor: TColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
