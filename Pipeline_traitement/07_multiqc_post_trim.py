# Créer l'environnement : python -m venv nomenv
# Activer l'environnement : nomenv/Scripts/activate
# Charger le package : pip install multiqc

import multiqc

multiqc.run("C:/Users/prisc/Documents/Etudes/RNA_melanome_rawdata/out/04_QC_fastqc_post_trim")

# Ou directement dans le terminal après avoir activer l'environnement contenant le package :
# multiqc chemin_fastqc_files -o chemin_enregistrement_resultats