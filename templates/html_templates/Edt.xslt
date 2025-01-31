<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" />
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Emploi du Temps</title>
                <style>
                    h2 { text-align: center; color: black; }
                    table { border-collapse: collapse; width: 100%; }
                    th, td { border: 1px solid black; padding: 0; text-align: center; vertical-align: top; }
                    th { background-color: lightgray; }
                    .course-box { display: flex; flex-direction: column; border: 1px solid black; width: 100%; height: 100px; }
                    .course-header { background-color: #D397F8; padding: 5px; font-size: 12px; font-weight: bold; text-align: center; border-bottom: 1px solid black; }
                    .tp .course-header { background-color: #90EE90; }
                    .td .course-header { background-color: #90EE90; } <!-- Adjust color as needed -->
                    .course-content { background-color: white; padding: 10px; text-align: center; flex-grow: 1; display: flex; align-items: center; justify-content: center; }
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
                
                <h2>Emploi du Temps</h2>
                <table>
                    <tr>
                        <th>Heure</th>
                        <th>Lundi</th>
                        <th>Mardi</th>
                        <th>Mercredi</th>
                        <th>Jeudi</th>
                        <th>Vendredi</th>
                        <th>Samedi</th>
                    </tr>
                    <!-- Process each time slot -->
                    <xsl:call-template name="time-slot">
                        <xsl:with-param name="start">09:00</xsl:with-param>
                        <xsl:with-param name="end">10:30</xsl:with-param>
                    </xsl:call-template>
                    <xsl:call-template name="time-slot">
                        <xsl:with-param name="start">10:30</xsl:with-param>
                        <xsl:with-param name="end">11:00</xsl:with-param>
                    </xsl:call-template>
                    <xsl:call-template name="time-slot">
                        <xsl:with-param name="start">11:00</xsl:with-param>
                        <xsl:with-param name="end">12:30</xsl:with-param>
                    </xsl:call-template>
                    <xsl:call-template name="time-slot">
                        <xsl:with-param name="start">12:30</xsl:with-param>
                        <xsl:with-param name="end">13:30</xsl:with-param>
                    </xsl:call-template>
                    <xsl:call-template name="time-slot">
                        <xsl:with-param name="start">13:30</xsl:with-param>
                        <xsl:with-param name="end">15:00</xsl:with-param>
                    </xsl:call-template>
                    <xsl:call-template name="time-slot">
                        <xsl:with-param name="start">15:00</xsl:with-param>
                        <xsl:with-param name="end">15:30</xsl:with-param>
                    </xsl:call-template>
                    <xsl:call-template name="time-slot">
                        <xsl:with-param name="start">15:30</xsl:with-param>
                        <xsl:with-param name="end">17:00</xsl:with-param>
                    </xsl:call-template>
                    <xsl:call-template name="time-slot">
                        <xsl:with-param name="start">17:00</xsl:with-param>
                        <xsl:with-param name="end">18:30</xsl:with-param>
                    </xsl:call-template>
                </table>
            </body>
        </html>
    </xsl:template>

    <!-- Template to process each time slot -->
    <xsl:template name="time-slot">
        <xsl:param name="start"/>
        <xsl:param name="end"/>
        <tr>
            <td><xsl:value-of select="$start"/> - <xsl:value-of select="$end"/></td>
            <!-- Check each day for matching sessions -->
            <td><xsl:apply-templates select="/Emlpoi/semaine/lundi/séance[translate(@debut, 'h', ':') = $start and translate(@fin, 'h', ':') = $end]"/></td>
            <td><xsl:apply-templates select="/Emlpoi/semaine/mardi/séance[translate(@debut, 'h', ':') = $start and translate(@fin, 'h', ':') = $end]"/></td>
            <td><xsl:apply-templates select="/Emlpoi/semaine/mercredi/séance[translate(@debut, 'h', ':') = $start and translate(@fin, 'h', ':') = $end]"/></td>
            <td><xsl:apply-templates select="/Emlpoi/semaine/jeudi/séance[translate(@debut, 'h', ':') = $start and translate(@fin, 'h', ':') = $end]"/></td>
            <td><xsl:apply-templates select="/Emlpoi/semaine/vendredi/séance[translate(@debut, 'h', ':') = $start and translate(@fin, 'h', ':') = $end]"/></td>
            <td><xsl:apply-templates select="/Emlpoi/semaine/samedi/séance[translate(@debut, 'h', ':') = $start and translate(@fin, 'h', ':') = $end]"/></td>
        </tr>
    </xsl:template>

    <!-- Template to render a session -->
    <xsl:template match="séance">
        <div class="course-box">
            <xsl:attribute name="class">
                <xsl:text>course-box </xsl:text>
                <xsl:value-of select="translate(@type, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
            </xsl:attribute>
            <div class="course-header">
                <xsl:value-of select="@type"/> - <xsl:value-of select="@debut"/> - <xsl:value-of select="@fin"/>
            </div>
            <div class="course-content">
                <xsl:value-of select="module"/><br/>
                <xsl:value-of select="Professeur"/><br/>
                <xsl:value-of select="salle"/>
            </div>
        </div>
    </xsl:template>
</xsl:stylesheet>