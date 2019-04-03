use 5.014;
use utf8;
package App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale::en;

# ABSTRACT: English localization of (part of) L<DateTime::Calendar::FrenchRevolutionary::Locale::en>

# based on Thomas Carlyle's book:
my @months = qw(Vintagearious Fogarious Frostarious
                Snowous       Rainous   Windous
                Buddal        Floweral  Meadowal
                Reapidor      Heatidor  Fruitidor);

push @months, "additional day";

my @decade_days = qw (Firsday Seconday Thirday Fourday Fifday Sixday Sevenday Eightday Nineday Tenday);

my @feast = (
# Vendémiaire
        qw(
       grape                saffron         chestnut        crocus          horse
       balsam               carrot          amaranth        parsnip         vat
       potato               everlasting     winter_squash   mignonette      donkey
       four_o'clock_flower  pumpkin         buckwheat       sunflower       wine-press
       hemp                 peach           turnip          amaryllis       ox
       eggplant             chili_pepper    tomato          barley          barrel
        ),
# Brumaire
        qw(
       apple                celery          pear                    beetroot        goose
       heliotrope           fig             black_salsify           chequer_tree    plow
       salsify              water_chestnut  jerusalem_artichoke     endive          turkey
       skirret              cress           leadworts               pomegranate     harrow
       baccharis            azarole         madder                  orange          pheasant
       pistachio            tuberous_pea    quince                  service_tree    roller
        ),
# Frimaire
        qw(
       rampion              turnip          chicory         medlar          pig
       corn_salad           cauliflower     honey           juniper         pickaxe
       wax                  horseradish     cedar_tree      fir_tree        roe_deer
       gorse                cypress_tree    ivy             savin_juniper   grub-hoe
       maple_tree           heather         reed            sorrel          cricket
       pine_nut             cork            truffle         olive           shovel
        ),
# Nivôse
        qw(
       peat                 coal           bitumen         sulphur         dog
       lava                 topsoil        manure          saltpeter       flail
       granite              clay           slate           sandstone       rabbit
       flint                marl           limestone       marble          winnowing_basket
       gypsum               salt           iron            copper          cat
       tin                  lead           zinc            mercury         sieve
        ),
# Pluviôse
        qw(
       spurge_laurel        moss            butcher's_broom snowdrop                bull
       laurustinus          tinder_polypore mezereon        poplar_tree             axe
       hellebore            broccoli        laurel          common_hazel            cow
       box_tree             lichen          yew_tree        lungwort                billhook
       penny-cress          daphne          couch_grass     common_knotgrass        hare
       woad                 hazel_tree      cyclamen        celandine               sleigh
        ),
# Ventôse
        qw(
       coltsfoot            dogwood                   matthiola         privet          billygoat
       wild_ginger          mediterranean_buckthorn   violet            goat_willow     spade
       narcissus            elm_tree                  fumitory          hedge_mustard   goat
       spinach              leopard's_bane            pimpernel         chervil         line
       mandrake             parsley                   scurvy-grass      daisy           tuna_fish
       dandelion            windflower                maidenhair_fern   ash_tree        dibble
        ),
# Germinal
        qw(
       primula              plane_tree      asparagus       tulip           hen
       chard                birch_tree      daffodil        alder           hatchery
       periwinkle           hornbeam        morel           beech_tree      bee
       lettuce              larch           hemlock         radish          hive
       judas_tree           roman_lettuce   chestnut_tree   rocket          pigeon
       lilac                anemone         pansy           blueberry       dibber
        ),
# Floréal
        qw(
       rose                 oak_tree                fern            hawthorn        nightingale
       columbine            lily_of_the_valley      mushroom        hyacinth        rake
       rhubarb              sainfoin                wallflower      fan_palm_tree   silkworm
       comfrey              burnet                  basket_of_gold  orache          hoe
       thrift               fritillary              borage          valerian        carp
       spindletree          chive                   bugloss         wild_mustard    shepherd_staff
        ),
# Prairial
        qw(
       alfalfa              day-lily        clover          angelica        duck
       lemon_balm           oat_grass       martagon        wild_thyme      scythe
       strawberry           betony          pea             acacia          quail
       carnation            elder_tree      poppy           lime            pitchfork
       barbel               camomile        honeysuckle     bedstraw        tench
       jasmine              vervain         thyme           peony           carriage
        ),
# Messidor
        qw(
       rye                  oats            onion           speedwell       mule
       rosemary             cucumber        shallot         wormwood        sickle
       coriander            artichoke       clove           lavender        chamois
       tobacco              currant         vetchling       cherry          park
       mint                 cumin           bean            alkanet         guinea_hen
       sage                 garlic          tare            corn            shawm
        ),
# Thermidor
        qw(
       spelt                mullein         melon           ryegrass        ram
       horsetail            mugwort         safflower       blackberry      watering_can
       switchgrass          glasswort       apricot         basil           ewe
       marshmallow          flax            almond          gentian         waterlock
       carline_thistle      caper           lentil          horseheal       otter
       myrtle               oil-seed_rape   lupin           cotton          mill
        ),
# Fructidor
        qw(
       plum                 millet          lycoperdon      barley          salmon
       tuberose             bere            dogbane         liquorice       stepladder
       watermelon           fennel          barberry        walnut          trout
       lemon                teasel          buckthorn       marigold        harvesting_basket
       wild_rose            hazelnut        hops            sorghum         crayfish
       bitter_orange        goldenrod       corn            chestnut        basket
        ),
# Jours complémentaires
        qw(
       virtue               engineering    labour          opinion          rewards
       revolution
         ));

my %wikipedia_redirect = (
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
);

=method new

Constructor. Takes no parameter. Returns an empty object.

=cut

sub new {
  return bless {},  $_[0];
}

=method month_name

Returns the name of the month. Takes a DateTime::Calendar::FrenchRevolutionary object as mandatory parameter.

=cut

sub month_name {
    my ($self, $date) = @_;
    return $months[$date->month_0]
}

=method day_name

Returns the name of the day. Takes a DateTime::Calendar::FrenchRevolutionary object as mandatory parameter.

=cut

sub day_name {
    my ($self, $date) = @_;
    return $decade_days[$date->day_of_decade_0];
}

=method feast_short

Returns the feast of the day. Takes a DateTime::Calendar::FrenchRevolutionary object as mandatory parameter.

=cut

sub feast_short {
  my ($self, $date) = @_;
  my $lb = $feast[$date->day_of_year_0];
  $lb =~ s/^\?//;
  $lb =~ s/_/ /g;
  return $lb;
}

=method feast_long

Returns the feast of the day in long format (day of xxx). Takes a DateTime::Calendar::FrenchRevolutionary object as mandatory parameter.

=cut

sub feast_long {
  my ($self, $date) = @_;
  my $lb = $feast[$date->day_of_year_0] . " day";
  $lb =~ s/^\?//;
  $lb =~ s/_/ /g;
  return $lb;
}

=method wikipedia_redirect

Returns the wikipedia entry (the end of the wikipedia url) corresponding to the feast of the day. Takes a DateTime::Calendar::FrenchRevolutionary object as mandatory parameter.

=cut

sub wikipedia_redirect {
  my ($self, $month, $entry) = @_;
  $entry = $wikipedia_redirect{$month}->{$entry}
      if    exists $wikipedia_redirect{$month}
         && exists $wikipedia_redirect{$month}->{$entry};
  return $entry;
}

# A module must return a true value. Traditionally, a module returns 1.
# But this module is a revolutionary one, so it discards all old traditions.
# Idea borrowed from Jean Forget's DateTime::Calendar::FrenchRevolutionary.
"Quand le gouvernement viole les droits du peuple,
l'insurrection est pour le peuple le plus sacré
et le plus indispensable des devoirs";
