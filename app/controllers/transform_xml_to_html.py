from lxml import etree
import os

def transform_xml_to_html(xml_file, xslt_file, output_file):
    try:
        if not os.path.exists(xml_file):
            print(f"❌ Erreur : Le fichier XML source est introuvable : {xml_file}")
            return False

        if not os.path.exists(xslt_file):
            print(f"❌ Erreur : Le fichier XSLT est introuvable : {xslt_file}")
            return False

        print(f"📌 Chargement du fichier XML : {xml_file}")
        xml_tree = etree.parse(xml_file)

        print(f"📌 Chargement du fichier XSLT : {xslt_file}")
        xslt_tree = etree.parse(xslt_file)
        transform = etree.XSLT(xslt_tree)

        print("📌 Application de la transformation XSLT...")
        result_tree = transform(xml_tree)

        if result_tree is None:
            print("❌ Erreur : La transformation XSLT a retourné None.")
            return False

        print("📌 Contenu du fichier HTML généré :")
        print(str(result_tree))

        print("📌 Sauvegarde du fichier HTML généré...")
        os.makedirs(os.path.dirname(output_file), exist_ok=True)
        with open(output_file, "wb") as f:
            f.write(etree.tostring(result_tree, pretty_print=True, method="html"))

        print(f"✅ HTML généré avec succès : {output_file}")
        return True

    except etree.XMLSyntaxError as e:
        print(f"❌ Erreur de syntaxe XML : {e}")
    except etree.XSLTParseError as e:
        print(f"❌ Erreur de parsing XSLT : {e}")
    except etree.XSLTApplyError as e:
        print(f"❌ Erreur lors de l'application XSLT : {e}")
    except Exception as e:
        print(f"❌ Erreur inattendue : {e}")

    return False
