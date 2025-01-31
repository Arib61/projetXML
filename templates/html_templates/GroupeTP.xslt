<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" indent="yes"/>
  
  <xsl:template match="/TPGroups">
    <html>
      <head>
        <title>Groupes TP et Étudiants</title>
        <style>
          table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
          }
          th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: left;
          }
          th {
            background-color: #f2f2f2;
            font-weight: bold;
            text-align: center;
          }
          .group-header {
            background-color: #d3d3d3;
            font-weight: bold;
            text-align: center;
            vertical-align: middle;
          }
          .student-list {
            padding-left: 10px;
          }
          .student-list div {
            border-bottom: 1px solid #ccc;
            padding: 5px 0;
          }
          .student-list div:last-child {
            border-bottom: none;
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

        <h1>Groupes TP et Étudiants</h1>
        <table>
          <thead>
            <tr>
              <th>Groupe TP</th>
              <th>Les étudiants</th>
            </tr>
          </thead>
          <tbody>
            <!-- Boucle à travers chaque groupe -->
            <xsl:for-each select="Group">
              <tr>
                <!-- Colonne de gauche avec le nom du groupe -->
                <td class="group-header" rowspan="{count(Student)}">
                  GROUPE <xsl:value-of select="@id"/>
                </td>
                <!-- Première ligne avec le premier étudiant -->
                <td class="student-list">
                  <div><xsl:value-of select="Student[1]/Nom"/> <xsl:value-of select="Student[1]/Prenom"/></div>
                </td>
              </tr>
              <!-- Autres étudiants du groupe (ajoutés en nouvelles lignes) -->
              <xsl:for-each select="Student[position() > 1]">
                <tr>
                  <td class="student-list">
                    <div><xsl:value-of select="Nom"/> <xsl:value-of select="Prenom"/></div>
                  </td>
                </tr>
              </xsl:for-each>
            </xsl:for-each>
          </tbody>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
