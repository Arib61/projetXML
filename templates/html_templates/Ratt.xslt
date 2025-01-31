<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" indent="yes"/>
  
  <!-- Define a key to group students by module where NoteFinale < 12 -->
  <xsl:key name="modules" match="Module[NoteFinale &lt; 12]" use="Name"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Liste des rattrapages</title>
        <style>
          table {
            width: 60%;
            border-collapse: collapse;
            margin-bottom: 20px;
          }
          th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
          }
          th {
            background-color: #f2f2f2;
            font-weight: bold;
          }
          tr:nth-child(even) {
            background-color: #f9f9f9;
          }
          tr:nth-child(odd) {
            background-color: #ffffff;
          }
          h2 {
            color: #333;
          }
          .low { color: red; }
          .medium { color: orange; }
          .high { color: green; }
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
        <!-- Loop through each module and display students needing a retake -->
        <xsl:for-each select="Students/Student/Modules/Module[generate-id() = generate-id(key('modules', Name)[1])]">
          <h2>Liste de rattrapage: <xsl:value-of select="Name"/></h2>
          <table>
            <thead>
              <tr>
                <th>Code Apogée</th>
                <th>Nom</th>
                <th>Prénom</th>
                <th>Note Finale</th>
              </tr>
            </thead>
            <tbody>
              <!-- For each student in the module who needs a retake (NoteFinale < 12) -->
              <xsl:for-each select="key('modules', Name)">
                <!-- Sort by Nom and Prenom -->
                <xsl:sort select="../../Nom" order="ascending"/>
                <xsl:sort select="../../Prenom" order="ascending"/>
                <tr>
                  <td><xsl:value-of select="../../CodeApogee"/></td>
                  <td><xsl:value-of select="../../Nom"/></td>
                  <td><xsl:value-of select="../../Prenom"/></td>
                  <!-- Apply conditional style to Note Finale -->
                  <td>
                    <xsl:attribute name="class">
                      <xsl:choose>
                        <xsl:when test="NoteFinale &lt; 8">low</xsl:when>
                        <xsl:when test="NoteFinale &gt;= 8 and NoteFinale &lt; 12">medium</xsl:when>
                        <xsl:otherwise>high</xsl:otherwise>
                      </xsl:choose>
                    </xsl:attribute>
                    <xsl:value-of select="NoteFinale"/>
                  </td>
                </tr>
              </xsl:for-each>
            </tbody>
          </table>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
