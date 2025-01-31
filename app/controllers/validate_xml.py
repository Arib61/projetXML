import lxml.etree as ET

def validate_with_dtd(xml_file, dtd_file):
    try:
        with open(dtd_file, 'r') as dtd:
            dtd = ET.DTD(dtd)
        with open(xml_file, 'r') as xml:
            xml_doc = ET.parse(xml)
        is_valid = dtd.validate(xml_doc)
        if is_valid:
            print(f"{xml_file} is valid against {dtd_file}")
        else:
            print(f"{xml_file} is NOT valid against {dtd_file}: {dtd.error_log.filter_from_errors()}")
    except Exception as e:
        print(f"Error validating {xml_file} against {dtd_file}: {e}")

def validate_with_xsd(xml_file, xsd_file):
    try:
        with open(xsd_file, 'rb') as xsd:  # Ouvrir le fichier XSD en mode binaire
            schema_root = ET.XML(xsd.read())
            schema = ET.XMLSchema(schema_root)

        with open(xml_file, 'rb') as xml:  # Ouvrir le fichier XML en mode binaire
            xml_doc = ET.parse(xml)
        schema.assertValid(xml_doc)
        print(f"{xml_file} is valid against {xsd_file}")
    except ET.DocumentInvalid as e:
        print(f"{xml_file} is NOT valid against {xsd_file}: {e}")
    except Exception as e:
        print(f"Error validating {xml_file} against {xsd_file}: {e}")

# Fichiers à valider
files_to_validate = [
    {"xml": "data_generated/students/Students_GINF2.xml", "dtd": "schemas/Students.dtd", "xsd": "schemas/Students.xsd"},
    {"xml": "data_generated/modules/Modules_GINF2.xml", "dtd": "schemas/Modules.dtd", "xsd": "schemas/Modules.xsd"},
    {"xml": "data_generated/notes/Notes_GINF2.xml", "dtd": "schemas/Notes.dtd", "xsd": "schemas/Notes.xsd"},
]

for file in files_to_validate:
    print(f"Validating {file['xml']}...")
    validate_with_dtd(file["xml"], file["dtd"])
    validate_with_xsd(file["xml"], file["xsd"])

# Nouvelle fonction de validation pour les noms
def check_alphanumeric(value):
    if not value.isalpha():
        raise ValueError(f"Value '{value}' contains non-alphanumeric characters.")

# Exemple d'utilisation
def validate_students_constraints(xml_file):
    try:
        # Parse le fichier XML
        tree = ET.parse(xml_file)
        root = tree.getroot()

        # Vérifie chaque étudiant
        for student in root.findall(".//Student"):
            first_name = student.find("FirstName")
            last_name = student.find("LastName")

            # Vérification si les éléments sont présents et non vides
            if first_name is None or first_name.text is None or first_name.text.strip() == "":
                raise ValueError(f"FirstName is missing or empty in {xml_file}")
            if last_name is None or last_name.text is None or last_name.text.strip() == "":
                raise ValueError(f"LastName is missing or empty in {xml_file}")

            # Vérification des caractères alphanumériques
            check_alphanumeric(first_name.text)
            check_alphanumeric(last_name.text)

        print(f"{xml_file} passed additional students constraints validation.")
    except ValueError as e:
        print(f"{xml_file} failed additional students constraints validation: {e}")
    except Exception as e:
        print(f"Error during additional constraints validation of {xml_file}: {e}")

def validate_notes_constraints(xml_file):
    try:
        # Parse le fichier XML
        tree = ET.parse(xml_file)
        root = tree.getroot()

        # Vérifie chaque note
        for student in root.findall(".//Student"):
            for module in student.findall(".//Module"):
                note_finale = module.find("NoteFinale")
                if note_finale is None or note_finale.text is None or note_finale.text.strip() == "":
                    raise ValueError(f"NoteFinale is missing or empty in {xml_file}")

                # Vérifie si la note finale est dans la plage
                note_value = float(note_finale.text)
                if note_value < 0 or note_value > 20:
                    raise ValueError(f"NoteFinale '{note_value}' is out of range (0-20) in {xml_file}")

                for submodule in module.findall(".//SubModule"):
                    note = submodule.find("Note")
                    if note is None or note.text is None or note.text.strip() == "":
                        raise ValueError(f"Note is missing or empty in {xml_file}")

                    # Vérifie si la note est dans la plage
                    note_value = float(note.text)
                    if note_value < 0 or note_value > 20:
                        raise ValueError(f"Note '{note_value}' is out of range (0-20) in {xml_file}")

        print(f"{xml_file} passed additional notes constraints validation.")
    except ValueError as e:
        print(f"{xml_file} failed additional notes constraints validation: {e}")
    except Exception as e:
        print(f"Error during additional notes constraints validation of {xml_file}: {e}")
