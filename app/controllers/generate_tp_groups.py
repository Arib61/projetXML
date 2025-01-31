import subprocess
import os

def execute_xquery():
    """
    Exécute une requête XQuery sur un fichier XML et sauvegarde le résultat.
    """

    try:
        # Obtenir le répertoire du script actuel
        BASE_DIR = os.path.dirname(os.path.abspath(__file__))

        # Définition des chemins corrects
        input_xml = os.path.abspath(os.path.join(BASE_DIR, "../../data_generated/students/Students_GINF2.xml"))
        output_xml = os.path.abspath(os.path.join(BASE_DIR, "../../data_generated/tp/TP_GINF2.xml"))
        xquery_file = os.path.abspath(os.path.join(BASE_DIR, "queries/divide_groups.xquery"))

        # Vérifier si les fichiers existent
        if not os.path.exists(input_xml):
            print(f"❌ Erreur : Le fichier XML source est introuvable : '{input_xml}'")
            return

        if not os.path.exists(xquery_file):
            print(f"❌ Erreur : Le fichier XQuery est introuvable : '{xquery_file}'")
            return

        # Assurer que le dossier de sortie existe
        os.makedirs(os.path.dirname(output_xml), exist_ok=True)

        # Construire la commande BaseX
        command = f'basex -binput="{input_xml}" -o"{output_xml}" "{xquery_file}"'
        print(f"📌 Exécution de la commande : {command}")

        # Exécuter la commande
        subprocess.run(command, shell=True, check=True)

        print(f"✅ Fichier XML généré avec succès : {output_xml}")

    except subprocess.CalledProcessError as e:
        print(f"❌ Erreur lors de l'exécution de la requête XQuery : {e}")
    except Exception as e:
        print(f"❌ Erreur inattendue : {e}")

if __name__ == "__main__":
    execute_xquery()
