<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times"
    xmlns:java="java"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="fo">
    <xsl:param name="cne"/>
    <xsl:template match="/">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="simpleA4" page-height="29.7cm" page-width="21cm" margin-top="2cm" margin-bottom="2cm" margin-left="2cm" margin-right="2cm">
                    <fo:region-body/>
                    <fo:region-before extent="2cm"/>
                    <fo:region-after extent="2cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="simpleA4">
                <fo:flow flow-name="xsl-region-body" >
                    <fo:block-container text-align="center">
                        <fo:table width="100%">
                            <fo:table-column column-width="50%"/>
                            <fo:table-column column-width="50%"/>
                            <fo:table-body>
                                <fo:table-row>
                                    
                                    <fo:table-cell>
                                        <fo:block text-align="left">
                                            <fo:external-graphic height="18mm" width="18mm" content-height="40mm"
                                                content-width="40mm" src="../images/ensa_tanger.png">
                                            </fo:external-graphic>
                                        </fo:block>
                                    </fo:table-cell>
                                    
                                    <fo:table-cell>
                                        <fo:block text-align="right">
                                            <fo:external-graphic height="25mm" width="18mm" content-height="23mm"
                                                content-width="40mm" src="../images/logoUAE.png">
                                            </fo:external-graphic>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-body>
                        </fo:table>
                        <fo:table width="100%">
                            <fo:table-column column-width="50%"/>
                            <fo:table-column column-width="50%"/>
                            <fo:table-body>
                                <fo:table-row>
                                    
                                    
                                    <fo:table-cell>
                                        <fo:block text-align="left">
                                            <fo:block font-size="10px" space-before="1mm" space-after="2mm">ROYAUME DU MAROC</fo:block>
                                            <fo:block font-size="10px" space-before="1mm" space-after="2mm">ENSA DE TANGER</fo:block>
                                            <fo:block font-size="10px" space-after="2mm" >UNIVERSITÉ ABDELMALEK ESSAÂDI</fo:block>
                                        </fo:block>
                                    </fo:table-cell>
                                    
                                    <fo:table-cell>
                                        <fo:block text-align="right">
                                            <fo:block font-family="Arial" font-size="10px" space-before="1mm" space-after="2mm">المملكة المغربية</fo:block>
                                            <fo:block font-family="Arial" font-size="10px" space-before="1mm" space-after="2mm">المدرسة الوطنية للعلوم التطبيقية بطنجة</fo:block>
                                            <fo:block font-family="Arial" font-size="10px" space-before="1mm" space-after="2mm">جامعة عبد المالك السعدي</fo:block>
                                        </fo:block>
                                    </fo:table-cell>
                                    
                                </fo:table-row>
                            </fo:table-body>
                        </fo:table>
                        <fo:block text-decoration="underline" font-weight="bold" text-align="center" font-size="13px" space-before="2cm" space-after="2cm">ATTESTATION D'INSCRIPTION</fo:block>
                        <fo:block white-space="pre" text-align="left" font-size="11px" space-before="5mm" space-after="5mm">Le Directeur de l'Ecole Nationale des Sciences Appliquées de Tanger atteste que</fo:block>
                        <fo:block white-space="pre" text-align="left" font-size="11px"><xsl:value-of select="concat('Mr/Mme : ', Etudiants/Etudiant[@CNE=$cne]/firstName, ' ', Etudiants/Etudiant[@CNE=$cne]/lastName)"/></fo:block>
                        <fo:block text-align="left"  font-size="11px" space-before="5mm" space-after="5mm">
                            Né le <xsl:value-of select="Etudiants/Etudiant[@CNE=$cne]/Naissance"/> à <xsl:value-of select="Etudiants/Etudiant[@CNE=$cne]/Ville"/> ( Maroc )
                        </fo:block>
                        <fo:block text-align="left"  font-size="11px" space-before="5mm" space-after="5mm">
                            Est inscrit(e) à l'École Nationale des Sciences Appliquées de Tanger pour l'année universitaire 2023/2024
                        </fo:block>
                        
                        <fo:block text-align="left" font-size="11px" space-before="5mm" space-after="5mm">
                            <fo:inline text-decoration="underline">Niveau</fo:inline> : Cycle D'Ingénieur
                        </fo:block>
                        
                        <fo:block text-align="left"  font-size="11px" space-before="5mm" space-after="5mm"><fo:inline text-decoration="underline">Filière</fo:inline> : Génie Informatique</fo:block>
                        <fo:block text-align="left"  font-size="11px" space-before="5mm" space-after="5mm"><fo:inline text-decoration="underline">Année</fo:inline> : 4 ème année ( 2ème année du Cycle d'Ingénieur )</fo:block>
                            
                        <!--<xsl:variable name="currentDate" select="java:util.Date.new()" />
                        
                        
                        <xsl:variable name="year" select="substring($currentDate, 1, 4)" />
                        <xsl:variable name="month" select="substring($currentDate, 6, 2)" />
                        <xsl:variable name="day" select="substring($currentDate, 9, 2)" />
                        <xsl:variable name="formattedDate" select="concat($day, ' ', $month, ' ', $year)" />-->
                        <fo:block text-align="center" font-size="11px" space-before="1cm" space-after="1cm">Fait à Tanger le <xsl:value-of select="java:util.Date.new()" />
                            
                        </fo:block>
                        <fo:block text-align="center" font-size="11px" space-before="1cm" space-after="1cm">Directeur de L'ENSA de Tanger </fo:block>
                        
                        
                        <fo:block space-before="1cm" font-size="10px">Avis important: Le présent document n'est délivré qu'en un seul exemplaire.
                            Il appartient à l'étudiant d'en faire des photocopies certifiées conformes.</fo:block>
                        
                        <fo:block border-bottom-width="0.5pt" width="5cm" border-bottom-style="dashed" space-after="2mm" margin-top="7mm"/>
                        
                        <fo:block font-size="10px" display-align="center" space-before="1cm" space-after="5mm">
                            N° Téléphone : +212 5 39 39 37 44
                            <fo:inline space-before="5mm"/>
                            Fax: 05-39-39-37-43
                        </fo:block>
                        <fo:block font-size="10px" display-align="center"  space-after="5mm">Adresse: Ecole Nationale des Sciences Appliquées de Tanger BP 1818 - 90000s</fo:block>
                        <fo:block font-size="10px" display-align="center"  space-after="5mm">Contact : info@ensat.ac.ma</fo:block>
                    </fo:block-container>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    <xsl:function name="java:util.Date.new"/>
</xsl:stylesheet>