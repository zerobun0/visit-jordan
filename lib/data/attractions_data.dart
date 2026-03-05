import '../models/attraction.dart';

const List<Attraction> attractionsData = [
  Attraction(
    id: '1',
    name: 'Petra',
    description:
        'Petra is Jordan\'s most famous archaeological site and one of the most recognised landmarks in the world. Known as the "Rose City" due to the colour of the sandstone from which it is carved, Petra is a UNESCO World Heritage Site and one of the New Seven Wonders of the World.',
    history:
        'Petra was established possibly as early as the 4th century BC as the capital city of the Nabataean Kingdom. The Nabataeans were nomadic Arabs who benefited from the trade of frankincense, myrrh and spices. The city was carved directly into rose-red cliffs and became a thriving trading hub. It was later annexed by the Roman Empire in 106 AD. After a major earthquake in 363 AD, Petra began to decline and was eventually lost to the Western world until it was rediscovered by Swiss explorer Johann Ludwig Burckhardt in 1812.',
    location: 'Ma\'an Governorate, Southern Jordan',
    imageUrl: 'petra',
    latitude: 30.3285,
    longitude: 35.4444,
    highlights: [
      'The Treasury (Al-Khazneh)',
      'The Monastery (Ad-Deir)',
      'The Siq Canyon',
      'Royal Tombs',
      'Colonnaded Street',
    ],
    images: [
      'assets/images/petra1.jpg',
      'assets/images/petra2.jpg',
      'assets/images/petra3.jpg',
      'assets/images/petra4.jpg',
      'assets/images/petra5.jpg',
    ],
  ),
  Attraction(
    id: '2',
    name: 'Wadi Rum',
    description:
        'Wadi Rum, also known as the Valley of the Moon, is a protected desert wilderness in southern Jordan. It features dramatic sandstone mountains, ancient rock inscriptions, and vast red sand dunes. It has been used as a film location for many Hollywood movies including Lawrence of Arabia and The Martian.',
    history:
        'Wadi Rum has been inhabited since prehistoric times. It was home to the Nabataeans, who left rock inscriptions and carvings throughout the valley. During World War I, it served as a base for T.E. Lawrence (Lawrence of Arabia) during the Arab Revolt against the Ottoman Empire. The area was designated a UNESCO World Heritage Site in 2011 for its outstanding natural and cultural landscape.',
    location: 'Aqaba Governorate, Southern Jordan',
    imageUrl: 'wadi_rum',
    latitude: 29.5731,
    longitude: 35.4200,
    highlights: [
      'Sunrise & Sunset Desert Views',
      'Rock Inscriptions & Petroglyphs',
      'Jeep Desert Safari',
      'Bedouin Camping Experience',
      'Hot Air Balloon Rides',
    ],
    images: [
      'assets/images/wadi_rum1.jpg',
      'assets/images/wadi_rum2.jpg',
      'assets/images/wadi_rum3.jpg',
      'assets/images/wadi_rum4.jpg',
      'assets/images/wadi_rum5.jpg',
    ],
  ),
  Attraction(
    id: '3',
    name: 'Dead Sea',
    description:
        'The Dead Sea is a salt lake bordered by Jordan to the east and Israel and the West Bank to the west. It is one of the world\'s saltiest bodies of water, with a salinity of around 34%. Its extreme salinity makes it impossible for most life forms to survive, hence the name "Dead Sea". The high salt content makes visitors float effortlessly on the surface.',
    history:
        'The Dead Sea has been a centre of civilization since ancient times. It was one of the world\'s first health resorts, used by Herod the Great. Its mineral-rich waters and mud have been used for therapeutic purposes for thousands of years. According to the Bible, the cities of Sodom and Gomorrah were located near the Dead Sea. The area contains many important historical and religious sites, including Masada and Qumran, where the Dead Sea Scrolls were discovered in 1947.',
    location: 'Jordan Valley, Western Jordan',
    imageUrl: 'dead_sea',
    latitude: 31.5590,
    longitude: 35.4732,
    highlights: [
      'Floating on the Surface',
      'Mineral-Rich Mud Treatments',
      'Lowest Point on Earth (-430m)',
      'Therapeutic Salt Waters',
      'Stunning Sunset Views',
    ],
    images: [
      'assets/images/dead_sea1.jpg',
      'assets/images/dead_sea2.jpg',
      'assets/images/dead_sea3.jpg',
      'assets/images/dead_sea4.jpg',
      'assets/images/dead_sea5.jpg',
    ],
  ),
  Attraction(
    id: '4',
    name: 'Jerash',
    description:
        'Jerash is home to one of the best-preserved ancient Roman cities in the world outside of Italy. Known as the "Pompeii of the East", it features remarkably well-preserved colonnaded streets, arches, hippodromes, theatres, plazas and temples that date back to the Greco-Roman period.',
    history:
        'Jerash, ancient Gerasa, was one of the cities of the Decapolis, a group of ten cities that were centres of Greek and Roman culture. It was founded in the 4th century BC and flourished under Roman rule, reaching its peak in the 2nd century AD. The city was largely abandoned after the rise of Islam and was eventually buried under sand, which helped preserve its remarkable ruins. It was rediscovered in 1806 and has been under excavation since the 1920s.',
    location: 'Jerash Governorate, Northern Jordan',
    imageUrl: 'jerash',
    latitude: 32.2742,
    longitude: 35.8908,
    highlights: [
      'Hadrian\'s Arch',
      'The Oval Plaza (Forum)',
      'South & North Theatres',
      'Temple of Artemis',
      'Colonnaded Cardo Maximus',
    ],
    images: [
      'assets/images/jerash1.jpg',
      'assets/images/jerash2.jpg',
      'assets/images/jerash3.jpg',
      'assets/images/jerash4.jpg',
      'assets/images/jerash5.jpg',
    ],
  ),
];
