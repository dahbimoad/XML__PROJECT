<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes"/>
    <xsl:param name="codeModu"/>
    <xsl:template match="/">
        <html>
            <head>
                <link href="../CSS/styles1.css" rel="stylesheet" type="text/css"/>
                <title>Class Results</title>
            </head>
            <body>
                <div class="logo-container">
                    <div class="logo-content">
                        <img src="../images/ensa_tanger.png" alt="Logo 2" class="logo"/>
                        <div class="french-content">
                            <p>ROYAUME DU MAROC</p>
                            <p>ENSA DE TANGER</p>
                            <p>UNIVERSITÉ ABDELMALEK ESSAÂDI</p>
                        </div>
                    </div>
                    <div class="logo-content" style=" direction: rtl;">
                        <img src="../images/logoUAE.png" alt="Logo 1" class="logo"/>
                        <div class="arabic-content">
                            <p>المملكة المغربية</p>
                            <p>المدرسة الوطنية للعلوم التطبيقية بطنجة</p>
                            <p>جامعة عبد المالك السعدي</p>
                        </div>
                    </div>
                </div>
                <xsl:choose>
                    <xsl:when test="$codeModu">
                        <xsl:for-each select="modules/module[@code = $codeModu]">
                            <xsl:variable name="codemod" select="@code"/>
                            <h1>Code : <xsl:value-of select="@code"/></h1>
                            <h1>Module : <xsl:value-of select="Designation"/></h1>
                            <table border="1">
                                
                                <tr>
                                    <th>Cne</th>
                                    <th>Nom Complet</th>
                                    <xsl:for-each select="matiere">
                                        <th><xsl:value-of select="matiereName"/></th>
                                        <xsl:if test="position() != last()">
                                            <xsl:text>, </xsl:text>
                                        </xsl:if>
                                    </xsl:for-each>
                                    <th>Moyenne</th>
                                    <th>Décision</th>
                                </tr>
                                <xsl:for-each select="document('S3S4notessmall.xml')/notes/Etudiant">
                                    <xsl:variable name="cne" select="@CNE"/>
                                    <xsl:variable name="Etudiants" select="document('etudiants.xml')/Etudiants"/>
                                    <xsl:variable name="studentInfo" select="$Etudiants/Etudiant[@CNE=$cne]"/>
                                    <xsl:variable name="full_name" select="concat($studentInfo/lastName, ' ', $studentInfo/firstName)"/>
                                    <xsl:variable name="module" select="module[@code=$codemod]"/>
                                    <xsl:variable name="avg" select="sum($module/matiere) div count($module/matiere)"/>
                                    <tr>
                                        <td><xsl:value-of select="$cne"/></td>
                                        <td><xsl:value-of select="$full_name"/></td>
                                        <td><xsl:value-of select="$module/matiere[1]"/></td>
                                        <td><xsl:value-of select="$module/matiere[2]"/></td>
                                        <td>
                                            <xsl:if test="$avg &lt; 8">
                                                <xsl:attribute name="style">background-color: red;</xsl:attribute>
                                            </xsl:if>
                                            <xsl:if test="$avg &gt;= 8 and $avg &lt; 12">
                                                <xsl:attribute name="style">background-color: orange;</xsl:attribute>
                                            </xsl:if>
                                            <xsl:if test="$avg &gt;= 12 and $avg &lt; 14">
                                                <xsl:attribute name="style">background-color: yellow;</xsl:attribute>
                                            </xsl:if>
                                            <xsl:if test="$avg &gt;= 14 and $avg &lt; 16">
                                                <xsl:attribute name="style">background-color: gold;</xsl:attribute>
                                            </xsl:if>
                                            <xsl:if test="$avg &gt; 16">
                                                <xsl:attribute name="style">background-color: green;</xsl:attribute>
                                            </xsl:if>
                                            <xsl:value-of select="$avg"/>
                                        </td>
                                        <td>
                                            <xsl:if test="$avg &lt; 8">
                                                <xsl:attribute name="style">color: red;</xsl:attribute>
                                                A refaire
                                            </xsl:if>
                                            <xsl:if test="$avg &gt;= 8 and $avg &lt; 12">
                                                <xsl:attribute name="style">color: orange;</xsl:attribute>
                                                Rattrapage
                                            </xsl:if>
                                            <xsl:if test="$avg &gt; 12">
                                                <xsl:attribute name="style">color: green;</xsl:attribute>
                                                Validé
                                            </xsl:if>
                                        </td>
                                    </tr>
                                    
                                </xsl:for-each>
                                
                            </table>
                        </xsl:for-each> 
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:for-each select="modules/module">
                    <xsl:variable name="codemod" select="@code"/>
                    <h1>Code : <xsl:value-of select="@code"/></h1>
                    <h1>Module : <xsl:value-of select="Designation"/></h1>
                    <table border="1">
                        
                        <tr>
                            <th>Cne</th>
                            <th>Nom Complet</th>
                            <xsl:for-each select="matiere">
                                <th><xsl:value-of select="matiereName"/></th>
                                <xsl:if test="position() != last()">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                            <th>Moyenne</th>
                            <th>Décision</th>
                        </tr>
                        <xsl:for-each select="document('S3S4notessmall.xml')/notes/Etudiant">
                        <xsl:variable name="cne" select="@CNE"/>
                        <xsl:variable name="Etudiants" select="document('etudiants.xml')/Etudiants"/>
                        <xsl:variable name="studentInfo" select="$Etudiants/Etudiant[@CNE=$cne]"/>
                        <xsl:variable name="full_name" select="concat($studentInfo/lastName, ' ', $studentInfo/firstName)"/>
                        <xsl:variable name="module" select="module[@code=$codemod]"/>
                        <xsl:variable name="avg" select="sum($module/matiere) div count($module/matiere)"/>
                            <tr>
                                <td><xsl:value-of select="$cne"/></td>
                                <td><xsl:value-of select="$full_name"/></td>
                                <td><xsl:value-of select="$module/matiere[1]"/></td>
                                <td><xsl:value-of select="$module/matiere[2]"/></td>
                                <td>
                                    <xsl:if test="$avg &lt; 8">
                                        <xsl:attribute name="style">background-color: red;</xsl:attribute>
                                    </xsl:if>
                                    <xsl:if test="$avg &gt;= 8 and $avg &lt; 12">
                                        <xsl:attribute name="style">background-color: orange;</xsl:attribute>
                                    </xsl:if>
                                    <xsl:if test="$avg &gt;= 12 and $avg &lt; 14">
                                        <xsl:attribute name="style">background-color: yellow;</xsl:attribute>
                                    </xsl:if>
                                    <xsl:if test="$avg &gt;= 14 and $avg &lt; 16">
                                        <xsl:attribute name="style">background-color: gold;</xsl:attribute>
                                    </xsl:if>
                                    <xsl:if test="$avg &gt; 16">
                                        <xsl:attribute name="style">background-color: green;</xsl:attribute>
                                    </xsl:if>
                                    <xsl:value-of select="$avg"/>
                                </td>
                                    <td>
                                        <xsl:if test="$avg &lt; 8">
                                            <xsl:attribute name="style">color: red;</xsl:attribute>
                                            A refaire
                                        </xsl:if>
                                        <xsl:if test="$avg &gt;= 8 and $avg &lt; 12">
                                            <xsl:attribute name="style">color: orange;</xsl:attribute>
                                            Rattrapage
                                        </xsl:if>
                                        <xsl:if test="$avg &gt; 12">
                                            <xsl:attribute name="style">color: green;</xsl:attribute>
                                            Validé
                                        </xsl:if>
                                    </td>
                            </tr>
                            
                         </xsl:for-each>
                        
                    </table>
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
