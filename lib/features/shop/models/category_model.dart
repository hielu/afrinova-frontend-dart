import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryModel {
  final String name;
  final IconData icon;
  final String imageUrl;
  final List<SubcategoryModel> subcategories;
  final Color color;
  final int productCount;

  CategoryModel({
    required this.name,
    required this.icon,
    required this.imageUrl,
    required this.subcategories,
    required this.color,
    required this.productCount,
  });

  static List<CategoryModel> getCategories() {
    return [
      CategoryModel(
        name: 'Electronics',
        icon: FontAwesomeIcons.laptop,
        imageUrl:
            'https://images.unsplash.com/photo-1498049794561-7780e7231661?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        color: Colors.blue,
        productCount: 1200,
        subcategories: [
          SubcategoryModel(
            name: 'Smartphones & Accessories',
            productCount: 320,
            imageUrl:
                'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Computers & Laptops',
            productCount: 250,
            imageUrl:
                'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Audio & Headphones',
            productCount: 180,
            imageUrl:
                'https://images.unsplash.com/photo-1546435770-a3e426bf472b?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'TVs & Home Entertainment',
            productCount: 150,
            imageUrl:
                'https://images.unsplash.com/photo-1593784991095-a205069470b6?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Cameras & Photography',
            productCount: 120,
            imageUrl:
                'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Wearable Technology',
            productCount: 80,
            imageUrl:
                'https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Gaming & Consoles',
            productCount: 60,
            imageUrl:
                'https://images.unsplash.com/photo-1580327344181-c1163234e5a0?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Smart Home Devices',
            productCount: 40,
            imageUrl:
                'https://images.unsplash.com/photo-1558002038-bb0237f4e204?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
        ],
      ),
      CategoryModel(
        name: 'Groceries',
        icon: FontAwesomeIcons.cartShopping,
        imageUrl:
            'https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        color: Colors.green,
        productCount: 800,
        subcategories: [
          SubcategoryModel(
            name: 'Fresh Produce',
            productCount: 150,
            imageUrl:
                'https://images.unsplash.com/photo-1610348725531-843dff563e2c?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Dairy & Eggs',
            productCount: 120,
            imageUrl:
                'https://images.unsplash.com/photo-1488477181946-6428a0291777?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Meat & Seafood',
            productCount: 100,
            imageUrl:
                'https://images.unsplash.com/photo-1607623814075-e51df1bdc82f?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Bakery & Bread',
            productCount: 90,
            imageUrl:
                'https://images.unsplash.com/photo-1509440159596-0249088772ff?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Pantry Staples',
            productCount: 130,
            imageUrl:
                'https://images.unsplash.com/photo-1536304993881-ff6e9eefa2a6?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Snacks & Confectionery',
            productCount: 110,
            imageUrl:
                'https://images.unsplash.com/photo-1621939514649-280e2ee25f60?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Beverages',
            productCount: 80,
            imageUrl:
                'https://images.unsplash.com/photo-1595981267035-7b04ca84a82d?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Frozen Foods',
            productCount: 70,
            imageUrl:
                'https://images.unsplash.com/photo-1574484284002-952d92456975?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
        ],
      ),
      CategoryModel(
        name: 'Fashion',
        icon: FontAwesomeIcons.shirt,
        imageUrl:
            'https://images.unsplash.com/photo-1445205170230-053b83016050?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        color: Colors.purple,
        productCount: 2500,
        subcategories: [
          SubcategoryModel(
            name: 'Tops & T-shirts',
            productCount: 400,
            imageUrl:
                'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Pants & Bottoms',
            productCount: 350,
            imageUrl:
                'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Dresses & Jumpsuits',
            productCount: 300,
            imageUrl:
                'https://images.unsplash.com/photo-1496747611176-843222e1e57c?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Outerwear & Jackets',
            productCount: 250,
            imageUrl:
                'https://images.unsplash.com/photo-1551488831-00ddcb6c6bd3?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Activewear & Sportswear',
            productCount: 200,
            imageUrl:
                'https://images.unsplash.com/photo-1518459031867-a89b944bffe4?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Underwear & Sleepwear',
            productCount: 150,
            imageUrl:
                'https://images.unsplash.com/photo-1617331721458-bd3bd3f9c7f8?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Footwear',
            productCount: 500,
            imageUrl:
                'https://images.unsplash.com/photo-1549298916-b41d501d3772?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Accessories',
            productCount: 350,
            imageUrl:
                'https://images.unsplash.com/photo-1584917865442-de89df76afd3?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
        ],
      ),
      CategoryModel(
        name: 'Home & Kitchen',
        icon: FontAwesomeIcons.house,
        imageUrl:
            'https://images.unsplash.com/photo-1556911220-bda9f7f7597e?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        color: Colors.orange,
        productCount: 1800,
        subcategories: [
          SubcategoryModel(
            name: 'Kitchen Appliances',
            productCount: 300,
            imageUrl:
                'https://images.unsplash.com/photo-1556909114-44e3e9699e2b?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Cookware & Bakeware',
            productCount: 250,
            imageUrl:
                'https://images.unsplash.com/photo-1556909212-d5b604d0c90d?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Dining & Tableware',
            productCount: 200,
            imageUrl:
                'https://images.unsplash.com/photo-1603199506016-b9a594b593c0?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Bedroom & Bedding',
            productCount: 280,
            imageUrl:
                'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Bathroom Essentials',
            productCount: 220,
            imageUrl:
                'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Living Room Furniture',
            productCount: 180,
            imageUrl:
                'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Home Decor',
            productCount: 250,
            imageUrl:
                'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Storage & Organization',
            productCount: 120,
            imageUrl:
                'https://images.unsplash.com/photo-1520981825232-ece5fae45120?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
        ],
      ),
      CategoryModel(
        name: 'Beauty & Personal Care',
        icon: FontAwesomeIcons.sprayCan,
        imageUrl:
            'https://images.unsplash.com/photo-1596462502278-27bfdc403348?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        color: Colors.pink,
        productCount: 950,
        subcategories: [
          SubcategoryModel(
            name: 'Skincare',
            productCount: 180,
            imageUrl:
                'https://images.unsplash.com/photo-1556228720-195a672e8a03?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Haircare',
            productCount: 150,
            imageUrl:
                'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Makeup & Cosmetics',
            productCount: 200,
            imageUrl:
                'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Fragrances',
            productCount: 120,
            imageUrl:
                'https://images.unsplash.com/photo-1592945403244-b3fbafd7f539?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Bath & Body',
            productCount: 100,
            imageUrl:
                'https://images.unsplash.com/photo-1570194065650-d99fb4d8a609?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Oral Care',
            productCount: 80,
            imageUrl:
                'https://images.unsplash.com/photo-1559589311-5f3ebe9d6f15?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Men\'s Grooming',
            productCount: 70,
            imageUrl:
                'https://images.unsplash.com/photo-1581071275949-3a40b9f8ba51?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Health & Wellness',
            productCount: 50,
            imageUrl:
                'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
        ],
      ),
      CategoryModel(
        name: 'Toys & Kids',
        icon: FontAwesomeIcons.gamepad,
        imageUrl:
            'https://images.unsplash.com/photo-1566576912321-d58ddd7a6088?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        color: Colors.red,
        productCount: 750,
        subcategories: [
          SubcategoryModel(
            name: 'Baby Essentials',
            productCount: 120,
            imageUrl:
                'https://images.unsplash.com/photo-1519689680058-324335c77eba?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Toddler Toys',
            productCount: 100,
            imageUrl:
                'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Kids\' Educational Toys',
            productCount: 150,
            imageUrl:
                'https://images.unsplash.com/photo-1587654780291-39c9404d746b?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Outdoor Play',
            productCount: 80,
            imageUrl:
                'https://images.unsplash.com/photo-1535572290543-960a8046f5af?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Arts & Crafts',
            productCount: 90,
            imageUrl:
                'https://images.unsplash.com/photo-1560421683-6856ea585c78?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Action Figures & Collectibles',
            productCount: 70,
            imageUrl:
                'https://images.unsplash.com/photo-1566576912302-723c3dbafdda?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Board Games & Puzzles',
            productCount: 60,
            imageUrl:
                'https://images.unsplash.com/photo-1610890716171-6b1bb98ffd09?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Kids\' Electronics',
            productCount: 80,
            imageUrl:
                'https://images.unsplash.com/photo-1504274066651-8d31a536b11a?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
        ],
      ),
      CategoryModel(
        name: 'Books & Media',
        icon: FontAwesomeIcons.book,
        imageUrl:
            'https://images.unsplash.com/photo-1524578271613-d550eacf6090?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        color: Colors.teal,
        productCount: 1100,
        subcategories: [
          SubcategoryModel(
            name: 'Fiction Books',
            productCount: 250,
            imageUrl:
                'https://images.unsplash.com/photo-1544947950-fa07a98d237f?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Non-fiction & Reference',
            productCount: 200,
            imageUrl:
                'https://images.unsplash.com/photo-1512820790803-83ca734da794?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Children\'s Books',
            productCount: 180,
            imageUrl:
                'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'E-books & Digital Content',
            productCount: 150,
            imageUrl:
                'https://images.unsplash.com/photo-1553729459-efe14ef6055d?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Movies & TV Shows',
            productCount: 120,
            imageUrl:
                'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Music & Albums',
            productCount: 100,
            imageUrl:
                'https://images.unsplash.com/photo-1487180144351-b8472da7d491?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Magazines & Periodicals',
            productCount: 50,
            imageUrl:
                'https://images.unsplash.com/photo-1553484771-371a605b060b?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Audiobooks & Podcasts',
            productCount: 50,
            imageUrl:
                'https://images.unsplash.com/photo-1478737270239-2f02b77fc618?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
        ],
      ),
      CategoryModel(
        name: 'Sports & Outdoors',
        icon: FontAwesomeIcons.personRunning,
        imageUrl:
            'https://images.unsplash.com/photo-1517649763962-0c623066013b?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
        color: Colors.lightBlue,
        productCount: 680,
        subcategories: [
          SubcategoryModel(
            name: 'Fitness Equipment',
            productCount: 120,
            imageUrl:
                'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Team Sports Gear',
            productCount: 100,
            imageUrl:
                'https://images.unsplash.com/photo-1579952363873-27f3bade9f55?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Outdoor Recreation',
            productCount: 90,
            imageUrl:
                'https://images.unsplash.com/photo-1539635278303-d4002c07eae3?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Camping & Hiking',
            productCount: 80,
            imageUrl:
                'https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Water Sports',
            productCount: 70,
            imageUrl:
                'https://images.unsplash.com/photo-1530053969600-caed2596d242?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Cycling',
            productCount: 60,
            imageUrl:
                'https://images.unsplash.com/photo-1507035895480-2b3156c31fc8?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Winter Sports',
            productCount: 50,
            imageUrl:
                'https://images.unsplash.com/photo-1551698618-1dfe5d97d256?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
          SubcategoryModel(
            name: 'Sports Apparel',
            productCount: 110,
            imageUrl:
                'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ),
        ],
      ),
    ];
  }

  // Get featured categories (for home screen)
  static List<CategoryModel> getFeaturedCategories() {
    return getCategories().take(4).toList();
  }

  // Get recently viewed categories (for All Categories tab)
  static List<CategoryModel> getRecentlyViewedCategories() {
    // In a real app, this would be based on user history
    return [
      getCategories()[0], // Electronics
      getCategories()[2], // Fashion
    ];
  }

  // Get seasonal categories (for All Categories tab)
  static List<Map<String, dynamic>> getSeasonalCategories() {
    return [
      {
        'name': 'Summer Essentials',
        'icon': FontAwesomeIcons.sun,
        'color': Colors.amber,
        'imageUrl':
            'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
      },
      {
        'name': 'Back to School',
        'icon': FontAwesomeIcons.graduationCap,
        'color': Colors.indigo,
        'imageUrl':
            'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
      },
      {
        'name': 'Clearance',
        'icon': FontAwesomeIcons.tag,
        'color': Colors.red,
        'imageUrl':
            'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
      },
    ];
  }
}

class SubcategoryModel {
  final String name;
  final int productCount;
  final String imageUrl;

  SubcategoryModel({
    required this.name,
    required this.productCount,
    required this.imageUrl,
  });
}
