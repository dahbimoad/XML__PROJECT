<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes"/>

    <xsl:param name="studentCNE"/>
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
                <xsl:choose>
                    <xsl:when test="$studentCNE">
                        <xsl:for-each select="notes/Etudiant[@CNE = $studentCNE]">
                            <h1>Relevé de notes</h1>
                            <xsl:variable name="cne" select="@CNE"/>
                            <xsl:variable name="Etudiants" select="document('C:\XML__PROJECT\src\main\resources\com\example\GestionScolarite\xml\etudiants.xml')/Etudiants"/>
                            <xsl:variable name="studentInfo" select="$Etudiants/Etudiant[@CNE=$cne]"/>
                            <xsl:variable name="full_name" select="concat($studentInfo/lastName, ' ', $studentInfo/firstName)"/>
                            <xsl:variable name="total" select="format-number((sum(module/matiere) div count(module/matiere)), '#.##')"/>
                            <div class="student-info">
                                <h3><xsl:value-of select="$full_name"/></h3>
                                <p>N° étudiant : <xsl:value-of select="@CNE"/>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;Né le : <xsl:value-of select="$studentInfo/Naissance"/></p>
                                <p>Inscrit en  <b>GINF-2</b></p>
                            </div>
                            <table border="1">
                                
                                <tr>
                                    <th>Code</th>
                                    <th>Module</th>
                                    <th>Nom de Matiere</th>
                                    <th>Note Matiere</th>
                                    <th>Moyenne</th>
                                    <th>Décision</th>
                                </tr>
                                <xsl:for-each select="module">
                                    <xsl:variable name="moduleCode" select="@code"/>
                                    <xsl:variable name="modules" select="document('C:\XML__PROJECT\src\main\resources\com\example\GestionScolarite\xml\Modules.xml')/modules/module[@code=$moduleCode]"/>
                                    <xsl:variable name="moduleName" select="$modules/Designation"/>
                                    <tr>
                                        <td rowspan="{count(matiere) + 1}">
                                            <xsl:value-of select="$moduleCode"/>
                                        </td>
                                        <td rowspan="{count(matiere) + 1}">
                                            <xsl:value-of select="$moduleName"/>
                                        </td>
                                    </tr>
                                    <xsl:variable name="notemodule" select="format-number((sum(matiere) div count(matiere)), '#.##')"/>
                                    <xsl:for-each select="matiere">
                                        <tr>
                                            <td><xsl:value-of select="@Nom"/></td>
                                            <td><xsl:value-of select="."/></td>
                                            <xsl:if test="not(position() = last())">
                                                <td rowspan="2">
                                                    <xsl:if test="$notemodule &lt; 8">
                                                        <xsl:attribute name="style">background-color: red;</xsl:attribute>
                                                    </xsl:if>
                                                    <xsl:if test="$notemodule &gt;= 8 and $notemodule &lt; 12">
                                                        <xsl:attribute name="style">background-color: orange;</xsl:attribute>
                                                    </xsl:if>
                                                    <xsl:if test="$notemodule &gt;= 12 and $notemodule &lt; 14">
                                                        <xsl:attribute name="style">background-color: yellow;</xsl:attribute>
                                                    </xsl:if>
                                                    <xsl:if test="$notemodule &gt;= 14 and $notemodule &lt; 16">
                                                        <xsl:attribute name="style">background-color: gold;</xsl:attribute>
                                                    </xsl:if>
                                                    <xsl:if test="$notemodule &gt;= 16">
                                                        <xsl:attribute name="style">background-color: green;</xsl:attribute>
                                                    </xsl:if>
                                                    <xsl:value-of select="$notemodule"/>
                                                </td>
                                                <td rowspan="2">
                                                    <xsl:if test="$notemodule &lt; 8">
                                                        <xsl:attribute name="style">color: red;</xsl:attribute>
                                                        A refaire
                                                    </xsl:if>
                                                    <xsl:if test="$notemodule &gt;= 8 and $notemodule &lt; 12">
                                                        <xsl:attribute name="style">color: orange;</xsl:attribute>
                                                        Rattrapage
                                                    </xsl:if>
                                                    <xsl:if test="$notemodule &gt;= 12">
                                                        <xsl:attribute name="style">color: green;</xsl:attribute>
                                                        Validé
                                                    </xsl:if>
                                                </td>
                                            </xsl:if>
                                        </tr>
                                    </xsl:for-each>
                                </xsl:for-each>
                                
                            </table>
                            <h1>Résultat : <xsl:value-of select="$total"/></h1>
                        </xsl:for-each> 
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="notes/Etudiant">
                
                
                    <h1>Relevé de notes</h1>
                    <xsl:variable name="cne" select="@CNE"/>
                    <xsl:variable name="Etudiants" select="document('C:\XML__PROJECT\src\main\resources\com\example\GestionScolarite\xml\etudiants.xml')/Etudiants"/>
                    <xsl:variable name="studentInfo" select="$Etudiants/Etudiant[@CNE=$cne]"/>
                    <xsl:variable name="full_name" select="concat($studentInfo/lastName, ' ', $studentInfo/firstName)"/>
                    <xsl:variable name="total" select="format-number((sum(module/matiere) div count(module/matiere)), '#.##')"/>
                            
                            <div class="student-info">
                            <h3><xsl:value-of select="$full_name"/></h3>
                                <p>N° étudiant : <xsl:value-of select="@CNE"/>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;Né le : <xsl:value-of select="$studentInfo/Naissance"/></p>
                            <p>Inscrit en  <b>GINF-2</b></p>
                                </div>
                    <table border="1">
                        
                        <tr>
                            <th>Code</th>
                            <th>Module</th>
                            <th>Matiere Name</th>
                            <th>Note Matiere</th>
                            <th>Moyenne</th>
                            <th>Décision</th>
                        </tr>
                        <xsl:for-each select="module">
                            <xsl:variable name="moduleCode" select="@code"/>
                            <xsl:variable name="modules" select="document('C:\XML__PROJECT\src\main\resources\com\example\GestionScolarite\xml\Modules.xml')/modules/module[@code=$moduleCode]"/>
                            <xsl:variable name="moduleName" select="$modules/Designation"/>
                            <tr>
                                <td rowspan="{count(matiere) + 1}">
                                    <xsl:value-of select="$moduleCode"/>
                                </td>
                                <td rowspan="{count(matiere) + 1}">
                                    <xsl:value-of select="$moduleName"/>
                                </td>
                            </tr>
                            <xsl:variable name="notemodule" select="format-number((sum(matiere) div count(matiere)), '#.##')"/>
                            <xsl:for-each select="matiere">
                                <tr>
                                    <td><xsl:value-of select="@Nom"/></td>
                                    <td><xsl:value-of select="."/></td>
                                    <xsl:if test="not(position() = last())">
                                        <td rowspan="2">
                                            <xsl:if test="$notemodule &lt; 8">
                                                <xsl:attribute name="style">background-color: red;</xsl:attribute>
                                            </xsl:if>
                                            <xsl:if test="$notemodule &gt;= 8 and $notemodule &lt; 12">
                                                <xsl:attribute name="style">background-color: orange;</xsl:attribute>
                                            </xsl:if>
                                            <xsl:if test="$notemodule &gt;= 12 and $notemodule &lt; 14">
                                                <xsl:attribute name="style">background-color: yellow;</xsl:attribute>
                                            </xsl:if>
                                            <xsl:if test="$notemodule &gt;= 14 and $notemodule &lt; 16">
                                                <xsl:attribute name="style">background-color: gold;</xsl:attribute>
                                            </xsl:if>
                                            <xsl:if test="$notemodule &gt; 16">
                                                <xsl:attribute name="style">background-color: green;</xsl:attribute>
                                            </xsl:if>
                                            <xsl:value-of select="$notemodule"/>
                                        </td>
                                        <td rowspan="2">
                                            <xsl:if test="$notemodule &lt; 8">
                                                <xsl:attribute name="style">color: red;</xsl:attribute>
                                                A refaire
                                            </xsl:if>
                                            <xsl:if test="$notemodule &gt;= 8 and $notemodule &lt; 12">
                                                <xsl:attribute name="style">color: orange;</xsl:attribute>
                                                Rattrapage
                                            </xsl:if>
                                            <xsl:if test="$notemodule &gt;= 12">
                                                <xsl:attribute name="style">color: green;</xsl:attribute>
                                                Validé
                                            </xsl:if>
                                        </td>
                                    </xsl:if>
                                </tr>
                            </xsl:for-each>
                        </xsl:for-each>
                        
                    </table>
                    <h1>Résultat : <xsl:value-of select="$total"/></h1>
                    </xsl:for-each> 
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
</xsl:stylesheet>
