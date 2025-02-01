<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
        <style>
          @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&amp;display=swap');

          * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
          }

          body {
            font-family: 'Inter', sans-serif;
            line-height: 1.6;
            color: #1a1a1a;
            background-color: #f8f9fa;
            padding: 2rem;
          }

          .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 2rem;
          }

          h1 {
            font-size: 2.25rem;
            font-weight: 600;
            color: #2d3748;
            text-align: center;
            margin-bottom: 2rem;
            letter-spacing: -0.025em;
          }

          table {
            border-collapse: separate;
            border-spacing: 0;
            width: 100%;
            margin: 0 auto;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07);
          }

          th, td {
            padding: 1rem;
            text-align: center;
            border: 1px solid #e2e8f0;
          }

          th {
            background-color: #2d3748;
            color: white;
            font-weight: 500;
            text-transform: uppercase;
            font-size: 0.875rem;
            letter-spacing: 0.05em;
          }

          td:first-child {
            background-color: #f7fafc;
            font-weight: 500;
            color: #2d3748;
          }

          .matiere-cell {
            padding: 0.75rem;
            margin-bottom: 0.5rem;
            border-radius: 6px;
            font-size: 0.875rem;
            font-weight: 500;
            transition: transform 0.2s;
          }

          .matiere-cell:hover {
            transform: translateY(-2px);
          }

          .matiere-cell:last-child {
            margin-bottom: 0;
          }

          .cm {
            background-color: #4299e1;
            color: white;
            box-shadow: 0 2px 4px rgba(66, 153, 225, 0.3);
          }

          .tp {
            background-color: #48bb78;
            color: white;
            box-shadow: 0 2px 4px rgba(72, 187, 120, 0.3);
          }

          .td {
            background-color: #f56565;
            color: white;
            box-shadow: 0 2px 4px rgba(245, 101, 101, 0.3);
          }

          .legend {
            text-align: center;
            margin-top: 2rem;
            padding: 1rem;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.07);
          }

          .legend-title {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 1rem;
            font-size: 1.125rem;
          }

          .legend-items {
            display: flex;
            justify-content: center;
            gap: 1rem;
            flex-wrap: wrap;
          }

          .legend-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
          }

          .legend-color {
            width: 2rem;
            height: 2rem;
            border-radius: 4px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 500;
            font-size: 0.875rem;
          }

          @media (max-width: 768px) {
            body {
              padding: 1rem;
            }

            .container {
              padding: 1rem;
            }

            table {
              font-size: 0.875rem;
            }

            th, td {
              padding: 0.75rem 0.5rem;
            }

            .legend-items {
              flex-direction: column;
              align-items: center;
            }
          }
        </style>
      </head>
      <body>
        <div class="container">
          <h1>Emploi du temps GINF2</h1>
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
          <div class="legend">
            <div class="legend-title">Légende</div>
            <div class="legend-items">
              <div class="legend-item">
                <div class="legend-color cm">CM</div>
                <span>Cours Magistral</span>
              </div>
              <div class="legend-item">
                <div class="legend-color tp">TP</div>
                <span>Travaux Pratiques</span>
              </div>
              <div class="legend-item">
                <div class="legend-color td">TD</div>
                <span>Travaux Dirigés</span>
              </div>
            </div>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>