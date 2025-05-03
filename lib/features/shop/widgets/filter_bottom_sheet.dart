import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:afrinova/utils/constants/colors.dart';

class FilterBottomSheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onApplyFilters;
  final String? currentCategory; // Current category context
  final Map<String, dynamic>? initialFilters; // Initial filter values

  const FilterBottomSheet({
    super.key,
    required this.onApplyFilters,
    this.currentCategory,
    this.initialFilters,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sort options
  String? _selectedSortOption;

  // Category selections
  final Map<String, bool> _selectedCategories = {
    'Sports': false,
    'Electronics': false,
    'Animals': false,
    'Laptop': false,
    'Cosmetics': false,
    'Shoes': false,
    'Clothes': false,
    'Jewellery': false,
    'Toys & kids': false,
    'Furniture': false,
    'Kitchen furniture': false,
    'Office furniture': false,
    'Bedroom furniture': false,
    'Shirts': false,
    'Groceries': false,
  };

  // Price range
  RangeValues _priceRange = const RangeValues(0, 1000);
  final double _minPrice = 0;
  final double _maxPrice = 1000;

  // Rating filter
  double _minRating = 0;

  // Brand selections
  final Map<String, bool> _selectedBrands = {
    'Apple': false,
    'Samsung': false,
    'Nike': false,
    'Adidas': false,
    'Sony': false,
    'LG': false,
    'Zara': false,
    'H&M': false,
  };

  // Age range for specific categories
  RangeValues _ageRange = const RangeValues(0, 18);
  final double _minAge = 0;
  final double _maxAge = 18;

  // Availability filter
  bool _inStockOnly = false;
  bool _onSaleOnly = false;
  bool _freeShippingOnly = false;

  // Search across all categories option
  bool _searchAllCategories = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);

    // Initialize with current category if provided
    if (widget.currentCategory != null) {
      _selectedCategories.forEach((key, value) {
        _selectedCategories[key] = key == widget.currentCategory;
      });
      _searchAllCategories = false;
    }

    // Apply initial filters if provided
    if (widget.initialFilters != null) {
      _applyInitialFilters();
    }
  }

  void _applyInitialFilters() {
    final filters = widget.initialFilters!;

    // Apply sort option
    if (filters.containsKey('sortBy')) {
      _selectedSortOption = filters['sortBy'];
    }

    // Apply category selections
    if (filters.containsKey('categories')) {
      final categories = filters['categories'] as List<dynamic>;
      _selectedCategories.forEach((key, value) {
        _selectedCategories[key] = categories.contains(key);
      });
    }

    // Apply price range
    if (filters.containsKey('priceRange')) {
      final priceRange = filters['priceRange'] as Map<String, dynamic>;
      _priceRange = RangeValues(
        priceRange['min'] as double,
        priceRange['max'] as double,
      );
    }

    // Apply rating
    if (filters.containsKey('minRating')) {
      _minRating = filters['minRating'] as double;
    }

    // Apply brand selections
    if (filters.containsKey('brands')) {
      final brands = filters['brands'] as List<dynamic>;
      _selectedBrands.forEach((key, value) {
        _selectedBrands[key] = brands.contains(key);
      });
    }

    // Apply age range
    if (filters.containsKey('ageRange')) {
      final ageRange = filters['ageRange'] as Map<String, dynamic>;
      _ageRange = RangeValues(
        ageRange['min'] as double,
        ageRange['max'] as double,
      );
    }

    // Apply availability filters
    if (filters.containsKey('availability')) {
      final availability = filters['availability'] as Map<String, dynamic>;
      _inStockOnly = availability['inStock'] as bool;
      _onSaleOnly = availability['onSale'] as bool;
      _freeShippingOnly = availability['freeShipping'] as bool;
    }

    // Apply search all categories option
    if (filters.containsKey('searchAllCategories')) {
      _searchAllCategories = filters['searchAllCategories'] as bool;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0A1A3B),
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: _resetFilters,
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                          color: TColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Context indicator if in a specific category
          if (widget.currentCategory != null && !_searchAllCategories)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: TColors.primary.withOpacity(0.1),
              child: Row(
                children: [
                  const Icon(Icons.filter_list,
                      color: TColors.primary, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'Filtering within ${widget.currentCategory}',
                    style: const TextStyle(
                      color: TColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Switch(
                    value: _searchAllCategories,
                    activeColor: TColors.primary,
                    onChanged: (value) {
                      setState(() {
                        _searchAllCategories = value;
                        if (!value && widget.currentCategory != null) {
                          // Reset to only current category
                          _selectedCategories.forEach((key, _) {
                            _selectedCategories[key] =
                                key == widget.currentCategory;
                          });
                        }
                      });
                    },
                  ),
                  Text(
                    'All Categories',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

          // Tab Bar
          TabBar(
            controller: _tabController,
            labelColor: TColors.primary,
            unselectedLabelColor: Colors.grey,
            indicatorColor: TColors.primary,
            tabs: const [
              Tab(text: 'Sort'),
              Tab(text: 'Category'),
              Tab(text: 'Price'),
              Tab(text: 'Brand'),
              Tab(text: 'More'),
            ],
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSortTab(),
                _buildCategoryTab(),
                _buildPriceTab(),
                _buildBrandTab(),
                _buildMoreFiltersTab(),
              ],
            ),
          ),

          // Apply button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: _applyFilters,
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Apply Filters',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Sort Tab
  Widget _buildSortTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sort by',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0A1A3B),
            ),
          ),
          const SizedBox(height: 16),

          // Sort options as radio buttons
          _buildSortOption('Newest'),
          const SizedBox(height: 8),
          _buildSortOption('Most Popular'),
          const SizedBox(height: 8),
          _buildSortOption('Lowest Price'),
          const SizedBox(height: 8),
          _buildSortOption('Highest Price'),
          const SizedBox(height: 8),
          _buildSortOption('Most Suitable'),
          const SizedBox(height: 8),
          _buildSortOption('Best Rated'),
          const SizedBox(height: 8),
          _buildSortOption('Best Selling'),
        ],
      ),
    );
  }

  // Category Tab
  Widget _buildCategoryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A1A3B),
                ),
              ),
              if (widget.currentCategory != null)
                Row(
                  children: [
                    Text(
                      'Search all',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                    Switch(
                      value: _searchAllCategories,
                      activeColor: TColors.primary,
                      onChanged: (value) {
                        setState(() {
                          _searchAllCategories = value;
                          if (!value && widget.currentCategory != null) {
                            // Reset to only current category
                            _selectedCategories.forEach((key, _) {
                              _selectedCategories[key] =
                                  key == widget.currentCategory;
                            });
                          }
                        });
                      },
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 16),

          // Category options as checkboxes
          Wrap(
            spacing: 8,
            runSpacing: 12,
            children: _selectedCategories.keys.map((category) {
              // If we're in a specific category and not searching all, disable other categories
              final isDisabled = widget.currentCategory != null &&
                  !_searchAllCategories &&
                  category != widget.currentCategory;

              return _buildCategoryOption(
                category,
                isDisabled: isDisabled,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Price Tab
  Widget _buildPriceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Price Range',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0A1A3B),
            ),
          ),
          const SizedBox(height: 24),

          // Price slider
          RangeSlider(
            values: _priceRange,
            min: _minPrice,
            max: _maxPrice,
            divisions: 20,
            activeColor: TColors.primary,
            inactiveColor: Colors.grey.shade300,
            labels: RangeLabels(
              '\$${_priceRange.start.round()}',
              '\$${_priceRange.end.round()}',
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _priceRange = values;
              });
            },
          ),

          // Price range display
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${_priceRange.start.round()}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${_priceRange.end.round()}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Quick price range buttons
          const Text(
            'Quick Select',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0A1A3B),
            ),
          ),
          const SizedBox(height: 16),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildPriceRangeButton('Under \$50', 0, 50),
              _buildPriceRangeButton('\$50 - \$100', 50, 100),
              _buildPriceRangeButton('\$100 - \$200', 100, 200),
              _buildPriceRangeButton('\$200 - \$500', 200, 500),
              _buildPriceRangeButton('Over \$500', 500, _maxPrice),
            ],
          ),
        ],
      ),
    );
  }

  // Brand Tab
  Widget _buildBrandTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Brands',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0A1A3B),
            ),
          ),
          const SizedBox(height: 16),

          // Search brands
          TextField(
            decoration: InputDecoration(
              hintText: 'Search brands',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),

          const SizedBox(height: 16),

          // Brand options as checkboxes
          ..._selectedBrands.entries.map((entry) {
            return CheckboxListTile(
              title: Text(
                entry.key,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: entry.value ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              value: entry.value,
              activeColor: TColors.primary,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  _selectedBrands[entry.key] = value ?? false;
                });
              },
            );
          }),
        ],
      ),
    );
  }

  // More Filters Tab
  Widget _buildMoreFiltersTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rating section
          const Text(
            'Rating',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0A1A3B),
            ),
          ),
          const SizedBox(height: 16),

          // Rating options
          _buildRatingOption(4),
          const SizedBox(height: 8),
          _buildRatingOption(3),
          const SizedBox(height: 8),
          _buildRatingOption(2),
          const SizedBox(height: 8),
          _buildRatingOption(1),

          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),

          // Availability section
          const Text(
            'Availability',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0A1A3B),
            ),
          ),
          const SizedBox(height: 16),

          // Availability options
          SwitchListTile(
            title: const Text('In Stock Only'),
            value: _inStockOnly,
            activeColor: TColors.primary,
            contentPadding: EdgeInsets.zero,
            onChanged: (bool value) {
              setState(() {
                _inStockOnly = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('On Sale'),
            value: _onSaleOnly,
            activeColor: TColors.primary,
            contentPadding: EdgeInsets.zero,
            onChanged: (bool value) {
              setState(() {
                _onSaleOnly = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Free Shipping'),
            value: _freeShippingOnly,
            activeColor: TColors.primary,
            contentPadding: EdgeInsets.zero,
            onChanged: (bool value) {
              setState(() {
                _freeShippingOnly = value;
              });
            },
          ),

          // Age range for specific categories (e.g., Kids, Toys)
          if (_isCategorySelected('Toys & kids'))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),
                const Text(
                  'Age Range',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0A1A3B),
                  ),
                ),
                const SizedBox(height: 16),
                RangeSlider(
                  values: _ageRange,
                  min: _minAge,
                  max: _maxAge,
                  divisions: 18,
                  activeColor: TColors.primary,
                  inactiveColor: Colors.grey.shade300,
                  labels: RangeLabels(
                    '${_ageRange.start.round()} yrs',
                    '${_ageRange.end.round()} yrs',
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _ageRange = values;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_ageRange.start.round()} years',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${_ageRange.end.round()} years',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSortOption(String option) {
    final isSelected = _selectedSortOption == option;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedSortOption = option;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Radio(
              value: option,
              groupValue: _selectedSortOption,
              activeColor: TColors.primary,
              onChanged: (value) {
                setState(() {
                  _selectedSortOption = value as String;
                });
              },
            ),
            const SizedBox(width: 8),
            Text(
              option,
              style: TextStyle(
                color: isSelected ? TColors.primary : Colors.grey[800],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryOption(String category, {bool isDisabled = false}) {
    final isSelected = _selectedCategories[category] ?? false;

    return GestureDetector(
      onTap: isDisabled
          ? null
          : () {
              setState(() {
                _selectedCategories[category] = !isSelected;
              });
            },
      child: Opacity(
        opacity: isDisabled ? 0.5 : 1.0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? TColors.primary : Colors.grey.shade300,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isSelected)
                Container(
                  width: 16,
                  height: 16,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: TColors.primary,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 12,
                    color: Colors.white,
                  ),
                ),
              Text(
                category,
                style: TextStyle(
                  color: isSelected ? TColors.primary : Colors.grey.shade700,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRangeButton(String label, double min, double max) {
    final isSelected = _priceRange.start == min && _priceRange.end == max;

    return GestureDetector(
      onTap: () {
        setState(() {
          _priceRange = RangeValues(min, max);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? TColors.primary.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? TColors.primary : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? TColors.primary : Colors.grey.shade700,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildRatingOption(int rating) {
    final isSelected = _minRating == rating;

    return InkWell(
      onTap: () {
        setState(() {
          _minRating = rating.toDouble();
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Radio(
              value: rating.toDouble(),
              groupValue: _minRating,
              activeColor: TColors.primary,
              onChanged: (value) {
                setState(() {
                  _minRating = value as double;
                });
              },
            ),
            const SizedBox(width: 8),
            Row(
              children: [
                ...List.generate(5, (index) {
                  return Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: index < rating ? Colors.amber : Colors.grey,
                    size: 20,
                  );
                }),
                const SizedBox(width: 8),
                Text(
                  '& Up',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool _isCategorySelected(String category) {
    return _selectedCategories[category] ?? false;
  }

  void _resetFilters() {
    setState(() {
      _selectedSortOption = null;

      // Reset categories but respect current context
      _selectedCategories.forEach((key, value) {
        _selectedCategories[key] = widget.currentCategory != null &&
            !_searchAllCategories &&
            key == widget.currentCategory;
      });

      _priceRange = RangeValues(_minPrice, _maxPrice);
      _minRating = 0;

      _selectedBrands.forEach((key, value) {
        _selectedBrands[key] = false;
      });

      _ageRange = RangeValues(_minAge, _maxAge);
      _inStockOnly = false;
      _onSaleOnly = false;
      _freeShippingOnly = false;
    });
  }

  void _applyFilters() {
    // Collect all selected categories
    final List<String> selectedCategories = _selectedCategories.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    // Collect all selected brands
    final List<String> selectedBrands = _selectedBrands.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    // Create filter map
    final Map<String, dynamic> filters = {
      'sortBy': _selectedSortOption,
      'categories': selectedCategories,
      'priceRange': {
        'min': _priceRange.start,
        'max': _priceRange.end,
      },
      'minRating': _minRating,
      'brands': selectedBrands,
      'availability': {
        'inStock': _inStockOnly,
        'onSale': _onSaleOnly,
        'freeShipping': _freeShippingOnly,
      },
      'searchAllCategories': _searchAllCategories,
    };

    // Add age range if applicable
    if (_isCategorySelected('Toys & kids')) {
      filters['ageRange'] = {
        'min': _ageRange.start,
        'max': _ageRange.end,
      };
    }

    // Pass filters back to parent
    widget.onApplyFilters(filters);

    // Close the bottom sheet
    Get.back();
  }
}
