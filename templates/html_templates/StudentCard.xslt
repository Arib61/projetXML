<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:b="http://studentcard.org"
    exclude-result-prefixes="b">

    <xsl:output method="html" indent="yes"/>

    <xsl:template match="/b:cards">
        <html>
            <head>
                <title>Student Cards</title>
                <style>
                    .cards-container {
                        display: flex;
                        flex-direction: column;
                        align-items: center;
                        gap: 15px;
                    }
                    .card-container {
                        width: 13cm;
                        height: 6cm;
                        border: 1px solid #ccc;
                        margin: 5px;
                        position: relative;
                        font-family: Arial, sans-serif;
                    }

                    /* Header Section */
                    .header {
                        position: absolute;
                        top: 0.2cm;
                        width: 100%;
                        text-align: center;
                    }

                    .university-info {
                        display: inline-block;
                        margin: 0 auto;
                    }

                    /* Left Panel - Student Photo */
                    .student-photo-container {
                        position: absolute;
                        left: 0.3cm;
                        top: 2.2cm;
                        width: 2.5cm;
                    }

                    /* Right Panel - Student Info */
                    .student-info-container {
                        position: absolute;
                        left: 3.2cm;
                        top: 2.2cm;
                        width: 6.5cm;
                    }

                    /* Barcode Section */
                    .barcode-container {
                        position: absolute;
                        right: 0.3cm;
                        bottom: 0.8cm;
                        width: 2.5cm;
                    }

                    /* Footer */
                    .footer {
                        position: absolute;
                        bottom: 0.2cm;
                        width: 100%;
                        text-align: center;
                        font-size: 0.7em;
                    }

                    /* Typography */
                    .university-name {
                        color: #191970;
                        font-size: 0.65em;
                        line-height: 1.2;
                        margin: 0;
                    }

                    .school-name {
                        color: #191970;
                        font-size: 0.6em;
                        margin: 0;
                    }

                    .city {
                        color: #191970;
                        font-size: 0.6em;
                        margin: 0;
                    }

                    .card-title {
                        color: #191970;
                        font-size: 0.9em;
                        font-weight: bold;
                        margin: 0.3cm 0;
                    }

                    .student-name {
                        font-size: 0.8em;
                        font-weight: bold;
                        margin: 0.15cm 0;
                        letter-spacing: 0.05em;
                    }

                    .code-apogee {
                        font-size: 0.75em;
                        margin: 0.3cm 0 0 0;
                    }

                    /* Images */
                    .student-photo {
                        width: 2.2cm;
                        height: 2.7cm;
                        border: 1px solid #ddd;
                    }

                    .barcode {
                        width: 2.5cm;
                        height: 0.9cm;
                    }

                    .logo {
                        position: absolute;
                        top: 0.2cm;
                        width: 1.2cm;
                    }
                    .logo.left { left: 0.3cm; }
                    .logo.right { right: 0.3cm; }

                    .page-title {
                        text-align: center;
                        font-size: 24px;
                        color: #191970;
                        margin-bottom: 20px;
                        font-weight: bold;
                        text-transform: uppercase;
                    }
                </style>
            </head>
            <body>
                <!-- Page Title -->
                <div class="page-title">Les Cartes d'Étudiants</div>

                <!-- Cards Container -->
                <div class="cards-container">               
                <xsl:for-each select="b:card">
                    <div class="card-container">
                        <!-- University Logos -->
                        <img class="logo left" src="https://projetxml-production.up.railway.app/static/images/logo_uae.png" alt="University Logo"/>
                        <img class="logo right" src="https://projetxml-production.up.railway.app/static/images/logo_ensa.png" alt="ENSA Logo"/>

                        <!-- University Header -->
                        <div class="header">
                            <div class="university-info">
                                <div class="university-name">Université Abdelmalek Essaadi</div>
                                <div class="school-name">Ecole Nationale des Sciences Appliquées</div>
                                <div class="city">Tanger</div>
                            </div>
                        </div>

                        <!-- Student Photo -->
                        <div class="student-photo-container">
                            <img class="student-photo" src="https://projetxml-production.up.railway.app/static/images/photoEtudiante (1).jpg" alt="Student Photo"/>
                        </div>

                        <!-- Student Information -->
                        <div class="student-info-container">
                            <div class="card-title">CARTE D'ÉTUDIANT</div>
                            <div class="student-name"><xsl:value-of select="b:lastName"/></div>
                            <div class="student-name"><xsl:value-of select="b:firstName"/></div>
                            <div class="code-apogee"><xsl:value-of select="b:codeApoge"/></div>
                        </div>

                        <!-- Barcode -->
                        <div class="barcode-container">
                            <img class="barcode" src="https://projetxml-production.up.railway.app/static/images/scanbar.png" alt="Barcode"/>
                        </div>

                        <!-- Footer -->
                        <div class="footer">
                            <xsl:value-of select="b:footer"/>
                        </div>
                    </div>
                </xsl:for-each>
             </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
