<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    <xsl:param name="studentCNE" select="''"/>

    <!-- Load grades data -->
    <xsl:variable name="grades" select="document('S3S4notessmall.xml')"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Relevé de Notes</title>
                <style>
                    body { font-family: Arial, sans-serif; margin: 20px; }
                    .header { text-align: center; margin-bottom: 30px; }
                    .logo { height: 80px; margin: 10px; }
                    table { width: 100%; border-collapse: collapse; margin-top: 20px; }
                    th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
                    th { background-color: #f5f5f5; }
                    .student-info { margin: 20px 0; }
                    .module-header { background-color: #e9ecef; font-weight: bold; }
                    .grade { text-align: center; }
                    .grade-success { background-color: #d4edda; }
                    .grade-warning { background-color: #fff3cd; }
                    .grade-danger { background-color: #f8d7da; }
                    .average { font-weight: bold; }
                </style>
            </head>
            <body>
                <div class="header">
                    <img src="C:/XML__PROJECT/src/main/resources/com/example/GestionScolarite/images/images/ensa_tanger.png" alt="ENSA Logo" class="logo"/>
                    <h1>Relevé de Notes</h1>
                    <h2>ENSA Tanger - Année Universitaire 2024-2025</h2>
                    <h3>Filière GINF2</h3>
                </div>

                <xsl:choose>
                    <xsl:when test="$studentCNE != ''">
                        <!-- Single student view -->
                        <xsl:call-template name="studentTranscript">
                            <xsl:with-param name="cne" select="$studentCNE"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- Class view -->
                        <xsl:call-template name="classTranscript"/>
                    </xsl:otherwise>
                </xsl:choose>
            </body>
        </html>
    </xsl:template>

    <!-- Template for single student transcript -->
    <xsl:template name="studentTranscript">
        <xsl:param name="cne"/>
        <div class="student-info">
            <xsl:variable name="student" select="/Etudiants/Etudiant[@CNE=$cne]"/>
            <h3>Information de l'étudiant:</h3>
            <p>Nom: <xsl:value-of select="$student/lastName"/></p>
            <p>Prénom: <xsl:value-of select="$student/firstName"/></p>
            <p>CNE: <xsl:value-of select="$cne"/></p>
        </div>

        <xsl:call-template name="gradesTable">
            <xsl:with-param name="studentNode" select="$grades//Etudiant[@CNE=$cne]"/>
        </xsl:call-template>
    </xsl:template>

    <!-- Template for class transcript -->
    <xsl:template name="classTranscript">
        <table>
            <tr>
                <th>CNE</th>
                <th>Nom</th>
                <th>Prénom</th>
                <xsl:for-each select="$grades//module[1]/matiere">
                    <th><xsl:value-of select="@Nom"/></th>
                </xsl:for-each>
                <th>Moyenne</th>
            </tr>

            <xsl:for-each select="$grades//Etudiant">
                <xsl:variable name="currentCNE" select="@CNE"/>
                <xsl:variable name="student" select="/Etudiants/Etudiant[@CNE=$currentCNE]"/>
                <tr>
                    <td><xsl:value-of select="@CNE"/></td>
                    <td><xsl:value-of select="$student/lastName"/></td>
                    <td><xsl:value-of select="$student/firstName"/></td>

                    <xsl:for-each select="module/matiere">
                        <td class="grade">
                            <xsl:attribute name="class">
                                grade
                                <xsl:choose>
                                    <xsl:when test=". >= 12">grade-success</xsl:when>
                                    <xsl:when test=". >= 8">grade-warning</xsl:when>
                                    <xsl:otherwise>grade-danger</xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>
                            <xsl:value-of select="."/>
                        </td>
                    </xsl:for-each>

                    <!-- Calculate and display average -->
                    <td class="average">
                        <xsl:value-of select="format-number(sum(module/matiere) div count(module/matiere), '#.##')"/>
                    </td>
                </tr>
            </xsl:for-each>

            <!-- Module averages row -->
            <tr class="module-header">
                <td colspan="3">Moyenne de la classe</td>
                <xsl:for-each select="$grades//module[1]/matiere">
                    <xsl:variable name="matiereIndex" select="position()"/>
                    <td class="grade">
                        <xsl:value-of select="format-number(sum($grades//Etudiant/module/matiere[position()=$matiereIndex]) div count($grades//Etudiant), '#.##')"/>
                    </td>
                </xsl:for-each>
                <td class="average">
                    <xsl:value-of select="format-number(sum($grades//Etudiant/module/matiere) div (count($grades//Etudiant) * count($grades//module[1]/matiere)), '#.##')"/>
                </td>
            </tr>
        </table>
    </xsl:template>

    <!-- Template for individual student grades table -->
    <xsl:template name="gradesTable">
        <xsl:param name="studentNode"/>
        <table>
            <tr>
                <th>Module</th>
                <th>Matière</th>
                <th>Note</th>
                <th>Statut</th>
            </tr>

            <xsl:for-each select="$studentNode/module">
                <xsl:variable name="moduleCode" select="@code"/>
                <tr class="module-header">
                    <td colspan="4">
                        <xsl:value-of select="$moduleCode"/> -
                        <xsl:value-of select="document('Modules.xml')//module[@code=$moduleCode]/Designation"/>
                    </td>
                </tr>

                <xsl:for-each select="matiere">
                    <tr>
                        <td></td>
                        <td><xsl:value-of select="@Nom"/></td>
                        <td class="grade">
                            <xsl:attribute name="class">
                                grade
                                <xsl:choose>
                                    <xsl:when test=". >= 12">grade-success</xsl:when>
                                    <xsl:when test=". >= 8">grade-warning</xsl:when>
                                    <xsl:otherwise>grade-danger</xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>
                            <xsl:value-of select="."/>
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

                <!-- Module average -->
                <tr>
                    <td colspan="2" class="average">Moyenne du module</td>
                    <td class="grade average">
                        <xsl:value-of select="format-number(sum(matiere) div count(matiere), '#.##')"/>
                    </td>
                    <td>
                        <xsl:choose>
                            <xsl:when test="sum(matiere) div count(matiere) >= 12">Module Validé</xsl:when>
                            <xsl:otherwise>Module Non Validé</xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
            </xsl:for-each>

            <!-- Overall average -->
            <tr>
                <td colspan="2" class="average">Moyenne Générale</td>
                <td class="grade average" colspan="2">
                    <xsl:value-of select="format-number(sum($studentNode/module/matiere) div count($studentNode/module/matiere), '#.##')"/>
                </td>
            </tr>
        </table>
    </xsl:template>

</xsl:stylesheet>