<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    exclude-result-prefixes="fo">

  <xsl:param name="cne"/>

  <xsl:template match="/">
    <fo:root>
      <fo:layout-master-set>
        <!-- Increase page-height a bit to avoid automatic page break -->
        <fo:simple-page-master master-name="card"
            page-height="9cm"
            page-width="13.5cm"
            margin="0.5cm">
          <fo:region-body margin="0cm"/>
        </fo:simple-page-master>
      </fo:layout-master-set>

      <fo:page-sequence master-reference="card">
        <fo:flow flow-name="xsl-region-body">
          <!-- keep-together so all card content stays on one page -->
          <fo:block keep-together="always">

            <!-- Header with logos -->
            <fo:table width="100%" table-layout="fixed" margin-bottom="0.2cm">
              <fo:table-column column-width="2.5cm"/>
              <fo:table-column column-width="7.5cm"/>
              <fo:table-column column-width="2.5cm"/>
              <fo:table-body>
                <fo:table-row>
                  <!-- ENSA Logo -->
                  <fo:table-cell display-align="center">
                    <fo:block>
                      <fo:external-graphic
                        src="url('src/main/resources/com/example/gestionscolarite/images/ensa_tanger.png')"
                        content-width="2cm"
                        content-height="2cm"
                        scaling="uniform"/>
                    </fo:block>
                  </fo:table-cell>

                  <!-- Title Text -->
                  <fo:table-cell display-align="center">
                    <fo:block text-align="center" font-size="8pt" line-height="1.2em">
                      <fo:block font-weight="bold">ROYAUME DU MAROC</fo:block>
                      <fo:block>UNIVERSITÉ ABDELMALEK ESSAÂDI</fo:block>
                      <fo:block>ÉCOLE NATIONALE DES SCIENCES</fo:block>
                      <fo:block>APPLIQUÉES DE TANGER</fo:block>
                    </fo:block>
                  </fo:table-cell>

                  <!-- UAE Logo -->
                  <fo:table-cell display-align="center">
                    <fo:block>
                      <fo:external-graphic
                        src="url('src/main/resources/com/example/gestionscolarite/images/logoUAE.png')"
                        content-width="2cm"
                        content-height="2cm"
                        scaling="uniform"/>
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
              </fo:table-body>
            </fo:table>

            <!-- Blue Separator -->
            <fo:block border-bottom="1pt solid #031599"/>

            <!-- Card Title -->
            <fo:block text-align="center"
                      font-weight="bold"
                      font-size="12pt"
                      color="#031599"
                      margin-top="0.2cm"
                      margin-bottom="0.3cm">
              Carte d'Étudiant
            </fo:block>

            <!-- Student Info Table -->
            <fo:table width="100%" table-layout="fixed">
              <fo:table-column column-width="3.5cm"/>
              <fo:table-column column-width="5.5cm"/>
              <fo:table-column column-width="3.5cm"/>
              <fo:table-body>
                <fo:table-row>
                  <!-- Photo -->
                  <fo:table-cell padding="0.2cm">
                    <fo:block>
                      <fo:external-graphic
                        src="url('src/main/resources/com/example/gestionscolarite/images/Unknown_person.jpg')"
                        content-width="2.8cm"
                        content-height="3.0cm"
                        scaling="uniform"/>
                    </fo:block>
                  </fo:table-cell>

                  <!-- Student Details -->
                  <fo:table-cell padding="0.2cm">
                    <fo:block font-size="10pt" line-height="1.5em">
                      <fo:block space-after="0.2cm">
                        Prénom:
                        <fo:inline font-weight="bold">
                          <xsl:value-of select="/Etudiants/Etudiant[@CNE=$cne]/firstName"/>
                        </fo:inline>
                      </fo:block>
                      <fo:block space-after="0.2cm">
                        Nom:
                        <fo:inline font-weight="bold">
                          <xsl:value-of select="/Etudiants/Etudiant[@CNE=$cne]/lastName"/>
                        </fo:inline>
                      </fo:block>
                      <fo:block space-after="0.2cm">
                        CNE:
                        <fo:inline font-weight="bold">
                          <xsl:value-of select="/Etudiants/Etudiant[@CNE=$cne]/@CNE"/>
                        </fo:inline>
                      </fo:block>
                      <fo:block>
                        Naissance:
                        <fo:inline font-weight="bold">
                          <xsl:value-of select="/Etudiants/Etudiant[@CNE=$cne]/Naissance"/>
                        </fo:inline>
                      </fo:block>
                    </fo:block>
                  </fo:table-cell>

                  <!-- QR Code -->
                  <fo:table-cell padding="0.2cm">
                    <fo:block>
                      <fo:external-graphic
                        src="url('src/main/resources/com/example/gestionscolarite/images/qr_code.jpg')"
                        content-width="2.2cm"
                        content-height="2.2cm"
                        scaling="uniform"/>
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
              </fo:table-body>
            </fo:table>

            <!-- Academic Year -->
            <fo:block text-align="center"
                      font-size="10pt"
                      font-weight="bold"
                      margin-top="0.2cm">
              Année universitaire 2024-2025
            </fo:block>
          </fo:block>
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>
</xsl:stylesheet>
