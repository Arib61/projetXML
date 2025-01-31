<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <!-- Template match for the root element -->
    <xsl:template match="/Modules">
        <html>
            <head>
                <title>Liste des Modules</title>
                <style>
                    table {
                        width: 80%;
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
                        <img src="https://projetxml-production.up.railway.app/static/images/logo_uae.png" style="height: 2cm;" alt="Logo UAE"/>
                    </div>

                    <!-- Center Text -->
                    <div style="flex: 2; text-align: center; font-size: 12pt; font-weight: bold;">
                        Université Abdelmalek Essaâdi<br/>
                        Ecole Nationale des Sciences Appliquées<br/>
                        Tanger
                    </div>

                    <!-- Right Logo -->
                    <div style="flex: 1; text-align: center;">
                        <img src="https://projetxml-production.up.railway.app/static/images/logo_ensa.png" style="height: 2cm;" alt="Logo ENSAT"/>
                    </div>
                </div>
                <h1>Liste des Modules</h1>
                <table>
                    <thead>
                        <tr>
                            <th>Module ID</th>
                            <th>Nom du Module</th>
                            <th>Élément 1</th>
                            <th>Élément 2</th>
                            <th>Département d'Attachement</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Loop through each Module -->
                        <xsl:for-each select="Module">
                            <tr>
                                <td><xsl:value-of select="ModuleID" /></td>
                                <td><xsl:value-of select="ModuleName" /></td>
                                <td><xsl:value-of select="ElementName1" /></td>
                                <td><xsl:value-of select="ElementName2" /></td>
                                <td><xsl:value-of select="Dept_Attachement" /></td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
