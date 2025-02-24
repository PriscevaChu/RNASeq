# Installation des différents logiciels nécessaires à l'analyse de données RNASeq

Etapes à suivre pour l'installation des différents outils d'analyse RNASeq sur *Windows*.

## Pré-requis

La quasi totalité des outils sont des commandes bash. Il est donc nécessaire de travailler sur un serveur/PC capable d'interpreter le bash. *Mac OS*, *Linux* ou *Windows 10* interprètent par défaut ces commandes. 

Dans le cas de *Windows 11* il faut installer un sous-systeme *Windows* pour *Linux* en suivant les instructions suivantes :

1. Ouvrir un invite de commande **en tant qu'administrateur**
2. Installer *wsl 2* avec la commande : `wsl --install`
3. Redémarer 
4. Ouvrir l'application *Ubuntu* (lors de la première ouverture, configurer les informations utilisateur)

Pour plusieurs outils, il sera nécessaire d'avoir également installé *Java JRE*, pour cela :

1. Ouvrir *Ubuntu*
2. Vérifier si *Java* est déjà installé : `java -version`
3. Mettre à jour les paquets : `sudo apt update` (faire attention lors le l'utilisation de la commande *sudo* !)  
4. Installer *Java* en lançant la commande : `sudo apt install default-jre` 

Tout est prêt !

**Note :** Les conseils d'installation qui suivent sont spécifiquement liés à l'utilisation d'un système *Windows*. Les installations présentées se font à partir des fichiers binaires pré-compilés qui seront téléchargés sur les sites dédiés à chacun des outils.
L'utilisation de *Mac OS* ou *Linux* permet l'installation simplifiée des packages via *miniconda3*, *bioconda* et la commande *conda*.

## Installation des packages 

Pour l'installation des packages, il est conseillé de créer un dossier *apps/* dans lequel seront répertoriées toutes les applications :

1. Ouvrir un terminal de commande (invite de commande ou *PowerShell*) dans *Windows*
2. Ouvrir un "sous terminal" avec *wsl* avec la commande : `bash` (les commandes *Linux* sont désormais accessibles)
3. Se rendre dans le dossier racine avec la commande : `cd`
4. Créer le dossier *apps* : `mkdir apps`
5. Se rendre dans ce dossier pour télécharger les packages : `cd apps`

### Installer *SRA*

1. Télécharger les fichiers binaires (ubuntu) pré-compilés à partir du site (https://github.com/ncbi/sra-tools/wiki/02.-Installing-SRA-Toolkit) 
directement avec la commande : `wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz` 
2. Décompresser le dossier : `tar sratoolkit.current-ubuntu64.tar.gz`
3. (Supprimer la fichier compressé : `rm sratoolkit.current-ubuntu64.tar.gz`) 
4. Aller dans le dossier bin : `cd sratoolkit.3.2.0-ubuntu64/bin`
5. Faire la configuration détaillée ici : https://github.com/ncbi/sra-tools/wiki/03.-Quick-Toolkit-Configuration
4. Vérifier le fonctionnement : `./fastq-dump - h`

### Installer *FastC*

1. Télécharger les fichiers binaires pré-compilés à partir du site (https://www.bioinformatics.babraham.ac.uk/projects/fastqc) 
directement avec la commande : `wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.12.1.zip` 
2. Décompresser le dossier : `unzip fastqc_v0.12.zip`
3. (Supprimer la fichier compressé : `rm fastqc_v0.12.zip`) 
4. Vérifier le fonctionnement : `./FastQC/fastqc - h`

### Installer *multiQC* 

multiQC est développé en python et peut donc être directement installé dans un environnement python puis lancé en python :

1. Installer python (si pas déjà fait)
2. Ouvrir un éditeur de code (ex : vscode)
3. Créer ou ouvrir un workspace avec (VScode) : *Ctrl+Shift+f* (dans le dossier du projet par exemple)
4. Dans le terminal : 
    1. Créer un environnement virtuel en lançant : `python -m venv myEnvName` (que la première fois)
    2. Activer l'environnement via le terminal : `myEnvName/Scripts/activate`
    3. installer *multiqc* : `pip install multiqc`  

### Installer *fastp* 

1. Créer un dossier pour l'app : `mkdir fastp` 
2. Puis se mettre à l'intérieur : `cd fastp` 
3. Télécharger les fichiers binaires pré-compilés à partir du site (https://opengene.org/fastp/fastp.$) 
directement avec la commande : `wget http://opengene.org/fastp/fastp` 
4. Vérifier le fonctionnement : `./fastp/fastp - h`

### Installer *salmon* 

1. Télécharger les fichiers binaires pré-compilés (pas le code source) à partir du site (https://github.com/COMBINE-lab/salmon/releases) 
directement avec la commande : `wget https://github.com/COMBINE-lab/salmon/releases/download/v1.9.0/salmon-1.9.0_linux_x86_64.tar.gz` 
2. Décompresser le dossier : `tar salmon-1.9.0_linux_x86_64.tar.gz`
3. (Supprimer la fichier compressé : `rm salmon-1.9.0_linux_x86_64.tar.gz`) 
4. Vérifier le fonctionnement : `./salmon-latest_linux_x86_64/bin/salmon - h`

### Installer *STAR* 

1. Télécharger les fichiers binaires pré-compilés (pas le code source) à partir du site (https://github.com/alexdobin/STAR/releases/tag/2.7.11b) 
directement avec la commande : `wget https://github.com/alexdobin/STAR/releases/download/2.7.11b/STAR_2.7.11b.zip` 
2. Décompresser le dossier : `unzip STAR_2.7.11b.zip`
3. (Supprimer la fichier compressé : `rm STAR_2.7.11b.zip`) 
4. Vérifier le fonctionnement : `./STAR_2.7.11b/Linux_x86_64_static/STAR - h`

## Paramétrages pour l'utilisation 

Afin de pouvoir utiliser ces logiciels directement en ligne de commande sans avoir à appeler le full path, il est nécessaire de modifier le fichier de configuration wsl pour lui préciser les localisations des commandes que l'on vient de rajouter.
Pour cela il faut ajouter tous les chemins crés vers les apps dans le *PATH* : 

1. Se mettre dans le dossier racine : `cd`
2. Garder une copie du fichier de configuration .profile : `cp .profile profile-bak`
3. Modifier le fichier de configuration : `nano .profile` :
    1. Aller à la fin du fichier en utilisant les flèches du clavier
    2. Ajouter la ligne suivante : `PATH=$PATH:home/myusername/apps/FastQC:home/myusername/apps/salmon-latest_linux_x86_64/bin` etc... avec tous les chemins vers les dossiers contenant les binaires des packages (séparés par ":")

Les termes *salmon*, *fastp*, *fastqc-dump* pourront être directement utilisés pour lancer les commandes.

Concernant le package pyhton, il est nécessaire de bien penser à activier l'environnement contenant le package afin de pouvoir l'utiliser ! 