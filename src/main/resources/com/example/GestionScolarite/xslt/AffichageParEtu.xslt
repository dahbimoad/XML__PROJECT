<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" indent="yes" encoding="UTF-8"/>

  <xsl:param name="studentCNE"/>

  <xsl:variable name="grades" select="document('S3S4notessmall.xml')"/>
  <xsl:variable name="etudiants" select="document('etudiants.xml')/Etudiants"/>
  <xsl:variable name="modules" select="document('Modules.xml')"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Class Results</title>
        <link href="C:/XML__PROJECT/src/main/resources/com/example/GestionScolarite/css/stylesHTML.css" rel="stylesheet" type="text/css"/>
      </head>
      <body>
        <div class="logo-container">
          <div class="logo-content">
            <img src="C:/XML__PROJECT/src/main/resources/com/example/GestionScolarite/images/ensa_tanger.png" alt="Logo 2" class="logo"/>
            <div class="french-content">
              <p>ROYAUME DU MAROC</p>
              <p>ENSA DE TANGER</p>
              <p>UNIVERSITÉ ABDELMALEK ESSAÂDI</p>
            </div>
          </div>
          <div class="logo-content" style=" direction: rtl;">
            <img src="C:/XML__PROJECT/src/main/resources/com/example/GestionScolarite/images/logoUAE.png" alt="Logo 1" class="logo"/>
            <div class="arabic-content">
              <p>المملكة المغربية</p>
              <p>المدرسة الوطنية للعلوم التطبيقية بطنجة</p>
              <p>جامعة عبد المالك السعدي</p>
            </div>
          </div>
        </div>

        <h1>Relevé de notes</h1>

        <xsl:choose>
          <xsl:when test="$studentCNE">
            <xsl:call-template name="studentTranscript">
              <xsl:with-param name="cne" select="$studentCNE"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="classTranscript"/>
          </xsl:otherwise>
        </xsl:choose>

        <div class="footer">
          <div class="footer-item">N° Téléphone : +212 5 39 39 37 44</div>
          <div class="footer-item">Fax: 05-39-39-37-43</div>
          <div class="footer-item">Adresse: Ecole Nationale des Sciences Appliquées de Tanger BP 1818 - 90000s</div>
          <div class="footer-item email" style="clear:both;">Contact : info@ensat.ac.ma</div>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="classTranscript">
    <table border="1">
      <tr>
        <th>CNE</th>
        <th>Nom</th>
        <th>Prénom</th>
        <xsl:for-each select="$modules/modules/module">
          <th><xsl:value-of select="Designation"/></th>
        </xsl:for-each>
        <th>Moyenne</th>
      </tr>

      <xsl:for-each select="$etudiants/Etudiant">
        <xsl:variable name="studentCNE" select="@CNE"/>
        <xsl:variable name="student" select="$grades//Etudiant[@CNE=$studentCNE]"/>

        <tr>
          <td><xsl:value-of select="$studentCNE"/></td>
          <td><xsl:value-of select="lastName"/></td>
          <td><xsl:value-of select="firstName"/></td>

          <xsl:for-each select="$modules/modules/module">
            <xsl:variable name="moduleCode" select="@code"/>
            <td>
              <xsl:choose>
                <xsl:when test="$student/module[@code=$moduleCode]">
                  <xsl:variable name="score" select="sum($student/module[@code=$moduleCode]/matiere)"/>
                  <xsl:attribute name="style">
                    <xsl:choose>
                      <xsl:when test="$score >= 12">background-color: #d4edda;</xsl:when>
                      <xsl:when test="$score >= 8">background-color: #fff3cd;</xsl:when>
                      <xsl:otherwise>background-color: #f8d7da;</xsl:otherwise>
                    </xsl:choose>
                  </xsl:attribute>
                  <xsl:value-of select="format-number($score, '#.##')"/>
                </xsl:when>
                <xsl:otherwise>-</xsl:otherwise>
              </xsl:choose>
            </td>
          </xsl:for-each>

          <td>
            <xsl:value-of select="format-number(sum($student/module/matiere) div count($student/module/matiere), '#.##')"/>
          </td>
        </tr>
      </xsl:for-each>

      <tr>
        <td colspan="3" style="font-weight:bold;">Moyenne de la classe</td>
        <xsl:for-each select="$modules/modules/module">
          <td>
            <xsl:value-of select="format-number(sum($grades//module[@code=current()/@code]/matiere) div count($grades//Etudiant), '#.##')"/>
          </td>
        </xsl:for-each>
        <td>
          <xsl:value-of select="format-number(sum($grades//matiere) div count($grades//matiere), '#.##')"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="studentTranscript">
    <xsl:param name="cne"/>
    <xsl:variable name="student" select="$etudiants/Etudiant[@CNE=$cne]"/>
    <xsl:variable name="studentGrades" select="$grades//Etudiant[@CNE=$cne]"/>

    <div class="student-info">
      <h3><xsl:value-of select="concat($student/lastName, ' ', $student/firstName)"/></h3>
      <p>N° étudiant : <xsl:value-of select="$cne"/>
         Né le : <xsl:value-of select="$student/Naissance"/></p>
      <p>Inscrit en  <b>GINF-2</b></p>
    </div>

    <xsl:call-template name="gradesTable">
      <xsl:with-param name="studentNode" select="$studentGrades"/>
    </xsl:call-template>

  </xsl:template>

  <xsl:template name="gradesTable">
    <xsl:param name="studentNode"/>

    <table border="1">
      <tr>
        <th>Code</th>
        <th>Module</th>
        <th>Matière</th>
        <th>Note</th>
        <th>Statut</th>
      </tr>

      <xsl:for-each select="$studentNode/module">
        <xsl:variable name="moduleCode" select="@code"/>
        <xsl:variable name="moduleName" select="$modules//module[@code=$moduleCode]/Designation"/>

        <tr style="background-color:#e9ecef; font-weight:bold;">
          <td><xsl:value-of select="$moduleCode"/></td>
          <td colspan="4">
            <xsl:value-of select="$moduleName"/>
          </td>
        </tr>

        <xsl:for-each select="matiere">
          <tr>
            <td></td>
            <td></td>
            <td><xsl:value-of select="@Nom"/></td>
            <td>
              <xsl:variable name="score" select="."/>
              <xsl:attribute name="style">
                <xsl:choose>
                  <xsl:when test="$score >= 12">background-color:#d4edda;</xsl:when>
                  <xsl:when test="$score >= 8">background-color:#fff3cd;</xsl:when>
                  <xsl:otherwise>background-color:#f8d7da;</xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
              <xsl:value-of select="$score"/>
            </td>
            <td>
              <xsl:choose>
                <xsl:when test=". >= 12">Validé</xsl:when>
                <xsl:when test=". >= 8">Rattrapage</xsl:when>
                <xsl:otherwise>Non Validé</xsl:otherwise>
              </xsl:choose>
            </td>
          </tr>
        </xsl:for-each>

        <tr>
          <td colspan="3" style="font-weight:bold;">Moyenne du Module</td>
          <td colspan="2">
            <xsl:value-of select="format-number(sum(matiere) div count(matiere), '#.##')"/>
            <xsl:text> - </xsl:text>
            <xsl:choose>
              <xsl:when test="sum(matiere) div count(matiere) >= 12">
                Module Validé
              </xsl:when>
              <xsl:otherwise>Module Non Validé</xsl:otherwise>
            </xsl:choose>
          </td>
        </tr>
      </xsl:for-each>

      <tr>
        <td colspan="3" style="font-weight:bold;">Moyenne Générale</td>
        <td colspan="2">
          <xsl:value-of select="format-number(sum($studentNode/module/matiere) div count($studentNode/module/matiere), '#.##')"/>
        </td>
      </tr>
    </table>
  </xsl:template>

</xsl:stylesheet>