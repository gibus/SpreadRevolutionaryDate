use 5.014;
use utf8;
package App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale::en;

# ABSTRACT: English localization of (part of) L<DateTime::Calendar::FrenchRevolutionary::Locale::en>

use Moose;
with 'App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale';

use Locale::TextDomain 'App-SpreadRevolutionaryDate';
use namespace::autoclean;

# based on Thomas Carlyle's book:
has '+months' => (
  default => sub {[
    'Vintagearious', 'Fogarious', 'Frostarious',
    'Snowous',       'Rainous',   'Windous',
    'Buddal',        'Floweral',  'Meadowal',
    'Reapidor',      'Heatidor',  'Fruitidor',
    'additional day',
  ]},
);

has '+decade_days' => (
  default => sub {[
    'Firsday',
    'Seconday',
    'Thirday',
    'Fourday',
    'Fifday',
    'Sixday',
    'Sevenday',
    'Eightday',
    'Nineday',
    'Tenday',
  ]},
);

has '+prefix' => (
  default => sub {[
      '',
  ]},
);

has '+suffix' => (
  default => ' day',
);

has '+feast' => (
  default => sub {[
    # Vendémiaire
    qw(
      0grape                0saffron         0chestnut        0crocus          0horse
      0balsam               0carrot          0amaranth        0parsnip         0vat
      0potato               0everlasting     0winter_squash   0mignonette      0donkey
      0four_o'clock_flower  0pumpkin         0buckwheat       0sunflower       0wine-press
      0hemp                 0peach           0turnip          0amaryllis       0ox
      0eggplant             0chili_pepper    0tomato          0barley          0barrel
    ),
    # Brumaire
    qw(
      0apple                0celery          0pear                    0beetroot        0goose
      0heliotrope           0fig             0black_salsify           0chequer_tree    0plow
      0salsify              0water_chestnut  0jerusalem_artichoke     0endive          0turkey
      0skirret              0cress           0leadworts               0pomegranate     0harrow
      0baccharis            0azarole         0madder                  0orange          0pheasant
      0pistachio            0tuberous_pea    0quince                  0service_tree    0roller
    ),
    # Frimaire
    qw(
      0rampion              0turnip          0chicory         0medlar          0pig
      0corn_salad           0cauliflower     0honey           0juniper         0pickaxe
      0wax                  0horseradish     0cedar_tree      0fir_tree        0roe_deer
      0gorse                0cypress_tree    0ivy             0savin_juniper   0grub-hoe
      0maple_tree           0heather         0reed            0sorrel          0cricket
      0pine_nut             0cork            0truffle         0olive           0shovel
    ),
    # Nivôse
    qw(
      0peat                 0coal           0bitumen         0sulphur         0dog
      0lava                 0topsoil        0manure          0saltpeter       0flail
      0granite              0clay           0slate           0sandstone       0rabbit
      0flint                0marl           0limestone       0marble          0winnowing_basket
      0gypsum               0salt           0iron            0copper          0cat
      0tin                  0lead           0zinc            0mercury         0sieve
    ),
    # Pluviôse
    qw(
      0spurge_laurel        0moss            0butcher's_broom 0snowdrop                0bull
      0laurustinus          0tinder_polypore 0mezereon        0poplar_tree             0axe
      0hellebore            0broccoli        0laurel          0common_hazel            0cow
      0box_tree             0lichen          0yew_tree        0lungwort                0billhook
      0penny-cress          0daphne          0couch_grass     0common_knotgrass        0hare
      0woad                 0hazel_tree      0cyclamen        0celandine               0sleigh
    ),
    # Ventôse
    qw(
      0coltsfoot            0dogwood                   0matthiola         0privet          0billygoat
      0wild_ginger          0mediterranean_buckthorn   0violet            0goat_willow     0spade
      0narcissus            0elm_tree                  0fumitory          0hedge_mustard   0goat
      0spinach              0leopard's_bane            0pimpernel         0chervil         0line
      0mandrake             0parsley                   0scurvy-grass      0daisy           0tuna_fish
      0dandelion            0windflower                0maidenhair_fern   0ash_tree        0dibble
    ),
    # Germinal
    qw(
      0primula              0plane_tree      0asparagus       0tulip           0hen
      0chard                0birch_tree      0daffodil        0alder           0hatchery
      0periwinkle           0hornbeam        0morel           0beech_tree      0bee
      0lettuce              0larch           0hemlock         0radish          0hive
      0judas_tree           0roman_lettuce   0chestnut_tree   0rocket          0pigeon
      0lilac                0anemone         0pansy           0blueberry       0dibber
    ),
    # Floréal
    qw(
      0rose                 0oak_tree                0fern            0hawthorn        0nightingale
      0columbine            0lily_of_the_valley      0mushroom        0hyacinth        0rake
      0rhubarb              0sainfoin                0wallflower      0fan_palm_tree   0silkworm
      0comfrey              0burnet                  0basket_of_gold  0orache          0hoe
      0thrift               0fritillary              0borage          0valerian        0carp
      0spindletree          0chive                   0bugloss         0wild_mustard    0shepherd_staff
    ),
    # Prairial
    qw(
      0alfalfa              0day-lily        0clover          0angelica        0duck
      0lemon_balm           0oat_grass       0martagon        0wild_thyme      0scythe
      0strawberry           0betony          0pea             0acacia          0quail
      0carnation            0elder_tree      0poppy           0lime            0pitchfork
      0barbel               0camomile        0honeysuckle     0bedstraw        0tench
      0jasmine              0vervain         0thyme           0peony           0carriage
    ),
    # Messidor
    qw(
      0rye                  0oats            0onion           0speedwell       0mule
      0rosemary             0cucumber        0shallot         0wormwood        0sickle
      0coriander            0artichoke       0clove           0lavender        0chamois
      0tobacco              0currant         0vetchling       0cherry          0park
      0mint                 0cumin           0bean            0alkanet         0guinea_hen
      0sage                 0garlic          0tare            0corn            0shawm
    ),
    # Thermidor
    qw(
      0spelt                0mullein         0melon           0ryegrass        0ram
      0horsetail            0mugwort         0safflower       0blackberry      0watering_can
      0switchgrass          0glasswort       0apricot         0basil           0ewe
      0marshmallow          0flax            0almond          0gentian         0waterlock
      0carline_thistle      0caper           0lentil          0horseheal       0otter
      0myrtle               0oil-seed_rape   0lupin           0cotton          0mill
    ),
    # Fructidor
    qw(
      0plum                 0millet          0lycoperdon      0barley          0salmon
      0tuberose             0bere            0dogbane         0liquorice       0stepladder
      0watermelon           0fennel          0barberry        0walnut          0trout
      0lemon                0teasel          0buckthorn       0marigold        0harvesting_basket
      0wild_rose            0hazelnut        0hops            0sorghum         0crayfish
      0bitter_orange        0goldenrod       0corn            0chestnut        0basket
    ),
    # Jours complémentaires
    qw(
      0virtue               0engineering    0labour          0opinion          0rewards
      0revolution
    ),
  ]},
);

has '+wikipedia_entries' => (
  default => sub {{
    1 => {
      'safran'                  => 'Safran_(épice)',
      'balsamine'               => 'Balsaminaceae',
      'amarante'                => 'Amarante_(plante)',
      'amaranthe'               => 'Amarante_(plante)',
      'immortelle'              => 'Immortelle_commune',
      'belle de nuit'           => 'Mirabilis_jalapa',
      'belle-de-nuit'           => 'Mirabilis_jalapa',
      'sarrasin'                => 'Sarrasin_(plante)',
      'pêche'                   => 'Pêche_(fruit)',
      'pèche'                   => 'Pêche_(fruit)',
      'amaryllis'               => 'Amaryllis_(plante)',
      'amarillis'               => 'Amaryllis_(plante)',
      'bœuf'                    => 'Bos_taurus',
      'orge'                    => 'Orge_commune',
      'tonneau'                 => 'Tonneau_(récipient)',
    },
    2 => {
      'alisier'                 => 'Sorbus_torminalis',
      'macre'                   => 'Mâcre_nageante',
      'chervi'                  => 'Chervis',
      'cresson'                 => 'Cresson_de_fontaine',
      'grenade'                 => 'Grenade_(fruit)',
      'herse'                   => 'Herse_(agriculture)',
      'bacchante'               => 'Baccharis_halimifolia',
      'garance'                 => 'Garance_des_teinturiers',
      'orange'                  => 'Orange_(fruit)',
      'macjon'                  => 'Gesse_tubéreuse',
      'macjonc'                 => 'Gesse_tubéreuse',
      'coin'                    => 'Coing',
      'rouleau'                 => 'Rouleau_agricole',
    },
    3 => {
      'raiponce'                => 'Raiponce_(plante)',
      'turneps'                 => 'Betterave_fourragère',
      'choufleur'               => 'Chou-fleur',
      'genièvre'                => 'Juniperus_communis',
      'lierre'                  => 'Hedera',
      'sabine'                  => 'Juniperus_sabina',
      'érable-sucre'            => 'Érable_à_sucre',
      'érable-à-sucre'          => 'Érable_à_sucre',
      'érable sucré'            => 'Érable_à_sucre',
      'grillon'                 => 'Gryllidae',
      'pignon'                  => 'Pignon_(pin)',
      'liège'                   => 'Liège_(matériau)',
      'truffe'                  => 'Truffe_(champignon)',
      'pelle'                   => 'Pelle_(outil)',
    },
    4 => {
      'terre végétale'          => 'Humus',
      'fléau'                   => 'Fléau_(agriculture)',
      'grès'                    => 'Grès_(géologie)',
      'lapin'                   => 'Oryctolagus_cuniculus',
      'marne'                   => 'Marne_(géologie)',
      'pierre à chaux'          => 'Calcaire',
      'pierre-à-chaux'          => 'Calcaire',
      'van'                     => 'Van_(agriculture)',
      'pierre à plâtre'         => 'Gypse',
      'pierre-à-plâtre'         => 'Gypse',
      'sel'                     => 'Chlorure_de_sodium',
      'mercure'                 => 'Mercure_(chimie)',
      'crible'                  => 'Tamis',
    },
    5 => {
      'mousse'                  => 'Bryophyta',
      'laurier-thym'            => 'Viorne_tin',
      'laurier-tin'             => 'Viorne_tin',
      'laurier'                 => 'Laurus_nobilis',
      'mézéréum'                => 'Mézéréon',
      'coignée'                 => 'Cognée',
      'avelinier'               => 'Noisetier',
      'if'                      => 'Taxus',
      'thymelé'                 => 'Daphné_garou',
      'thymele'                 => 'Daphné_garou',
      'traînasse'               => 'Renouée_des_oiseaux',
      'trainasse'               => 'Renouée_des_oiseaux',
      'ciclamen'                => 'Cyclamen',
      'chélidoine'              => 'Chelidonium_majus',
    },
    6 => {
      'cornouiller'             => 'Cornus_(plante)',
      'violier'                 => 'Vélar',
      'troêne'                  => 'Troène',
      'bouc'                    => 'Bouc_(animal)',
      'violette'                => 'Viola_(genre_végétal)',
      'marsault'                => 'Saule_marsault',
      'marceau'                 => 'Saule_marsault',
      'narcisse'                => 'Narcissus',
      'épinards'                => 'Épinard',
      'mouron'                  => 'Mouron_(flore)',
      'cochléaria'              => 'Cochlearia',
      'capillaire'              => 'Capillaire_de_montpellier',
    },
    7 => {
      'poule'                   => 'Poule_(animal)',
      'blette'                  => 'Bette_(plante)',
      'bette'                   => 'Bette_(plante)',
      'couvoir'                 => 'Incubateur_(œuf)',
      'morille'                 => 'Morchella',
      'hêtre'                   => 'Hêtre_commun',
      'ciguë'                   => 'Apiaceae',
      'romaine'                 => 'Laitue_romaine',
      'marronnier'              => 'Marronnier_commun',
      'roquette'                => 'Roquette_(plante)',
      'lilas'                   => 'Syringa_vulgaris',
      'pensée'                  => 'Viola_(genre_végétal)',
      'myrtile'                 => 'Myrtille',
    },
    8 => {
      'rose'                    => 'Rose_(fleur)',
      'muguet'                  => 'Muguet_de_mai',
      'jacinthe'                => 'Hyacinthus',
      'hyacinthe'               => 'Hyacinthus',
      'rateau'                  => 'Râteau_(outil)',
      'râteau'                  => 'Râteau_(outil)',
      "bâton-d'or"              => 'Erysimum',
      'chamérisier'             => 'Lonicera_xylosteum',
      'ver-à-soie'              => 'Vers_à_soie',
      "corbeille-d'or"          => "Corbeille_d'or",
      'statice'                 => 'Armérie_maritime',
      'staticé'                 => 'Armérie_maritime',
      'carpe'                   => 'Carpe_(poisson)',
      'fusain'                  => "Fusain_d'Europe",
      'civette'                 => 'Ciboulette_(botanique)',
      'houlette'                => 'Houlette_(agriculture)',
    },
    9 => {
      'luzerne'                 => 'Luzerne_cultivée',
      'hémérocale'              => 'Hémérocalle',
      'angélique'               => 'Angelica',
      'fromental'               => 'Fromental_(plante)',
      'faux'                    => 'Faux_(outil)',
      'faulx'                   => 'Faux_(outil)',
      'fraise'                  => 'Fraise_(fruit)',
      'acacia'                  => 'Robinia_pseudoacacia',
      'barbeau'                 => 'Centaurea_cyanus',
      'camomille'               => 'Camomille_romaine',
      'chèvre-feuille'          => 'Chèvrefeuille',
    },
    10 => {
      'avoine'                  => 'Avoine_cultivée',
      'véronique'               => 'Véronique_(plante)',
      'absinthe'                => 'Absinthe_(plante)',
      'giroflée'                => 'Giroflée_des_murailles',
      'gesse'                   => 'Lathyrus',
      'haricots'                => 'Haricot',
      'orcanète'                => 'Orcanette_des_teinturiers',
      'ail'                     => 'Ail_cultivé',
    },
    11 => {
      'épautre'                 => 'Épeautre',
      'épeautre'                => 'Épeautre',
      'melon'                   => 'Melon_(plante)',
      'prèle'                   => 'Sphenophyta',
      'prêle'                   => 'Sphenophyta',
      'mûre'                    => 'Mûre (fruit de la ronce)',
      'panic'                   => 'Panic_(plante)',
      'panis'                   => 'Panic_(plante)',
      'salicor'                 => 'Salicorne',
      'salicorne'               => 'Salicorne',
      'salicot'                 => 'Salicorne',
      'basilic'                 => 'Basilic_(plante)',
      'brebis'                  => 'Mouton',
      'guimauve'                => 'Guimauve_officinale',
      'lin'                     => 'Lin_cultivé',
      'caprier'                 => 'Câprier',
      'lentille'                => 'Lentille_cultivée',
      'myrte'                   => 'Myrtus',
      'myrthe'                  => 'Myrtus',
      'colsa'                   => 'Colza',
    },
    12 => {
      'prune'                   => 'Prune_(fruit)',
      'millet'                  => 'Millet_(graminée)',
      'lycoperde'               => 'Lycoperdon',
      'apocyn'                  => 'Asclepias_syriaca',
      'échelle'                 => 'Échelle_(outil)',
      'cardère'                 => 'Cardère_sauvage',
      'hotte'                   => 'Panier',
      'églantier'               => 'Rosa_canina',
      'sorgho'                  => 'Sorgho_commun',
      'bagarade'                => 'Bigaradier',
      'bigarade'                => 'Bigaradier',
      "verge-d'or"              => "Verge_d'or",
      'marron'                  => 'Marron_(fruit)',
    },
    13 => {
      'labour'                  => 'Manual_labour',
      'rewards'                 => 'Reward_system',
      'revolution'              => 'French Revolution',
    },
  }},
);

no Moose;
__PACKAGE__->meta->make_immutable;

# A module must return a true value. Traditionally, a module returns 1.
# But this module is a revolutionary one, so it discards all old traditions.
# Idea borrowed from Jean Forget's DateTime::Calendar::FrenchRevolutionary.
"Quand le gouvernement viole les droits du peuple,
l'insurrection est pour le peuple le plus sacré
et le plus indispensable des devoirs";
