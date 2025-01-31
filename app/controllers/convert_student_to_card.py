import xml.etree.ElementTree as ET


def indent(elem, level=0):
    """
    Indente l'élément XML pour une meilleure lisibilité.
    """
    i = "\n" + "  " * level
    if len(elem):
        if not elem.text or not elem.text.strip():
            elem.text = i + "  "
        for child in elem:
            indent(child, level + 1)
        if not elem.tail or not elem.tail.strip():
            elem.tail = i
    else:
        if level and (not elem.tail or not elem.tail.strip()):
            elem.tail = i


def generate_student_cards(input_file, output_file):
    """
    Génère un fichier XML contenant toutes les cartes étudiant dans un seul document avec une structure bien formée.
    """
    # Enregistrement du namespace pour la carte étudiante
    ET.register_namespace('', 'http://studentcard.org')

    # Parsing du fichier d'entrée
    tree = ET.parse(input_file)
    root = tree.getroot()

    # Namespace pour les éléments de la carte
    ns_card = 'http://studentcard.org'

    # Création de l'élément racine pour toutes les cartes
    cards_root = ET.Element('cards')

    for student in root.findall('Student'):
        # Extraction des données étudiantes
        code_apogee = student.find('CodeApogee').text
        nom = student.find('Nom').text
        prenom = student.find('Prenom').text
        date_naissance = student.find('DateNaissance').text

        # Calcul de l'année d'inscription
        annee_inscription = int(date_naissance.split('-')[0]) + 18

        # Création de l'élément <card>
        card = ET.SubElement(cards_root, f'{{{ns_card}}}card')

        # Ajout des éléments fixes de la carte
        ET.SubElement(card, f'{{{ns_card}}}logoUae', uri='../../images/logoUae.png')
        ET.SubElement(card, f'{{{ns_card}}}nameUae').text = 'Université Abdelmalek Essaâdi'
        ET.SubElement(card, f'{{{ns_card}}}nameSchool').text = 'Ecole Nationale des Sciences Appliquées'
        ET.SubElement(card, f'{{{ns_card}}}villeSchool').text = 'Tanger'
        ET.SubElement(card, f'{{{ns_card}}}logoEnsa', uri='../../images/ensat.png')
        ET.SubElement(card, f'{{{ns_card}}}title').text = "CARTE D'ÉTUDIANT"

        # Ajout des éléments variables
        ET.SubElement(card, f'{{{ns_card}}}lastName').text = nom
        ET.SubElement(card, f'{{{ns_card}}}firstName').text = prenom
        ET.SubElement(card, f'{{{ns_card}}}codeApoge').text = code_apogee
        ET.SubElement(card, f'{{{ns_card}}}photo', uri='../../images/photoEtudiante.jpg')
        ET.SubElement(card, f'{{{ns_card}}}scanBar', uri='../../images/scanbar.png')
        ET.SubElement(card, f'{{{ns_card}}}footer').text = f'Première Inscription : {annee_inscription}'

    # Indente l'arborescence XML pour une meilleure lisibilité
    indent(cards_root)

    # Écriture du fichier XML de sortie
    cards_tree = ET.ElementTree(cards_root)
    cards_tree.write(output_file, encoding='utf-8', xml_declaration=True)
    print(f"Fichier XML généré : {output_file}")
