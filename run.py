from app import create_app
from app.controllers.validate_xml import validate_with_dtd, validate_with_xsd, validate_students_constraints, validate_notes_constraints


app = create_app()

def validate_files():
    files_to_validate = [
        {"xml": "data_generated/students/Students_GINF2.xml", "dtd": "schemas/Students.dtd", "xsd": "schemas/Students.xsd"},
        {"xml": "data_generated/modules/Modules_GINF2.xml", "dtd": "schemas/Modules.dtd", "xsd": "schemas/Modules.xsd"},
        {"xml": "data_generated/notes/Notes_GINF2.xml", "dtd": "schemas/Notes.dtd", "xsd": "schemas/Notes.xsd"},
    ]

    for file in files_to_validate:
        print(f"Validating {file['xml']}...")
        validate_with_dtd(file["xml"], file["dtd"])
        validate_with_xsd(file["xml"], file["xsd"])
        validate_students_constraints(file["xml"])
        validate_notes_constraints(file["xml"])



if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1 and sys.argv[1] == "validate":
        validate_files()
    else:
        app.run(host="0.0.0.0", port=5000, debug=True)

