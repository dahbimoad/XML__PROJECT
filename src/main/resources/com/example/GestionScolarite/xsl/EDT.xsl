<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="A4-landscape"
                    page-width="29.7cm" page-height="21cm"
                    margin-top="1cm" margin-bottom="1cm"
                    margin-left="1cm" margin-right="1cm">
                    <fo:region-body margin="1cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>

            <fo:page-sequence master-reference="A4-landscape">
                <fo:flow flow-name="xsl-region-body">
                    <!-- Title -->
                    <fo:block font-size="14pt" font-weight="bold" text-align="center" space-after="0.5cm" color="#2c3e50">
                        Emploi du temps GINF2
                    </fo:block>

                    <!-- Timetable -->
                    <fo:table width="100%" table-layout="fixed" border-collapse="separate" border-separation="2pt">
                        <!-- Define columns with specific widths -->
                        <fo:table-column column-width="3cm"/>
                        <xsl:for-each select="emploi/Days/day">
                            <fo:table-column column-width="4cm"/>
                        </xsl:for-each>

                        <!-- Header -->
                        <fo:table-header>
                            <fo:table-row>
                                <fo:table-cell border="0.5pt solid #34495e" padding="2pt" background-color="#34495e">
                                    <fo:block font-weight="bold" font-size="10pt" text-align="center" color="white">
                                        Horaire
                                    </fo:block>
                                </fo:table-cell>
                                <xsl:for-each select="emploi/Days/day">
                                    <fo:table-cell border="0.5pt solid #34495e" padding="2pt" background-color="#34495e">
                                        <fo:block font-weight="bold" font-size="10pt" text-align="center" color="white">
                                            <xsl:value-of select="@name"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </xsl:for-each>
                            </fo:table-row>
                        </fo:table-header>

                        <!-- Body -->
                        <fo:table-body>
                            <xsl:for-each select="emploi/times/time">
                                <xsl:variable name="currentTime" select="@t"/>
                                <fo:table-row>
                                    <fo:table-cell border="0.5pt solid #bdc3c7" padding="2pt" background-color="#ecf0f1">
                                        <fo:block font-size="9pt" text-align="center" color="#2c3e50">
                                            <xsl:value-of select="$currentTime"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <xsl:for-each select="/emploi/Days/day">
                                        <xsl:variable name="currentDay" select="@name"/>
                                        <fo:table-cell border="0.5pt solid #bdc3c7" padding="2pt">
                                            <fo:block>
                                                <xsl:choose>
                                                    <xsl:when test="/emploi/matieres/matiere[jour=$currentDay and startTime=$currentTime]">
                                                        <xsl:for-each select="/emploi/matieres/matiere[jour=$currentDay and startTime=$currentTime]">
                                                            <fo:block font-size="8pt"
                                                                    margin-bottom="2pt"
                                                                    padding="2pt"
                                                                    background-color="#e8f6f3"
                                                                    border="0.5pt solid #a3e4d7"
                                                                    text-align="center">
                                                                <fo:block font-weight="bold" color="#2c3e50">
                                                                    <xsl:value-of select="nom"/>
                                                                </fo:block>
                                                                <fo:block font-size="7pt" color="#34495e">
                                                                    <xsl:value-of select="nomProf"/>
                                                                </fo:block>
                                                                <fo:block font-size="7pt" color="#7f8c8d">
                                                                    <xsl:value-of select="salle"/>
                                                                </fo:block>
                                                            </fo:block>
                                                        </xsl:for-each>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <fo:block>&#160;</fo:block>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </fo:block>
                                        </fo:table-cell>
                                    </xsl:for-each>
                                </fo:table-row>
                            </xsl:for-each>
                        </fo:table-body>
                    </fo:table>

                    <!-- Legend -->
                    <fo:block space-before="0.5cm" font-size="9pt" color="#2c3e50">
                        <fo:block font-weight="bold" margin-bottom="2pt">Légende:</fo:block>
                        <fo:block margin-left="1cm">CM - Cours Magistral</fo:block>
                        <fo:block margin-left="1cm">TP - Travaux Pratiques</fo:block>
                        <fo:block margin-left="1cm">TD - Travaux Dirigés</fo:block>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
</xsl:stylesheet>