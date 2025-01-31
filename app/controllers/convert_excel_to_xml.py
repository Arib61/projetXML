import pandas as pd
from lxml import etree


def ensure_directory(directory_path):
    """
    Vérifie si un dossier existe, sinon le crée.
    """
    import os
    if not os.path.exists(directory_path):
        os.makedirs(directory_path)


def convert_modules_to_xml(input_file, output_file):
    """
    Convertit un fichier Excel contenant des modules en fichier XML avec une structure lisible.
    """
    # Charger le fichier Excel
    data = pd.read_excel(input_file)

    # Initialiser l'élément racine
    root = etree.Element("Modules")

    for _, row in data.iterrows():
        # Ajouter un élément <Module>
        module = etree.SubElement(root, "Module")
        etree.SubElement(module, "ModuleID").text = str(row["ModuleID"])
        etree.SubElement(module, "ModuleName").text = str(row["ModuleName"])
        etree.SubElement(module, "ElementName1").text = str(row["ElementName1"])
        etree.SubElement(module, "ElementName2").text = str(row["ElementName2"])
        etree.SubElement(module, "Dept_Attachement").text = str(row["Dept_Attachement"])

    # Sauvegarder le fichier XML avec indentation
    tree = etree.ElementTree(root)
    with open(output_file, "wb") as f:
        tree.write(f, pretty_print=True, xml_declaration=True, encoding="utf-8")

    print(f"Fichier XML des modules généré avec structure lisible : {output_file}")


def convert_students_to_xml(input_file, output_file):
    """
    Convertit un fichier Excel contenant des étudiants en fichier XML avec une structure lisible.
    """
    # Charger le fichier Excel
    data = pd.read_excel(input_file)

    # Initialiser l'élément racine
    root = etree.Element("Students")

    for _, row in data.iterrows():
        # Ajouter un élément <Student>
        student = etree.SubElement(root, "Student")
        etree.SubElement(student, "CodeApogee").text = str(row["code_apogée"])
        etree.SubElement(student, "CIN").text = str(row["CIN"])
        etree.SubElement(student, "CNE").text = str(row["CNE"])
        etree.SubElement(student, "Nom").text = str(row["Nom"])
        etree.SubElement(student, "Prenom").text = str(row["Prénom"])
        etree.SubElement(student, "LieuNaissance").text = str(row["Lieu_Naissance"])
        etree.SubElement(student, "DateNaissance").text = str(row["Date_Naissance"])

    # Sauvegarder le fichier XML avec indentation
    tree = etree.ElementTree(root)
    with open(output_file, "wb") as f:
        tree.write(f, pretty_print=True, xml_declaration=True, encoding="utf-8")

    print(f"Fichier XML des étudiants généré avec structure lisible : {output_file}")


def convert_notes_to_xml(input_file, output_file):
    """
    Convertit les notes en XML avec tri des étudiants par ordre alphabétique du nom.
    """
    # Charger le fichier Excel
    data = pd.read_excel(input_file)

    # Trier les étudiants par NOM avant la génération du XML
    data_sorted = data.sort_values(by=["Nom", "Prenom"], key=lambda col: col.str.lower())

    # Grouper par étudiant (après le tri)
    grouped = data_sorted.groupby("CodeApogee")

    # Stocker temporairement les étudiants dans une liste pour trier correctement
    students_list = []

    for code_apogee, group in grouped:
        student_data = {
            "CodeApogee": str(code_apogee),
            "Nom": group["Nom"].iloc[0],
            "Prenom": group["Prenom"].iloc[0],
            "DateNaissance": group["DateNaissance"].iloc[0],
            "Modules": []
        }

        module_grouped = group.groupby("Module")

        for module_name, module_group in module_grouped:
            module_data = {"Name": module_name, "SubModules": [], "NoteFinale": None}

            for _, row in module_group.iterrows():
                note = round(float(row["Note"]), 2)  # Limiter à 2 décimales

                if row["SousModule"] != "Note Finale":
                    module_data["SubModules"].append({
                        "Name": row["SousModule"],
                        "Note": f"{note:.2f}"
                    })
                else:
                    module_data["NoteFinale"] = f"{note:.2f}"

            student_data["Modules"].append(module_data)

        students_list.append(student_data)

    # **Trier la liste finale des étudiants par ordre alphabétique (Nom + Prénom)**
    students_list.sort(key=lambda s: (s["Nom"].lower(), s["Prenom"].lower()))

    # Générer le fichier XML après le tri
    root = etree.Element("Students")

    for student in students_list:
        student_elem = etree.SubElement(root, "Student")
        etree.SubElement(student_elem, "CodeApogee").text = student["CodeApogee"]
        etree.SubElement(student_elem, "Nom").text = student["Nom"]
        etree.SubElement(student_elem, "Prenom").text = student["Prenom"]
        etree.SubElement(student_elem, "DateNaissance").text = student["DateNaissance"]

        modules_elem = etree.SubElement(student_elem, "Modules")
        for module in student["Modules"]:
            module_elem = etree.SubElement(modules_elem, "Module")
            etree.SubElement(module_elem, "Name").text = module["Name"]

            submodules_elem = etree.SubElement(module_elem, "SubModules")
            for submodule in module["SubModules"]:
                submodule_elem = etree.SubElement(submodules_elem, "SubModule")
                etree.SubElement(submodule_elem, "Name").text = submodule["Name"]
                etree.SubElement(submodule_elem, "Note").text = submodule["Note"]

            if module["NoteFinale"]:
                etree.SubElement(module_elem, "NoteFinale").text = module["NoteFinale"]

    # Sauvegarder le fichier XML
    tree = etree.ElementTree(root)
    with open(output_file, "wb") as f:
        tree.write(f, pretty_print=True, xml_declaration=True, encoding="utf-8")

    print(f"✅ Fichier XML généré avec tri alphabétique par nom : {output_file}")
