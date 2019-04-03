use 5.014;
use utf8;
package App::SpreadRevolutionaryDate::MsgMaker::RevolutionaryDate::Locale::it;

# ABSTRACT: Italian localization of (part of) L<DateTime::Calendar::FrenchRevolutionary>

# Source: https://it.wikipedia.org/wiki/Calendario_rivoluzionario_francese
my @months = qw(Vendemmiaio Brumaio   Frimaio
                Nevoso      Piovoso   Ventoso
                Germile     Fiorile   Pratile
                Messidoro   Termidoro Fruttidoro);

push @months, "giorni supplementari";

my @decade_days = qw (Primidì Duodì Tridì Quartidì Quintidì Sestidì Settidì Ottidì Nonidì Decadì);

my @feast = (
# Vendémiaire https://it.wikipedia.org/wiki/Vendemmiaio
        qw(
       2uva                1zafferano          5castagna            0colchico          0cavallo
       5balsamina          5carota             2amaranto            5pastinaca         0tino
       5patata             0perpetuino         5zucca               5reseda            2asino
       5bella di notte     5zucca              0grano_saraceno      0girasole          0torchio
       5canapa             0pesca              5rapa                2amarillide        0bue
       5melanzana          0peperoncino        0pomodoro            2orzo              0barile
        ),
# Brumaire https://it.wikipedia.org/wiki/Brumaio
        qw(
       0mela               0sedano             5pera                5barbabietola      2oca
       2eliotropio         0fico               5scorzonera          0ciavardello       2aratro
       5barba_di_becco     5castagna_d'acqua   0topinambur          2indivia           0tacchino
       0sisaro             0crescione          5piombaggine         0melograno         2erpice
       0baccaro            2azzeruolo          5robbia              2arancia           0fagiano
       0pistacchio         5cicerchia          0cotogno             0sorbo             0rullo
        ),
# Frimaire https://it.wikipedia.org/wiki/Frimaio
        qw(
       0raponzolo          5rapa               5cicoria             0nespolo           0maiale
       0soncino            0cavolfiore         0miele               0ginepro           5zappa
       5cera               0rafano             0cedro               2abete             0capriolo
       0ginestrone         0cipresso           5edera               5sabina            5ascia
       2acero_da_zucchero  2erica              5canna               2acetosa           0grillo
       0pino               0sughero            0tartufo             2oliva             5pala
        ),
# Nivôse https://it.wikipedia.org/wiki/Nevoso
        qw(
       5torba              0carbone_bituminoso 0bitume              0zolfo             0cane
       5lava               5terra_vegetale     0letame              0salnitro          0correggiato
       0granito            5argilla            2ardesia             2arenaria          0coniglio
       5selce              5marna              0calcare             0marmo             0setaccio
       0gesso              0sale               0ferro               0rame              0gatto
       0stagno             0piombo             0zinco               0mercurio          0colino
        ),
# Pluviôse https://it.wikipedia.org/wiki/Piovoso
        qw(
       5dafne_laurella     0muschio            0pungitopo           0bucaneve          0toro
       0viburno            0fungo_dell'esca    5camalea             0pioppo            1scure
       0elleboro           0broccolo           2alloro              0nocciolo          5vacca
       0bosso              0lichene            0tasso               5polmonaria        0coltello_da_potatura
       0thlaspi            5dafne_odorosa      5gramigna            0centinodio        5lepre
       0guado              0nocciolo           0ciclamino           5celidonia         5slitta
        ),
# Ventôse https://it.wikipedia.org/wiki/Ventoso
        qw(
       5tossillagine       0corniolo           5violacciocca        0ligustro          0caprone
       0baccaro_comune     2alaterno           5violetta            0salicone          5vanga
       0narciso            2olmo               5fumaria             2erisimo           5capra
       0spinacio           0doronico           5primula             0cerfoglio         5corda
       5mandragola         0prezzemolo         5coclearia           5margherita        0tonno
       0dente_di_leone     2anemone            0capelvenere         0frassino          0piantatoio
        ),
# Germinal https://it.wikipedia.org/wiki/Germinale
        qw(
       5primula            0platano            2asparago            0tulipano          5gallina
       5bietola            5betulla            0narciso             0ontano            5covata
       5pervinca           0carpino            5spugnola            0faggio            2ape
       5lattuga            0larice             5cicuta              0ravanello         2arnia
       2albero_di_Giuda    5lattuga            0ippocastano         5rucola            0piccione
       0lillà              2anemone            5viola_del_pensiero  0mirtillo          0coltello_da_innesto
        ),
# Floréal https://it.wikipedia.org/wiki/Fiorile
        qw(
       5rosa               5quercia            5felce               0biancospino       0usignolo
       2aquilegia          0mughetto           0fungo               0giacinto          0rastrello
       0rabarbaro          5lupinella          5violacciocca_gialla 5lonicera          0baco_da_seta
       5consolida_maggiore 5pimpinella         2alisso_sassicolo    2atriplice         0sarchiello
       5statice            5fritillaria        5borragine           5valeriana         5carpa
       5fusaggine          5erba_cipollina     5buglossa            0senape            0vincastro
        ),
# Prairial https://it.wikipedia.org/wiki/Pratile
        qw(
       5erba_medica        2emerocallide       0trifoglio           2angelica          2anatra
       5melissa            2avena_altissima    0giglio_martagone    0timo_serpillo     5falce
       5fragola            5betonica           0pisello             5acacia            5quaglia
       0garofano           0sambuco            0papavero            0tiglio            0forcone
       0fiordaliso         5camomilla          0caprifoglio         0caglio            5tinca
       0gelsomino          5verbena            0timo                5peonia            0carro
        ),
# Messidor https://it.wikipedia.org/wiki/Messidoro
        qw(
       5segale             2avena              5cipolla             5veronica          0mulo
       0rosmarino          0cetriolo           1scalogno            2assenzio          0falcetto
       0coriandolo         0carciofo           5violacciocca        5lavanda           0camoscio
       0tabacco            0ribes              5cicerchia           5ciliegia          2ovile
       5menta              0cumino             0fagiolo             2alcanna           5faraona
       5salvia             2aglio              5veccia              0grano             5ciaramella
        ),
# Thermidor https://it.wikipedia.org/wiki/Termidoro
        qw(
       1spelto             0tasso_barbasso     0melone              0loglio            2ariete
       2equiseto           2artemisia          0cartamo             5mora              2annaffiatoio
       2eringio            5salicornia         2albicocca           0basilico          5pecora
       2altea              0lino               5mandorla            5genziana          5chiusa
       5carlina_bianca     0cappero            5lenticchia          2enula             5lontra
       0mirto              5colza              0lupino              0cotone            0mulino
        ),
# Fructidor https://it.wikipedia.org/wiki/Fruttidoro
        qw(
       5prugna             0miglio             5vescia              2orzo_maschio      0salmone
       5tuberosa           2orzo_comune        2apocino             5liquirizia        5scala
       5anguria            0finocchio          5crespino            0noce              5trota
       0limone             0cardo              2alaterno            0garofano_d'India  5gerla
       5rosa_canina        5nocciola           0luppolo             0sorgo             0gambero
       2arancio_amaro      5verga_d'oro        0granoturco          5castagna          5cesta
        ),
# Jours complémentaires
        qw(
       5virtù            0genio            0lavoro           2opinione         6ricompense
       5rivoluzione
         ));
my @prefix = ('giorno del ', 'giorno dello ', "giorno dell'", 'giorno dei ', 'giorno degli ', 'giorno della ', 'giorno delle ');

my %wikipedia_redirect = (
  1 => {
    'zafferano'               => 'Crocus_sativus',
    'colchico'                => 'Colchicum',
    'balsamina'               => 'Impatiens',
    'carota'                  => 'Daucus_carota',
    'amaranto'                => 'Amaranthus',
    'pastinaca'               => 'Pastinaca_(botanica)',
    'tino'                    => 'Tino_(vinificazione)',
    'patata'                  => 'Solanum_tuberosum',
    'perpetuino'              => 'Helichrysum_stoechas',
    'asino'                   => 'Equus_asinus',
    'bella di notte'          => 'Mirabilis_jalapa',
    'torchio'                 => 'Torchio_vinario',
    'canapa'                  => 'Cannabis',
    'pesca'                   => 'Prunus_persica#Frutto',
    'rapa'                    => 'Brassica_rapa_rapa',
    'amarillide'              => 'Amaryllis',
    'bue'                     => 'Bos_taurus',
    'melanzana'               => 'Solanum_melongena',
    'pomodoro'                => 'Solanum_lycopersicum',
    'orzo'                    => 'Hordeum_vulgare',
    'barile'                  => 'Botte',
  },
  2 => {
    'sedano'                  => 'Apium_graveolens',
    'barbabietola'            => 'Beta_vulgaris',
    'fico'                    => 'Ficus',
    'ciavardello'             => 'Sorbus_torminalis',
    'barba_di_becco'          => 'Tragopogon',
    "castagna_d'acqua"        => 'Trapa_natans',
    'topinambur'              => 'Helianthus_tuberosus',
    'indivia'                 => 'Cichorium_endivia',
    'tacchino'                => 'Meleagris',
    'sisaro'                  => 'Sium_sisarum',
    'crescione'               => 'Lepidium_sativum',
    'melograno'               => 'Punica_granatum',
    'baccaro'                 => 'Baccharidinae',
    'azzeruolo'               => 'Crataegus_azarolus',
    'robbia'                  => 'Rubia',
    'arancia'                 => 'Citrus_sinensis',
    'fagiano'                 => 'Phasianidae',
    'pistacchio'              => 'Pistacia_vera',
    'cicerchia'               => 'Lathyrus',
    'cotogno'                 => 'Cydonia_oblonga',
    'sorbo'                   => 'Sorbus_domestica',
    'rullo'                   => 'Rullo_compattatore',
  },
  3 => {
    'raponzolo'               => 'Phyteuma',
    'rapa'                    => 'Brassica_rapa_rapa',
    'cicoria'                 => 'Cichorium_intybus',
    'nespolo'                 => 'Mespilus_germanica',
    'maiale'                  => 'Sus_scrofa_domesticus',
    'soncino'                 => 'Valerianella_locusta',
    'cavolfiore'              => 'Brassica_oleracea_var._botrytis',
    'ginepro '                => 'Juniperus',
    'zappa'                   => 'Zappa_(attrezzo)',
    'rafano'                  => 'Armoracia_rusticana',
    'cedro'                   => 'Cedrus',
    'abete'                   => 'Abies',
    'capriolo'                => 'Capreolus_capreolus',
    'ginestrone'              => 'Ulex',
    'cipresso'                => 'Cupressus',
    'sabina'                  => 'Juniperus',
    'acero_da_zucchero'       => 'Acer_saccharum',
    'canna'                   => 'Arundo_donax',
    'acetosa'                 => 'Rumex_acetosa',
    'grillo'                  => 'Gryllidae',
    'pino'                    => 'Pinus',
    'tartufo'                 => 'Tuber_(micologia)',
    'pala'                    => 'Pala_(attrezzo)',
  },
  4 => {
    'carbone_bituminoso'      => 'Carbone#Litantrace',
    'cane'                    => 'Canis_lupus_familiaris',
    'terra_vegetale'          => 'Humus',
    'salnitro'                => 'Nitrato_di_potassio',
    'marna'                   => 'Marna_(roccia)',
    'gesso'                   => 'Gesso_(minerale)',
    'sale'                    => 'Cloruro_di_sodio',
    'gatto'                   => 'Felis_silvestris_catus',
    'stagno'                  => 'Stagno_(elemento_chimico)',
    'mercurio'                => 'Mercurio_(elemento_chimico)',
  },
  5 => {
    'dafne_laurella'          => 'Daphne_laureola',
    'muschio'                 => 'Bryophyta',
    'pungitopo'               => 'Ruscus_aculeatus',
    'bucaneve'                => 'Galanthus_nivalis',
    'toro'                    => 'Bos_taurus',
    'viburno'                 => 'Viburnum',
    "fungo_dell'esca"         => 'Fomes_fomentarius',
    'camalea'                 => 'Daphne_mezereum',
    'pioppo'                  => 'Populus',
    'elleboro'                => 'Helleborus',
    'broccolo'                => 'Brassica_oleracea',
    'alloro'                  => 'Laurus_nobilis',
    'nocciolo'                => 'Corylus_avellana',
    'vacca'                   => 'Bos_taurus',
    'bosso'                   => 'Buxus',
    'tasso'                   => 'Taxus',
    'polmonaria'              => 'Pulmonaria_officinalis',
    'coltello_da_potatura'    => 'Falcetto',
    'dafne_odorosa'           => 'Daphne_gnidium',
    'gramigna'                => 'Cynodon_dactylon',
    'centinodio'              => 'Polygonum_aviculare',
    'lepre'                   => 'Lepus_europaeus',
    'guado'                   => 'Isatis_tinctoria',
    'nocciolo'                => 'Corylus_avellana',
    'ciclamino'               => 'Cyclamen',
    'celidonia'               => 'Chelidonium_majus',
  },
  6 =>  {
    'tossillagine'            => 'Tussilago_farfara',
    'corniolo'                => 'Cornus_mas',
    'violacciocca'            => 'Matthiola_incana',
    'ligustro'                => 'Ligustrum',
    'caprone'                 => 'Caprinae',
    'baccaro_comune'          => 'Asarum_europaeum',
    'alaterno'                => 'Rhamnus_alaternus',
    'violetta'                => 'Viola_(botanica)',
    'salicone'                => 'Salix_caprea',
    'narciso'                 => 'Narcissus',
    'olmo'                    => 'Ulmus',
    'erisimo'                 => 'Sisymbrium_officinale',
    'capra'                   => 'Capra_(zoologia)',
    'spinacio'                => 'Spinacia_oleracea',
    'doronico'                => 'Doronicum',
    'cerfoglio'               => 'Anthriscus_cerefolium',
    'mandragola'              => 'Mandragora',
    'prezzemolo'              => 'Petroselinum_crispum',
    'coclearia'               => 'Armoracia_rusticana',
    'margherita'              => 'Bellis_perennis',
    'tonno'                   => 'Thunnus',
    'dente_di_leone'          => 'Taraxacum_officinale',
    'capelvenere'             => 'Adiantum_capillus-veneris',
    'frassino'                => 'Fraxinus',
  },
  7 => {
    'platano'                 => 'Platanus',
    'asparago'                => 'Asparagus_officinalis',
    'tulipano'                => 'Tulipa',
    'gallina'                 => 'Gallus_gallus_domesticus',
    'betulla'                 => 'Betula',
    'narciso'                 => 'Narcissus',
    'ontano'                  => 'Alnus',
    'covata'                  => 'Incubatrice_(zootecnia)',
    'pervinca'                => 'Vinca',
    'carpino'                 => 'Carpinus',
    'spugnola'                => 'Morchella',
    'faggio'                  => 'Fagus',
    'ape'                     => 'Apis',
    'lattuga'                 => 'Lactuca_sativa',
    'larice'                  => 'Larix',
    'ravanello'               => 'Raphanus_sativus',
    'albero_di_Giuda'         => 'Cercis_siliquastrum',
    'lattuga'                 => 'Lactuca_sativa',
    'ippocastano'             => 'Aesculus_hippocastanum',
    'rucola'                  => 'Eruca_vesicaria',
    'piccione'                => 'Columba_livia',
    'lillà'                   => 'Syringa',
    'viola_del_pensiero'      => 'Viola_tricolor',
    'mirtillo'                => 'Vaccinium',
    'coltello_da_innesto'     => 'Innesto',
  },
  8 => {
    'rosa'                    => 'Rosa_(botanica)',
    'quercia'                 => 'Quercus',
    'felce'                   => 'Pteridophyta',
    'biancospino'             => 'Crataegus_monogyna',
    'usignolo'                => 'Luscinia_megarhynchos',
    'mughetto'                => 'Convallaria_majalis',
    'fungo'                   => 'Fungi',
    'giacinto'                => 'Hyacinthus',
    'rabarbaro'               => 'Rheum',
    'lupinella'               => 'Lupinus',
    'violacciocca_gialla'     => 'Erysimum_bonannianum',
    'baco_da_seta'            => 'Bombyx_mori',
    'consolida_maggiore'      => 'Symphytum_officinale',
    'pimpinella'              => 'Pimpinella_major',
    'alisso_sassicolo'        => 'Alyssum',
    'atriplice'               => 'Atriplex_hortensis',
    'sarchiello'              => 'Sarchiatura',
    'statice'                 => 'Armeria_(botanica)',
    'borragine'               => 'Borago_officinalis',
    'carpa'                   => 'Cyprinus_carpio',
    'fusaggine'               => 'Euonymus_europaeus',
    'erba_cipollina'          => 'Allium_schoenoprasum',
    'buglossa'                => 'Anchusa',
  },
  9 => {
    'erba_medica'             => 'Medicago_sativa',
    'emerocallide'            => 'Hemerocallis',
    'trifoglio'               => 'Trifolium',
    'angelica'                => 'Angelica_(botanica)',
    'melissa'                 => 'Melissa_(botanica)',
    'avena_altissima'         => 'Arrhenatherum_elatius',
    'giglio_martagone'        => 'Lilium_martagon',
    'timo_serpillo'           => 'Thymus_serpyllum',
    'falce'                   => 'Falce_(attrezzo)',
    'betonica'                => 'Stachys_officinalis',
    'pisello'                 => 'Pisum_sativum',
    'quaglia'                 => 'Coturnix_coturnix',
    'garofano'                => 'Dianthus_caryophyllus',
    'sambuco'                 => 'Sambucus',
    'papavero'                => 'Papaver',
    'tiglio'                  => 'Tilia',
    'forcone'                 => 'Forca_(attrezzo)',
    'fiordaliso'              => 'Centaurea_cyanus',
    'camomilla'               => 'Matricaria_chamomilla',
    'caprifoglio'             => 'Lonicera',
    'caglio'                  => 'Galium',
    'tinca'                   => 'Tinca_tinca',
    'gelsomino'               => 'Jasminum',
    'verbena'                 => 'Verbena_(botanica)',
    'timo'                    => 'Thymus',
    'peonia'                  => 'Paeonia',
    'carro'                   => 'Carro_(trasporto)',
  },
  10 => {
    'segale'                  => 'Secale_cereale',
    'avena'                   => 'Avena_sativa',
    'cipolla'                 => 'Allium_cepa',
    'veronica'                => 'Veronica_(botanica)',
    'rosmarino'               => 'Rosmarinus_officinalis',
    'cetriolo'                => 'Cucumis_sativus',
    'scalogno'                => 'Allium_ascalonicum',
    'assenzio'                => 'Artemisia_absinthium',
    'coriandolo'              => 'Coriandrum_sativum',
    'carciofo'                => 'Cynara_scolymus',
    'violacciocca'            => 'Matthiola_incana',
    'lavanda'                 => 'Lavandula',
    'camoscio'                => 'Rupicapra',
    'cicerchia'               => 'Lathyrus',
    'menta'                   => 'Mentha',
    'cumino'                  => 'Cuminum_cyminum',
    'fagiolo'                 => 'Phaseolus_vulgaris',
    'alcanna'                 => 'Alkanna_tinctoria',
    'faraona'                 => 'Numida_meleagris',
    'aglio'                   => 'Allium_sativum',
    'veccia'                  => 'Vicia_sativa',
    'grano'                   => 'Triticum',
  },
  11 => {
    'spelto'                  => 'Triticum_spelta',
    'tasso_barbasso'          => 'Verbascum_thapsus',
    'melone'                  => 'Cucumis_melo',
    'loglio'                  => 'Lolium',
    'ariete'                  => 'Ovis_aries',
    'equiseto'                => 'Equisetum',
    'cartamo'                 => 'Carthamus_tinctorius',
    'mora'                    => 'Rubus_ulmifolius',
    'eringio'                 => 'Panicum',
    'basilico'                => 'Ocimum_basilicum',
    'pecora'                  => 'Ovis_aries',
    'altea'                   => 'Althaea_officinalis',
    'lino'                    => 'Linum_usitatissimum',
    'genziana'                => 'Gentiana',
    'chiusa'                  => 'Chiusa_(ingegneria)',
    'carlina_bianca'          => 'Carlina',
    'cappero'                 => 'Capparis_spinosa',
    'lenticchia'              => 'Lens_culinaris',
    'enula'                   => 'Inula',
    'lontra'                  => 'Lutrinae',
    'mirto'                   => 'Myrtus',
    'colza'                   => 'Brassica_napus',
    'lupino'                  => 'Lupinus',
    'cotone'                  => 'Cotone_(fibra)',
  },
  12 => {
    'prugna'                  => 'Prunus_domestica',
    'miglio'                  => 'Panicum_miliaceum',
    'vescia'                  => 'Lycoperdon_perlatum',
    'orzo_maschio'            => 'Hordeum',
    'salmone'                 => 'Salmonidae',
    'tuberosa'                => 'Polianthes',
    'orzo_comune'             => 'Hordeum_vulgare',
    'apocino'                 => 'Asclepiadoideae',
    'liquirizia'              => 'Glycyrrhiza_glabra',
    'scala'                   => 'Scala_(utensile)',
    'anguria'                 => 'Citrullus_lanatu',
    'finocchio'               => 'Foeniculum_vulgare',
    'crespino'                => 'Berberis_vulgaris',
    'noce'                    => 'Noce_(frutto)',
    'limone'                  => 'Citrus_limon',
    'cardo'                   => 'Carduus',
    'alaterno'                => 'Rhamnus_alaternus',
    "garofano_d'India"        => 'Tagetes',
    'luppolo'                 => 'Humulus_lupulus',
    'sorgo'                   => 'Sorghum_vulgare',
    'arancio_amaro'           => 'Citrus_×_aurantium',
    "verga_d'oro"             => 'Solidago_virgaurea',
    'granoturco'              => 'Zea_mays',
    'cesta'                   => 'Cesto',
  },
  13 => {
    'genio'                   => 'Genio_(filosofia)',
    'ricompense'              => 'Sistema_di_ricompensa',
    'rivoluzione'             => 'Rivoluzione_francese',
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
  $lb =~ s/_/ /g;
  return substr($lb, 1);
}

=method feast_long

Returns the feast of the day in long format (day of xxx). Takes a DateTime::Calendar::FrenchRevolutionary object as mandatory parameter.

=cut

sub feast_long {
  my ($self, $date) = @_;
  my $lb = $feast[$date->day_of_year_0];
  $lb =~ s/_/ /g;
  $lb =~ s/^(\d)/$prefix[$1]/;
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
