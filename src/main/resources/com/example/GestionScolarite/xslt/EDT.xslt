<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <style>
          table {
            border-collapse: collapse;
            width: 100%;
            margin: 20px auto;
          }
          th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
          }
          th {
            background-color: #f2f2f2;
          }
          .matiere-cell {
            padding: 6px;
            margin-bottom: 4px;
            border-radius: 4px;
          }
          .cm { background-color: #3498db; color: white; }
          .tp { background-color: #27ae60; color: white; }
          .td { background-color: #e74c3c; color: white; }
        </style>
      </head>
      <body>
        <h1 style="text-align: center;">Emploi du temps GINF2</h1>
        <table>
          <thead>
            <tr>
              <th>Horaire</th>
              <xsl:for-each select="/emploi/Days/day">
                <th><xsl:value-of select="@name"/></th>
              </xsl:for-each>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="/emploi/times/time">
              <xsl:variable name="currentTime" select="@t"/>
              <tr>
                <td><xsl:value-of select="$currentTime"/></td>
                <xsl:for-each select="/emploi/Days/day">
                  <xsl:variable name="currentDay" select="@name"/>
                  <td>
                    <xsl:for-each select="/emploi/matieres/matiere[jour=$currentDay and startTime=$currentTime]">
                      <div class="matiere-cell {translate(substring-before(type,' '),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')}">
                        <xsl:value-of select="concat(nom, ' - ', nomProf, ' - ', salle)"/>
                      </div>
                    </xsl:for-each>
                  </td>
                </xsl:for-each>
              </tr>
            </xsl:for-each>
          </tbody>
        </table>
        <div style="text-align: center; margin-top: 20px;">
          <p><strong>Légende:</strong></p>
          <span class="matiere-cell cm">CM</span>
          <span class="matiere-cell tp">TP</span>
          <span class="matiere-cell td">TD</span>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>