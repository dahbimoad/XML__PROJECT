<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
    xmlns:x="urn:schemas-microsoft-com:office:excel">

    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

    <xsl:template match="/">
        <ss:Workbook>
            <!-- Excel-Compatible Styles -->
            <ss:Styles>
                <ss:Style ss:ID="Header">
                    <ss:Font ss:Bold="1"/>
                    <ss:Interior ss:Color="#BFBFBF" ss:Pattern="Solid"/>
                    <ss:Borders>
                        <ss:Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
                        <ss:Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
                    </ss:Borders>
                </ss:Style>
                <ss:Style ss:ID="Cell">
                    <ss:Borders>
                        <ss:Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
                        <ss:Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
                    </ss:Borders>
                </ss:Style>
            </ss:Styles>

            <!-- Worksheet -->
            <ss:Worksheet ss:Name="EDT">
                <ss:Table>
                    <!-- Header Row -->
                    <ss:Row>
                        <ss:Cell ss:StyleID="Header">
                            <ss:Data ss:Type="String">Time</ss:Data>
                        </ss:Cell>
                        <xsl:for-each select="emploi/Days/day">
                            <ss:Cell ss:StyleID="Header">
                                <ss:Data ss:Type="String">
                                    <xsl:value-of select="@name"/>
                                </ss:Data>
                            </ss:Cell>
                        </xsl:for-each>
                    </ss:Row>

                    <!-- Time Slots -->
                    <xsl:for-each select="emploi/times/time">
                        <ss:Row>
                            <xsl:variable name="currentTime" select="@t"/>
                            <!-- Time Cell -->
                            <ss:Cell ss:StyleID="Cell">
                                <ss:Data ss:Type="String">
                                    <xsl:value-of select="$currentTime"/>
                                </ss:Data>
                            </ss:Cell>

                            <!-- Days -->
                            <xsl:for-each select="/emploi/Days/day">
                                <xsl:variable name="currentDay" select="@name"/>
                                <!-- Matiere Data -->
                                <ss:Cell ss:StyleID="Cell">
                                    <ss:Data ss:Type="String">
                                        <xsl:for-each select="/emploi/matieres/matiere[jour=$currentDay and startTime=$currentTime]">
                                            <xsl:value-of select="concat(nom, ' - ', type, ' - ', nomProf, ' - ', salle)"/>
                                            <xsl:if test="position() != last()">
                                                <xsl:text>&#10;</xsl:text> <!-- Line break -->
                                            </xsl:if>
                                        </xsl:for-each>
                                    </ss:Data>
                                </ss:Cell>
                            </xsl:for-each>
                        </ss:Row>
                    </xsl:for-each>
                </ss:Table>
            </ss:Worksheet>
        </ss:Workbook>
    </xsl:template>
</xsl:stylesheet>