<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml">

    <xsl:output method="html" doctype-system="about:legacy-compat" indent="yes"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Student Transcript</title>
                <style>
                    body { 
                        margin: 1cm;
                        font-family: Arial, sans-serif;
                    }
                    .header {
                        margin-bottom: 3cm;
                    }
                    .student-section {
                        margin-bottom: 2cm;
                    }
                    .module-table {
                        width: 100%;
                        border-collapse: collapse;
                        margin-top: 20px;
                    }
                    .module-table td, .module-table th {
                        padding: 8px;
                        border: 1px solid #ddd;
                    }
                    .module-header {
                        background-color: lightblue;
                    }
                    .final-grade {
                        background-color: lightgray;
                    }
                    .page-break {
                        page-break-after: always;
                    }
                </style>
            </head>
            <body>
                <!-- Header Section -->
                <div class="header" style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 3cm;">
                    <!-- Left Logo -->
                    <div style="flex: 1; text-align: center;">
                        <img src="http://127.0.0.1:5000/static/images/logo_uae.png" style="height: 2cm;" alt="Logo UAE"/>
                    </div>

                    <!-- Center Text -->
                    <div style="flex: 2; text-align: center; font-size: 12pt; font-weight: bold;">
                        Université Abdelmalek Essaâdi<br/>
                        Ecole Nationale des Sciences Appliquées<br/>
                        Tanger
                    </div>

                    <!-- Right Logo -->
                    <div style="flex: 1; text-align: center;">
                        <img src="http://127.0.0.1:5000/static/images/logo_ensa.png" style="height: 2cm;" alt="Logo ENSAT"/>
                    </div>
                </div>

                <!-- Student Sections -->
                <xsl:for-each select="/Students/Student">
                    <div class="student-section">
                        <h1 style="text-align: center; margin-bottom: 10pt;">RELEVÉ DE NOTES ET RÉSULTATS</h1>
                        
                        <p style="font-size: 12pt;">
                            <strong>Nom et Prénom :</strong> 
                            <xsl:value-of select="Nom"/> <xsl:value-of select="Prenom"/>
                        </p>
                        <p style="font-size: 12pt;">
                            <strong>Code Apogée :</strong> 
                            <xsl:value-of select="CodeApogee"/>
                        </p>

                        <!-- Modules Table -->
                        <table class="module-table">
                            <xsl:for-each select="Modules/Module">
                                <tr class="module-header">
                                    <td colspan="2">
                                        <strong><xsl:value-of select="Name"/></strong>
                                    </td>
                                </tr>
                                
                                <xsl:for-each select="SubModules/SubModule">
                                    <tr>
                                        <td style="padding-left: 1cm;">
                                            <xsl:value-of select="Name"/>
                                        </td>
                                        <td style="text-align: right;">
                                            <xsl:value-of select="Note"/> / 20
                                        </td>
                                    </tr>
                                </xsl:for-each>
                                
                                <tr class="final-grade">
                                    <td style="text-align: right; font-weight: bold;">Note Finale :</td>
                                    <td style="text-align: right; font-weight: bold;">
                                        <xsl:value-of select="NoteFinale"/> / 20
                                    </td>
                                </tr>
                            </xsl:for-each>
                        <!--moyenne-->
                        <tr class="average-grade">
                                <td style="text-align: right; font-weight: bold;">Moyenne Générale :</td>
                                <td style="text-align: right; font-weight: bold;">
                                    <xsl:value-of select="format-number(sum(Modules/Module/NoteFinale) div count(Modules/Module/NoteFinale), '0.00')"/> / 20
                                </td>
                        </tr>
                        </table>

                        <!-- Page break for printing -->
                        <xsl:if test="position() != last()">
                            <hr class="page-break"/>
                        </xsl:if>
                    </div>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>