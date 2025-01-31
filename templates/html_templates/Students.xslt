<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <!-- Root template -->
    <xsl:template match="/Students">
        <html>
            <head>
                <title>Liste des Étudiants</title>
                <style>
                    table {
                        width: 90%;
                        border-collapse: collapse;
                        margin: 20px auto;
                        font-family: Arial, sans-serif;
                    }
                    th, td {
                        border: 1px solid #ddd;
                        padding: 8px;
                        text-align: left;
                    }
                    th {
                        background-color: #f4f4f4;
                        font-weight: bold;
                    }
                    tr:nth-child(even) {
                        background-color: #f9f9f9;
                    }
                    tr:hover {
                        background-color: #f1f1f1;
                    }
                    h1 {
                        text-align: center;
                        font-family: Arial, sans-serif;
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
                <h1>Liste des Étudiants</h1>
                <table>
                    <thead>
                        <tr>
                            <th>Code Apogée</th>
                            <th>CIN</th>
                            <th>CNE</th>
                            <th>Nom</th>
                            <th>Prénom</th>
                            <th>Lieu de Naissance</th>
                            <th>Date de Naissance</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Iterate through each Student -->
                        <xsl:for-each select="Student">
                            <tr>
                                <td><xsl:value-of select="CodeApogee" /></td>
                                <td><xsl:value-of select="CIN" /></td>
                                <td><xsl:value-of select="CNE" /></td>
                                <td><xsl:value-of select="Nom" /></td>
                                <td><xsl:value-of select="Prenom" /></td>
                                <td><xsl:value-of select="LieuNaissance" /></td>
                                <td><xsl:value-of select="DateNaissance" /></td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
