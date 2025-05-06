# Formation à l'analyse de données RNASeq

Notes issues de la formation BIBS 2025

## Rappels Bio

Plusieurs type d'ARN : rRNA, tRNA, mRNA mais on s'intéresse surtout aux mRNA
Dans l'ADN il y a des introns qui ne sont pas dans l'ARN messager 
Pour l'humain : pas besoin de rétro transformation (gènes codés dans les deux sens)
Eviter trop grand nombre de cycles de PCR pour conserver des données exploitables en RNAseq

SEQUENCAGE ILLUMINA :
PE toujours mieux que SE
Profondeur de séquençage : quantité de reads par échantillon (dépend des gènes d'intérêt - s'ils sont peu ou bcp exprimés)

## Jeu de données

Pour faire une analyse DEG entre deux conditions, il faut au moins **trois réplicas** par condition/groupe de conditions.

Jeu de données exemple de la formation :

RNA de souris :
- Données contrôle
- Données gènes sur exprimés
- Données gènes sous exprimés
3 réplicas par groupes
Uniquement reads qui map sur le chromosome 1

## FASTQC & MULTIQC

Avec les fastq il y a parfois des fichiers ".md5" => ils permettent de vérifier l'intégrité des données. Idéalement il faut vérifier l'intégrité de tous les fichiers grâce à la commande : 
`md5sum raw_fastq/*` (vérifie le contenu des fichier (toujours même suite de 20 chiffres/lettres))

Aide à l'interpretation du multiQC :

- **Premier tableau** : regarder la colonne GC, qui doit donner la même proportion pour tous les échantillons => sinon pas normal, il faudra comprendre pourquoi (peut etre si un gene est sur exprimé chez un patient malade et pas chez l'autre. /!\ Ca doit correspondre à qq chose)

- **Réplicas** : normal, par exemple sur les gènes petits très exprimés il y a des chances qu'il soit coupés plrs fois au même moment. Ca peut aussi être du à beaucoup de cycles de PCR qui amplifient plrs fois le même fragment (attention a éviter de faire trop de PCR)

- **Mean quality scores** : Qualité de 30 = la propba que la base soit fausse est de 1 pour 1000
Ce graph donne pour chaque position de base la moyenne de qualité du read

- **Per Sequence Quality Scores** : Qualité moyenne de chacun des read (exemple pour 10 = 1 erreur sur 10 nucléotide)

- **Per base sequence content** : 
  - Illumina : sur les 10 premieres BP biais lié à la méthode (donc courbes bizarres) => si bizarre sur 20 bases : cela signifie qu'il y a des UMI
  - Novaseq : reads long de 150 pairs de base : ajoute par défaut des G => il faudra trimmer les read

- **Per Sequence GC Content** : On s'attend, si une seule espèces dans les échantillons, à une courbe de gausse. S'il y a des contaminants (gènes surexprimés par rapport au génome, autre espèce, virus, etc...) alors on observe d'autres pics ! (infection ou autre ...) => il faudra trouver une explication 
Si pic "étrange", à garder en tête et lors de la DEG essayer de comprendre d'où ça vient. On pourra regarder les reads qui ont des CG correspondant au pic pour comprendre d'où ça vient.

- **Sequence Duplication Levels** : RAS

- **Overrepresented sequences** : Faire attention qu'il n'y ait pas d'adaptateur dans la liste des sur représentés. Pour savoir à quoi correspondent ces séquences, il faut vérifier sur le site GEO avec l'outil Blast (permet de savoir si c'est une contamination) : https://blast.ncbi.nlm.nih.gov/Blast.cgi?PROGRAM=blastn&BLAST_SPEC=GeoBlast&PAGE_TYPE=BlastSearch 

## Mapping

### Deux types de mapping (alignement)

**Mapping sur le génome : **

- Si on a un reads qui mappent de façon équivalente sur deux gènes : plusieurs possibilités à choisir par l'utilisateur (soit compté 50/50 sont pas compté du tout, soir compté que sur l'un etc..)
- le fichier SAM renvoie pour chaque read le chromosome sur lequel match le read et la position. Puis a l'aide d'un fichier de référence on sait que tel position sur tel chromosome correspond a tel gène
- BAM = SAM compressé 
- Attention au fichier d'index : version de l'annotation, il est important qu'il soit à jour

**Mapping sur le transcriptome : **

- Probabilité d'appartenir à chaque gène en analysant le reste du gène
- Si transcriptome de bonne qualité on peut faire uniquement sur le transcrit et vérifier le signal sur le génome
- Salmon fait une analyse kmer => c'est pour ça qu'on appel quasi mapping car ce n'est pas un vrai alignement

### Création de l'index (trnascriptome)

- Si on s'interesse aussi au virus ou bactérie dans un échantillon Humain, il faut concaténer les transcriptomes humains et des virus !! pour pouvoir reconnaitre les deux :

Il est possible de concaténer des transcriptomes = voir point 3. du doc en ligne. On peut aussi concaténer transcriptome et génome pour éliminer les reads qui mappent sur une partie non codante du génome et ainsi éviter que certains reads ne mappent par erreur sur un transcrit (agit comme un leurre = decoy). 
C'est un paramètre à ajouter dans la création de l'index :
    - Paramètre `--decoys`  => ajouter en plus du transcriptome classique des sequences qui seront mappées mais qui par la suite ne seront pas quantfiées = peut permettre d'eviter certains biais selon les cas de figure
    - Dans transcrit fa rajouter les chromosomes et dans decoys la liste des sequeneces qu'on ne voudra pas utiliser
        ==> conseillé de faire "human cDNA + human as decoy sequences" dans la partie 1.1. Creating transcriptome index :
     c'est plus précis car si un reads map mieux sur le genome il sera mapé dessus au lieu d'etre mappé a tord sur un transcrit et dans le compte on ne prendra pas en compte les reads mappés sur le génome, c'est ce qu'on précise dans decoy sequence

- Taille des kmer pour la creation de l'index : 31 (valeur par defaut) bien pour des reads de 75 ou plus par contre si reads plus petits utiliser une autre valeur de -k (paramètre kmer) 

- Annotation des gènes : ENSG -> gène ; ENST -> transcrit

#### Format fasta et fastq 

**fastq :**
 
@nomsequence
sequence
+
qualité

**fasta :**

> nomsequence
sequence (parfois sur plrs lignes)

>

### Paramètres et détail

Plusieurs paramètres pour l'alignement :
- stranded : sens du read qui permet de faire l'alignement en le précisant dans salmon (not stranded fera dans les deux sans). Le paramètre automatique par défaut calcul si c'est stranded ou pas sur un échantillon

=> Il existe plusieurs transcrits pour un même gène. La référence est vraiment le code ensemble pour les analyses bio-informatiques !!!! Toujours faire les analyses avec les code ensemble des gènes.
=> Le mieux c'est d'avoir un mapping >80%

Mapping sur le génome :
=> STAR : permet de vérifier que les reads recouvrent l'ensemble des gènes
=> INDEX : genomeSAindexNbases 12 : laisser par defaut, si genome trop petit il faudra diminuer la valeur de ce parametre mais pour humain ok
=> ALIGNEMENT : utiliser fichiers compressés. en fonction des noms des reads ou de la position ou ils mappent : outSAMtype BAM SortedByCoordinate

Dans mon cas :
Le patient qui a que 50% d'alignement a pas le meme type de librairy detecté par salmon (IU au lieu de ISR) : https://salmon.readthedocs.io/en/latest/library_type.html 
Vérifier que j'ai bien tous les fichier, sinon je peux forcer la Library type ISR maintenant que je sais que c'est ça 



