const List<String> countriesenabled = [
  /// "Eritrea",
  "Ethiopia",
  "Kenya",
  "South Sudan",
  "Uganda",
  "USA",
  "Canada",
  "UK",
  "France",
  "Germany",
  "Spain",
  "Portugal",
  "Italy",
  "Netherlands", // Holland's official name
  "Denmark",
  "Sweden",
  "Norway",
  "Finland",
];

const Map<String, List<String>> citiesenabled = {
  /// 'Eritrea': ['Asmara', 'Keren', 'Massawa', 'Mendefera', 'Barentu'],
  'Ethiopia': [
    'Addis Ababa',
    'Dire Dawa',
    'Bahir Dar',
    'Mekelle',
    'Gondar',
    'Hawassa'
  ],
  'Kenya': ['Nairobi', 'Mombasa', 'Eldoret', 'Malindi'],
  'South Sudan': ['Juba', 'Wau', 'Malakal', 'Yei', 'Bor'],
  'Uganda': ['Kampala', 'Entebbe', 'Jinja', 'Gulu', 'Mbarara', 'Mbale'],
};

const Map<String, List<String>> statesenabled = {
  // Existing African countries...
  'Ethiopia': [
    'Tigray',
    'Amhara',
    'Oromia',
    'SNNPR',
    'Addis Ababa',
    'Dire Dawa',
  ],
  'Kenya': [
    'Nairobi',
    'Coast',
    'Rift Valley',
    'Western',
    'Nyanza',
  ],
  'South Sudan': [
    'Central Equatoria',
    'Western Equatoria',
    'Eastern Equatoria',
    'Jonglei',
    'Unity',
  ],
  'Uganda': [
    'Central Region',
    'Eastern Region',
    'Northern Region',
    'Western Region',
  ],

  // North American countries
  'USA': [
    'Alabama',
    'Alaska',
    'Arizona',
    'Arkansas',
    'California',
    'Colorado',
    'Connecticut',
    'Delaware',
    'Florida',
    'Georgia',
    'Hawaii',
    'Idaho',
    'Illinois',
    'Indiana',
    'Iowa',
    'Kansas',
    'Kentucky',
    'Louisiana',
    'Maine',
    'Maryland',
    'Massachusetts',
    'Michigan',
    'Minnesota',
    'Mississippi',
    'Missouri',
    'Montana',
    'Nebraska',
    'Nevada',
    'New Hampshire',
    'New Jersey',
    'New Mexico',
    'New York',
    'North Carolina',
    'North Dakota',
    'Ohio',
    'Oklahoma',
    'Oregon',
    'Pennsylvania',
    'Rhode Island',
    'South Carolina',
    'South Dakota',
    'Tennessee',
    'Texas',
    'Utah',
    'Vermont',
    'Virginia',
    'Washington',
    'West Virginia',
    'Wisconsin',
    'Wyoming',
  ],
  'Canada': [
    'Ontario',
    'Quebec',
    'British Columbia',
    'Alberta',
    'Manitoba',
    'Saskatchewan',
    'Nova Scotia',
    'New Brunswick',
    'Newfoundland and Labrador',
    'Prince Edward Island',
  ],

  // European countries
  'UK': [
    'England',
    'Scotland',
    'Wales',
    'Northern Ireland',
  ],
  'France': [
    'Île-de-France',
    'Provence-Alpes-Côte d\'Azur',
    'Nouvelle-Aquitaine',
    'Occitanie',
    'Auvergne-Rhône-Alpes',
    'Hauts-de-France',
    'Grand Est',
    'Bretagne',
    'Normandie',
    'Pays de la Loire',
  ],
  'Germany': [
    'Bavaria',
    'North Rhine-Westphalia',
    'Baden-Württemberg',
    'Lower Saxony',
    'Hesse',
    'Saxony',
    'Berlin',
    'Hamburg',
    'Schleswig-Holstein',
    'Brandenburg',
  ],
  'Spain': [
    'Madrid',
    'Catalonia',
    'Andalusia',
    'Valencia',
    'Galicia',
    'Basque Country',
    'Castile and León',
    'Canary Islands',
    'Castilla-La Mancha',
    'Murcia',
  ],
  'Portugal': [
    'Lisbon',
    'Porto',
    'Algarve',
    'Madeira',
    'Azores',
    'Coimbra',
    'Braga',
    'Aveiro',
    'Faro',
    'Setúbal',
  ],
  'Italy': [
    'Lombardy',
    'Lazio',
    'Campania',
    'Sicily',
    'Veneto',
    'Emilia-Romagna',
    'Piedmont',
    'Tuscany',
    'Puglia',
    'Calabria',
  ],
  'Netherlands': [
    'North Holland',
    'South Holland',
    'North Brabant',
    'Gelderland',
    'Utrecht',
    'Limburg',
    'Overijssel',
    'Groningen',
    'Friesland',
    'Drenthe',
  ],
  'Denmark': [
    'Capital Region',
    'Central Denmark',
    'North Denmark',
    'Zealand',
    'South Denmark',
  ],
  'Sweden': [
    'Stockholm',
    'Västra Götaland',
    'Skåne',
    'Uppsala',
    'Östergötland',
    'Jönköping',
    'Halland',
    'Örebro',
    'Gävleborg',
    'Dalarna',
  ],
  'Norway': [
    'Oslo',
    'Viken',
    'Vestland',
    'Trøndelag',
    'Rogaland',
    'Møre og Romsdal',
    'Nordland',
    'Vestfold og Telemark',
    'Agder',
    'Innlandet',
  ],
  'Finland': [
    'Uusimaa',
    'Southwest Finland',
    'Pirkanmaa',
    'North Ostrobothnia',
    'Central Finland',
    'North Savo',
    'Satakunta',
    'South Savo',
    'North Karelia',
    'Lapland',
  ],
};

const Map<String, Map<String, List<String>>> citiesByState = {
  'Ethiopia': {
    'Addis Ababa': [
      'Addis Ababa',
      'Bole',
      'Kirkos',
      'Yeka',
      'Arada',
      'Gulele',
      'Lideta',
      'Kolfe Keranio',
      'Nifas Silk-Lafto',
      'Akaki Kaliti'
    ],
    'Amhara': [
      'Bahir Dar',
      'Gondar',
      'Dessie',
      'Debre Markos',
      'Debre Birhan',
      'Woldia',
      'Kombolcha',
      'Debre Tabor',
      'Finote Selam',
      'Lalibela',
      'Kemise',
      'Debark',
      'Merawi',
      'Adet',
      'Bure',
      'Motta',
      'Sekota'
    ],
    'Oromia': [
      'Adama',
      'Jimma',
      'Nekemte',
      'Bishoftu',
      'Shashamane',
      'Asella',
      'Bale Robe',
      'Ambo',
      'Bule Hora',
      'Gimbi',
      'Metu',
      'Sebeta',
      'Batu',
      'Fiche',
      'Weliso',
      'Chiro',
      'Bedele',
      'Negele Boran'
    ],
    'Tigray': [
      'Mekelle',
      'Adigrat',
      'Axum',
      'Shire',
      'Adwa',
      'Maichew',
      'Wukro',
      'Alamata',
      'Humera',
      'Korem'
    ],
    'SNNPR': [
      'Hawassa',
      'Sodo',
      'Arba Minch',
      'Dilla',
      'Hosaena',
      'Butajira',
      'Yirgalem',
      'Durame',
      'Welkite',
      'Mizan Teferi',
      'Bonga'
    ],
    'Dire Dawa': ['Dire Dawa'], // Added missing region as city
    'Harari': ['Harar'], // Added missing region
    'Gambella': ['Gambella', 'Abobo', 'Itang', 'Metu'], // Added missing region
    'Benishangul-Gumuz': [
      'Assosa',
      'Bambasi',
      'Menge',
      'Kamashi'
    ], // Added missing region
    'Sidama': [
      'Hawassa',
      'Yirgalem',
      'Wondo Genet',
      'Loku'
    ], // Added missing region
    'South West Ethiopia': [
      'Bonga',
      'Tepi',
      'Mizan Teferi',
      'Masha'
    ] // Added missing region
  },
  'Kenya': {
    'Nairobi': [
      'Nairobi CBD',
      'Westlands',
      'Karen',
      'Kasarani',
      'Embakasi',
      'Dagoretti',
      'Langata',
      'Kibera',
      'Eastleigh',
      'Kahawa'
    ],
    'Coast': [
      'Mombasa',
      'Malindi',
      'Kilifi',
      'Lamu',
      'Diani',
      'Voi',
      'Watamu',
      'Ukunda',
      'Taveta',
      'Mariakani'
    ],
    'Rift Valley': [
      'Nakuru',
      'Eldoret',
      'Naivasha',
      'Kitale',
      'Kericho',
      'Kabarnet',
      'Lodwar',
      'Maralal',
      'Narok',
      'Kapenguria'
    ],
    'Western': [
      'Kakamega',
      'Bungoma',
      'Busia',
      'Vihiga',
      'Mumias',
      'Webuye',
      'Malaba',
      'Kimilili',
      'Lugari',
      'Butere'
    ],
    'Nyanza': [
      'Kisumu',
      'Kisii',
      'Homa Bay',
      'Migori',
      'Siaya',
      'Bondo',
      'Rongo',
      'Oyugis',
      'Kendu Bay',
      'Nyamira'
    ],
    'Central': [
      'Nyeri',
      'Thika',
      'Murang\'a',
      'Kiambu',
      'Kerugoya',
      'Karatina',
      'Ol Kalou',
      'Kenol',
      'Limuru',
      'Ruiru'
    ],
    'Eastern': [
      'Machakos',
      'Meru',
      'Embu',
      'Kitui',
      'Isiolo',
      'Marsabit',
      'Moyale',
      'Wajir',
      'Garissa',
      'Mandera'
    ],
    'North Eastern': [
      'Garissa',
      'Wajir',
      'Mandera',
      'Dadaab'
    ] // Added missing region
  },
  'South Sudan': {
    'Central Equatoria': [
      'Juba',
      'Yei',
      'Kajo Keji',
      'Terekeka',
      'Morobo',
      'Lainya',
      'Mangalla',
      'Rokon',
      'Tali'
    ],
    'Western Equatoria': [
      'Yambio',
      'Tambura',
      'Maridi',
      'Mundri',
      'Nzara',
      'Ezo',
      'Ibba',
      'Mvolo',
      'Nagero'
    ],
    'Eastern Equatoria': [
      'Torit',
      'Kapoeta',
      'Nimule',
      'Ikotos',
      'Magwi',
      'Chukudum',
      'Lafon',
      'Pageri'
    ],
    'Jonglei': [
      'Bor',
      'Pibor',
      'Akobo',
      'Pochalla',
      'Duk',
      'Twic East',
      'Uror',
      'Nyirol',
      'Fangak'
    ],
    'Unity': [
      'Bentiu',
      'Mayom',
      'Koch',
      'Leer',
      'Rubkona',
      'Pariang',
      'Guit',
      'Mayendit'
    ],
    'Upper Nile': [
      'Malakal',
      'Renk',
      'Nasir',
      'Baliet',
      'Ulang',
      'Melut',
      'Maiwut',
      'Longochuk'
    ],
    'Lakes': [
      'Rumbek',
      'Yirol',
      'Cueibet',
      'Awerial',
      'Wulu'
    ], // Added missing region
    'Warrap': [
      'Kuajok',
      'Tonj',
      'Gogrial',
      'Turalei',
      'Mayen Abun'
    ], // Added missing region
    'Northern Bahr el Ghazal': [
      'Aweil',
      'Malualkon',
      'Ariath',
      'Gok Machar'
    ], // Added missing region
    'Western Bahr el Ghazal': [
      'Wau',
      'Raja',
      'Kuajiena',
      'Deim Zubeir'
    ] // Added missing region
  },
  'Uganda': {
    'Central Region': [
      'Kampala',
      'Entebbe',
      'Mukono',
      'Wakiso',
      'Masaka',
      'Mityana',
      'Luweero',
      'Mpigi',
      'Kayunga',
      'Wobulenzi'
    ],
    'Eastern Region': [
      'Jinja',
      'Mbale',
      'Tororo',
      'Soroti',
      'Busia',
      'Iganga',
      'Kamuli',
      'Kapchorwa',
      'Pallisa',
      'Bugiri'
    ],
    'Northern Region': [
      'Gulu',
      'Lira',
      'Arua',
      'Kitgum',
      'Pader',
      'Adjumani',
      'Koboko',
      'Moyo',
      'Nebbi',
      'Yumbe'
    ],
    'Western Region': [
      'Mbarara',
      'Fort Portal',
      'Kabale',
      'Kasese',
      'Hoima',
      'Masindi',
      'Bushenyi',
      'Ntungamo',
      'Rukungiri',
      'Ishaka'
    ],
    'Karamoja': [
      'Moroto',
      'Kotido',
      'Kaabong',
      'Nakapiripirit',
      'Abim'
    ], // Added missing region
    'Teso': [
      'Soroti',
      'Kumi',
      'Bukedea',
      'Amuria',
      'Katakwi'
    ], // Added missing region
    'Bukedi': [
      'Tororo',
      'Busia',
      'Butaleja',
      'Pallisa',
      'Budaka'
    ], // Added missing region
    'Busoga': [
      'Jinja',
      'Iganga',
      'Kamuli',
      'Bugiri',
      'Mayuge'
    ] // Added missing region
  },
  'USA': {
    'Alabama': ['Birmingham', 'Montgomery', 'Huntsville', 'Mobile'],
    'Alaska': ['Anchorage', 'Fairbanks', 'Juneau', 'Sitka'],
    'Arizona': ['Phoenix', 'Tucson', 'Mesa', 'Scottsdale'],
    'Arkansas': ['Little Rock', 'Fort Smith', 'Fayetteville', 'Springdale'],
    'California': [
      'Los Angeles',
      'San Francisco',
      'San Diego',
      'Sacramento',
      'San Jose',
      'Fresno',
      'Long Beach',
      'Oakland',
      'Bakersfield',
      'Anaheim'
    ],
    'Colorado': ['Denver', 'Colorado Springs', 'Aurora', 'Fort Collins'],
    'Connecticut': ['Bridgeport', 'New Haven', 'Hartford', 'Stamford'],
    'Delaware': ['Wilmington', 'Dover', 'Newark', 'Middletown'],
    'Florida': ['Miami', 'Orlando', 'Tampa', 'Jacksonville'],
    'Georgia': [
      'Atlanta',
      'Savannah',
      'Augusta',
      'Columbus',
      'Macon',
      'Athens',
      'Sandy Springs',
      'Roswell',
      'Albany',
      'Johns Creek'
    ],
    'Hawaii': ['HonoAfrinovau', 'Hilo', 'Kailua', 'Kapolei'],
    'Idaho': ['Boise', 'Meridian', 'Nampa', 'Idaho Falls'],
    'Illinois': ['Chicago', 'Springfield', 'Aurora', 'Rockford'],
    'Indiana': ['Indianapolis', 'Fort Wayne', 'Evansville', 'South Bend'],
    'Iowa': ['Des Moines', 'Cedar Rapids', 'Davenport', 'Sioux City'],
    'Kansas': ['Wichita', 'Kansas City', 'Overland Park', 'Topeka'],
    'Kentucky': ['Louisville', 'Lexington', 'Bowling Green', 'Owensboro'],
    'Louisiana': ['New Orleans', 'Baton Rouge', 'Shreveport', 'Lafayette'],
    'Maine': ['Portland', 'Lewiston', 'Bangor', 'Auburn'],
    'Maryland': ['Baltimore', 'Columbia', 'Annapolis', 'Frederick'],
    'Massachusetts': ['Boston', 'Worcester', 'Springfield', 'Cambridge'],
    'Michigan': ['Detroit', 'Grand Rapids', 'Lansing', 'Ann Arbor'],
    'Minnesota': ['Minneapolis', 'Saint Paul', 'Rochester', 'Duluth'],
    'Mississippi': ['Jackson', 'Gulfport', 'Southaven', 'Biloxi'],
    'Missouri': ['Kansas City', 'St. Louis', 'Springfield', 'Columbia'],
    'Montana': ['Billings', 'Missoula', 'Great Falls', 'Bozeman'],
    'Nebraska': ['Omaha', 'Lincoln', 'Bellevue', 'Grand Island'],
    'Nevada': ['Las Vegas', 'Reno', 'Henderson', 'Carson City'],
    'New Hampshire': ['Manchester', 'Nashua', 'Concord', 'Dover'],
    'New Jersey': ['Newark', 'Jersey City', 'Paterson', 'Elizabeth'],
    'New Mexico': ['Albuquerque', 'Las Cruces', 'Santa Fe', 'Rio Rancho'],
    'New York': [
      'New York City',
      'Buffalo',
      'Rochester',
      'Syracuse',
      'Albany',
      'Yonkers',
      'White Plains',
      'Schenectady',
      'Utica',
      'Binghamton'
    ],
    'North Carolina': ['Charlotte', 'Raleigh', 'Greensboro', 'Durham'],
    'North Dakota': ['Fargo', 'Bismarck', 'Grand Forks', 'Minot'],
    'Ohio': ['Columbus', 'Cleveland', 'Cincinnati', 'Toledo'],
    'Oklahoma': ['Oklahoma City', 'Tulsa', 'Norman', 'Broken Arrow'],
    'Oregon': ['Portland', 'Salem', 'Eugene', 'Gresham'],
    'Pennsylvania': ['Philadelphia', 'Pittsburgh', 'Allentown', 'Erie'],
    'Rhode Island': ['Providence', 'Warwick', 'Cranston', 'Pawtucket'],
    'South Carolina': ['Columbia', 'Charleston', 'Greenville', 'Myrtle Beach'],
    'South Dakota': ['Sioux Falls', 'Rapid City', 'Aberdeen', 'Brookings'],
    'Tennessee': ['Nashville', 'Memphis', 'Knoxville', 'Chattanooga'],
    'Texas': [
      'Houston',
      'Dallas',
      'Austin',
      'San Antonio',
      'Fort Worth',
      'El Paso',
      'Arlington',
      'Corpus Christi',
      'Plano',
      'Lubbock'
    ],
    'Utah': ['Salt Lake City', 'West Valley City', 'Provo', 'West Jordan'],
    'Vermont': ['Burlington', 'South Burlington', 'Rutland', 'Montpelier'],
    'Virginia': ['Virginia Beach', 'Richmond', 'Norfolk', 'Arlington'],
    'Washington': [
      'Seattle',
      'Spokane',
      'Tacoma',
      'Vancouver',
      'Bellevue',
      'Everett',
      'Kent',
      'Yakima',
      'Renton',
      'Spokane Valley'
    ],
    'West Virginia': ['Charleston', 'Huntington', 'Morgantown', 'Parkersburg'],
    'Wisconsin': ['Milwaukee', 'Madison', 'Green Bay', 'Kenosha'],
    'Wyoming': ['Cheyenne', 'Casper', 'Laramie', 'Gillette']
  },
  'Canada': {
    'Ontario': [
      'Toronto',
      'Ottawa',
      'Hamilton',
      'London',
      'Mississauga',
      'Brampton',
      'Windsor',
      'Vaughan',
      'Kitchener',
      'Markham'
    ],
    'Quebec': ['Montreal', 'Quebec City', 'Laval', 'Gatineau'],
    'British Columbia': [
      'Vancouver',
      'Victoria',
      'Surrey',
      'Burnaby',
      'Richmond',
      'Abbotsford',
      'Coquitlam',
      'Kelowna',
      'Delta',
      'Nanaimo'
    ],
    'Alberta': [
      'Calgary',
      'Edmonton',
      'Red Deer',
      'Lethbridge',
      'St. Albert',
      'Medicine Hat',
      'Grande Prairie',
      'Airdrie',
      'Spruce Grove',
      'Fort McMurray'
    ],
    'Manitoba': [
      'Winnipeg',
      'Brandon',
      'Steinbach',
      'Thompson',
      'Portage la Prairie',
      'Winkler',
      'Selkirk',
      'Dauphin',
      'Morden',
      'The Pas'
    ],
    'Saskatchewan': [
      'Regina',
      'Saskatoon',
      'Prince Albert',
      'Moose Jaw',
      'Swift Current',
      'Yorkton',
      'North Battleford',
      'Weyburn',
      'Estevan',
      'Warman'
    ],
    'Nova Scotia': [
      'Halifax',
      'Dartmouth',
      'Sydney',
      'Truro',
      'New Glasgow',
      'Bedford',
      'Glace Bay',
      'Bridgewater',
      'Kentville',
      'Yarmouth'
    ],
    'New Brunswick': ['Saint John', 'Fredericton', 'Moncton', 'Dieppe'],
    'Newfoundland and Labrador': [
      'St. John\'s',
      'Mount Pearl',
      'Corner Brook',
      'Grand Falls-Windsor'
    ],
    'Prince Edward Island': [
      'Charlottetown',
      'Summerside',
      'Stratford',
      'Cornwall'
    ],
    'Northwest Territories': [
      'Yellowknife',
      'Hay River',
      'Inuvik',
      'Fort Smith'
    ],
    'Yukon': ['Whitehorse', 'Dawson City', 'Watson Lake', 'Haines Junction'],
    'Nunavut': ['Iqaluit', 'Rankin Inlet', 'Arviat', 'Baker Lake']
  },
  'UK': {
    'England': ['London', 'Manchester', 'Birmingham', 'Liverpool'],
    'Scotland': ['Edinburgh', 'Glasgow', 'Aberdeen', 'Dundee'],
    'Wales': ['Cardiff', 'Swansea', 'Newport', 'Bangor'],
    'Northern Ireland': ['Belfast', 'Derry', 'Lisburn', 'Bangor']
  },
  'France': {
    'Île-de-France': [
      'Paris',
      'Versailles',
      'Saint-Denis',
      'Boulogne-Billancourt'
    ],
    'Provence-Alpes-Côte d\'Azur': [
      'Marseille',
      'Nice',
      'Toulon',
      'Aix-en-Provence'
    ],
    'Nouvelle-Aquitaine': ['Bordeaux', 'Limoges', 'Poitiers', 'La Rochelle'],
    'Occitanie': ['Toulouse', 'Montpellier', 'Nîmes', 'Perpignan'],
    'Auvergne-Rhône-Alpes': [
      'Lyon',
      'Grenoble',
      'Saint-Étienne',
      'Clermont-Ferrand'
    ],
    'Hauts-de-France': ['Lille', 'Amiens', 'Roubaix', 'Tourcoing'],
    'Grand Est': ['Strasbourg', 'Reims', 'Metz', 'Nancy'],
    'Bretagne': ['Rennes', 'Brest', 'Quimper', 'Vannes'],
    'Normandie': ['Rouen', 'Caen', 'Le Havre', 'Cherbourg'],
    'Pays de la Loire': ['Nantes', 'Angers', 'Le Mans', 'Saint-Nazaire'],
    'Centre-Val de Loire': ['Orléans', 'Tours', 'Bourges', 'Blois'],
    'Bourgogne-Franche-Comté': ['Dijon', 'Besançon', 'Belfort', 'Nevers'],
    'Corse': ['Ajaccio', 'Bastia', 'Porto-Vecchio', 'Calvi']
  },
  'Germany': {
    'Bavaria': [
      'Munich',
      'Nuremberg',
      'Augsburg',
      'Regensburg',
      'Würzburg',
      'Ingolstadt',
      'Fürth',
      'Erlangen',
      'Bayreuth',
      'Bamberg'
    ],
    'North Rhine-Westphalia': ['Cologne', 'Düsseldorf', 'Dortmund', 'Essen'],
    'Baden-Württemberg': [
      'Stuttgart',
      'Karlsruhe',
      'Mannheim',
      'Freiburg',
      'Heidelberg',
      'Ulm',
      'Heilbronn',
      'Pforzheim',
      'Reutlingen',
      'Esslingen'
    ],
    'Lower Saxony': [
      'Hanover',
      'Braunschweig',
      'Osnabrück',
      'Oldenburg',
      'Wolfsburg',
      'Göttingen',
      'Hildesheim',
      'Salzgitter',
      'Wilhelmshaven',
      'Delmenhorst'
    ],
    'Hesse': ['Frankfurt', 'Wiesbaden', 'Kassel', 'Darmstadt'],
    'Saxony': ['Dresden', 'Leipzig', 'Chemnitz', 'Zwickau'],
    'Berlin': ['Berlin'], // City-state
    'Hamburg': ['Hamburg'], // City-state
    'Bremen': ['Bremen', 'Bremerhaven'], // City-state
    'Schleswig-Holstein': ['Kiel', 'Lübeck', 'Flensburg', 'Neumünster'],
    'Brandenburg': ['Potsdam', 'Cottbus', 'Brandenburg', 'Frankfurt (Oder)'],
    'Saxony-Anhalt': ['Magdeburg', 'Halle', 'Dessau-Roßlau', 'Stendal'],
    'Thuringia': ['Erfurt', 'Jena', 'Gera', 'Weimar'],
    'Rhineland-Palatinate': ['Mainz', 'Ludwigshafen', 'Koblenz', 'Trier'],
    'Saarland': ['Saarbrücken', 'Neunkirchen', 'Homburg', 'Völklingen'],
    'Mecklenburg-Vorpommern': [
      'Rostock',
      'Schwerin',
      'Neubrandenburg',
      'Stralsund'
    ]
  },
  'Spain': {
    'Madrid': ['Madrid', 'Móstoles', 'Alcalá de Henares', 'Fuenlabrada'],
    'Catalonia': ['Barcelona', 'Hospitalet', 'Terrassa', 'Badalona'],
    'Andalusia': ['Seville', 'Málaga', 'Córdoba', 'Granada'],
    'Valencia': ['Valencia', 'Alicante', 'Elche', 'Castellón'],
    'Galicia': ['Santiago de Compostela', 'A Coruña', 'Vigo', 'Ourense'],
    'Basque Country': [
      'Bilbao',
      'Vitoria-Gasteiz',
      'San Sebastián',
      'Barakaldo'
    ],
    'Castile and León': ['Valladolid', 'Burgos', 'Salamanca', 'León'],
    'Canary Islands': ['Las Palmas', 'Santa Cruz', 'La Laguna', 'Telde'],
    'Castilla-La Mancha': ['Toledo', 'Albacete', 'Guadalajara', 'Ciudad Real'],
    'Murcia': ['Murcia', 'Cartagena', 'Lorca', 'Molina de Segura'],
    'Aragón': ['Zaragoza', 'Huesca', 'Teruel', 'Calatayud'],
    'Asturias': ['Oviedo', 'Gijón', 'Avilés', 'Siero'],
    'Balearic Islands': ['Palma', 'Calvià', 'Ibiza', 'Manacor'],
    'Extremadura': ['Badajoz', 'Cáceres', 'Mérida', 'Plasencia'],
    'Cantabria': ['Santander', 'Torrelavega', 'Castro-Urdiales', 'Camargo'],
    'La Rioja': ['Logroño', 'Calahorra', 'Arnedo', 'Haro'],
    'Navarre': ['Pamplona', 'Tudela', 'Barañáin', 'Valle de Egüés'],
    'Ceuta': ['Ceuta'],
    'Melilla': ['Melilla']
  },
  'Portugal': {
    'Lisbon': ['Lisbon', 'Amadora', 'Odivelas', 'Oeiras'],
    'Porto': ['Porto', 'Vila Nova de Gaia', 'Matosinhos', 'Gondomar'],
    'Algarve': ['Faro', 'Portimão', 'Loulé', 'Albufeira'],
    'Madeira': ['Funchal', 'Câmara de Lobos', 'Santa Cruz', 'Machico'],
    'Azores': ['Ponta Delgada', 'Angra do Heroísmo', 'Horta', 'Ribeira Grande']
  },
  'Italy': {
    'Lombardy': ['Milan', 'Brescia', 'Bergamo', 'Monza'],
    'Lazio': ['Rome', 'Latina', 'Guidonia', 'Aprilia'],
    'Campania': ['Naples', 'Salerno', 'Giugliano', 'Torre del Greco'],
    'Sicily': ['Palermo', 'Catania', 'Messina', 'Syracuse'],
    'Veneto': ['Venice', 'Verona', 'Padua', 'Vicenza'],
    'Emilia-Romagna': ['Bologna', 'Parma', 'Modena', 'Reggio Emilia'],
    'Piedmont': ['Turin', 'Novara', 'Alessandria', 'Asti'],
    'Tuscany': ['Florence', 'Prato', 'Livorno', 'Pisa'],
    'Puglia': ['Bari', 'Taranto', 'Foggia', 'Lecce'],
    'Calabria': ['Reggio Calabria', 'Catanzaro', 'Cosenza', 'Crotone'],
    'Liguria': ['Genoa', 'La Spezia', 'Savona', 'Sanremo'],
    'Marche': ['Ancona', 'Pesaro', 'Fano', 'Ascoli Piceno'],
    'Abruzzo': ['L\'Aquila', 'Pescara', 'Chieti', 'Teramo'],
    'Friuli-Venezia Giulia': ['Trieste', 'Udine', 'Pordenone', 'Gorizia'],
    'Trentino-Alto Adige': ['Trento', 'Bolzano', 'Merano', 'Rovereto'],
    'Umbria': ['Perugia', 'Terni', 'Foligno', 'Città di Castello'],
    'Sardinia': ['Cagliari', 'Sassari', 'Quartu Sant\'Elena', 'Olbia'],
    'Basilicata': ['Potenza', 'Matera', 'Melfi', 'Pisticci'],
    'Molise': ['Campobasso', 'Termoli', 'Isernia', 'Venafro'],
    'Valle d\'Aosta': ['Aosta']
  },
  'Netherlands': {
    'North Holland': ['Amsterdam', 'Haarlem', 'Zaanstad', 'Alkmaar'],
    'South Holland': ['Rotterdam', 'The Hague', 'Leiden', 'Dordrecht'],
    'North Brabant': ['Eindhoven', 'Tilburg', 'Breda', 'Den Bosch'],
    'Gelderland': ['Arnhem', 'Nijmegen', 'Apeldoorn', 'Ede'],
    'Utrecht': ['Utrecht', 'Amersfoort', 'Veenendaal', 'Zeist'],
    'Limburg': ['Maastricht', 'Venlo', 'Sittard-Geleen', 'Heerlen']
  },
  'Denmark': {
    'Capital Region': ['Copenhagen', 'Frederiksberg', 'Gentofte', 'Gladsaxe'],
    'Central Denmark': ['Aarhus', 'Randers', 'Silkeborg', 'Horsens'],
    'North Denmark': ['Aalborg', 'Hjørring', 'Frederikshavn', 'Thisted'],
    'Zealand': ['Roskilde', 'Næstved', 'Slagelse', 'Køge'],
    'South Denmark': ['Odense', 'Esbjerg', 'Kolding', 'Vejle']
  },
  'Sweden': {
    'Stockholm': ['Stockholm', 'Södertälje', 'Norrtälje', 'Solna'],
    'Västra Götaland': ['Gothenburg', 'Borås', 'Trollhättan', 'Skövde'],
    'Skåne': ['Malmö', 'Helsingborg', 'Lund', 'Kristianstad'],
    'Uppsala': ['Uppsala', 'Enköping', 'Bålsta', 'Knivsta']
  },
  'Norway': {
    'Oslo': ['Oslo'],
    'Viken': ['Drammen', 'Fredrikstad', 'Sarpsborg', 'Asker'],
    'Vestland': ['Bergen', 'Ålesund', 'Molde', 'Førde'],
    'Trøndelag': ['Trondheim', 'Steinkjer', 'Stjørdal', 'Levanger'],
    'Rogaland': ['Stavanger', 'Sandnes', 'Haugesund', 'Egersund']
  },
  'Finland': {
    'Uusimaa': ['Helsinki', 'Espoo', 'Vantaa', 'Porvoo'],
    'Southwest Finland': ['Turku', 'Salo', 'Raisio', 'Kaarina'],
    'Pirkanmaa': ['Tampere', 'Nokia', 'Ylöjärvi', 'Kangasala'],
    'North Ostrobothnia': ['Oulu', 'Raahe', 'Kempele', 'Kuusamo'],
    'Central Finland': ['Jyväskylä', 'Äänekoski', 'Laukaa', 'Muurame']
  },
};
