<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="fo"
    xmlns:date="http://exslt.org/dates-and-times"
    >
    <xsl:param name="cne"/>
    <xsl:template match="/">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="simpleCard" page-height="8cm" page-width="13.5cm">
                    <!-- Définissez les marges de manière appropriée pour votre carte -->
                    <fo:region-body margin="0cm"/>
                    <fo:region-before extent="0cm"/>
                    <fo:region-after extent="0cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="simpleCard">
                <fo:flow flow-name="xsl-region-body" >
                    <fo:block-container background-image="../images/background.jpg"  background-position="center" height="100%" width="100%">
                    <fo:block>
                        <fo:table height="1cm" width="100%" margin-top="5mm">
                            <fo:table-column
                                column-width="10%"/>
                            <fo:table-column
                                column-width="80%"/>
                            <fo:table-column
                                column-width="10%"/>
                            <fo:table-body >
                                <fo:table-cell column-number="1" text-align="right" margin-left="3cm">
                                    <fo:block>
                                        <fo:external-graphic height="0.8cm" width="2cm" content-height="1.5cm"
                                            content-width="2.5cm" src="../images/ensa_tanger.png"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell column-number="2" >
                                    <fo:block-container space-before="1cm" width="100%" font-size="7px" text-align="center" >
                                        <fo:block>Royaume Du Maroc</fo:block>
                                        <fo:block>Université Abdelmalek Essadi</fo:block>
                                        <fo:block>Ecole nationale des sciences appliquées de Tanger</fo:block>
                                    </fo:block-container>
                                </fo:table-cell>
                                <fo:table-cell text-align="center" column-number="3" margin-right="5cm">
                                    <fo:block>
                                        <fo:external-graphic height="0.8cm" width="2cm" content-height="1.5cm"
                                            content-width="2.5cm" src="../images/logoUAE.png"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-body>
                        </fo:table>
                    </fo:block>
                    <fo:block border-bottom-width="1px" width="5cm" border-bottom-style="solid" border-color="#031599" margin-top="7mm"/>
                    <fo:block space-before="0.2cm" font-size="9px" font-weight="bold" font-family="Arial, Helvetica, sans-serif" text-align="center">
                        Carte d'Étudiant
                    </fo:block>
                    
                    <fo:table  space-before="0.5cm" width="100%">
                        <fo:table-column
                            column-width="25%"/>
                        <fo:table-column
                            column-width="50%"/>
                        <fo:table-column
                            column-width="25%"/>
                        <fo:table-body>
                            <fo:table-cell column-number="1" margin-left="5mm">
                                <fo:block>
                                    <fo:block>
                                        <fo:external-graphic height="3cm" width="2.5cm" content-height="3.5cm"
                                            content-width="2.5cm" src="../images/Unknown_person.jpg"/></fo:block>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell display-align="center" column-number="2"  >
                                <fo:block-container space-before="0.5cm" font-size="9px" text-align="left" >
                                    <fo:block>Prénom :  <xsl:value-of select="/Etudiants/Etudiant[@CNE=$cne]/firstName"/> </fo:block>
                                    <fo:block space-before="0.3cm"> Nom :  <xsl:value-of select="/Etudiants/Etudiant[@CNE=$cne]/lastName"/> </fo:block>
                                    <fo:block space-before="0.3cm"> CNE :<xsl:value-of select="Etudiants/Etudiant[@CNE=$cne]/@CNE"/> </fo:block>
                                    <fo:block space-before="0.3cm"> Naissance : <xsl:value-of select="/Etudiants/Etudiant[@CNE=$cne]/Naissance"/> </fo:block>
                                </fo:block-container>
                            </fo:table-cell>
                            <fo:table-cell text-align="left" column-number="3">
                                <fo:block space-start="4cm">
                                    
                                        <fo:external-graphic height="3cm" width="1cm" content-height="3cm"
                                            content-width="2cm" src="../images/qr_code.jpg"/>
                                    
                                </fo:block>
                            </fo:table-cell>
                            
                        </fo:table-body> 
                    </fo:table>         
                    <fo:block space-before="0.3cm" font-size="10px" text-align="center" >Année universitaire 2023-2024</fo:block>
                    </fo:block-container>
                    
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
</xsl:stylesheet>
