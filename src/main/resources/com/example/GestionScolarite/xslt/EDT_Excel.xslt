<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
    xmlns:x="urn:schemas-microsoft-com:office:excel">

    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

    <xsl:template match="/">
        <ss:Workbook>
            <!-- Enhanced Excel Styles -->
            <ss:Styles>
                <!-- Header Style -->
                <ss:Style ss:ID="Header">
                    <ss:Font ss:Bold="1" ss:Size="12" ss:Color="#FFFFFF"/>
                    <ss:Interior ss:Color="#4472C4" ss:Pattern="Solid"/>
                    <ss:Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
                    <ss:Borders>
                        <ss:Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="2" ss:Color="#FFFFFF"/>
                        <ss:Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="2" ss:Color="#FFFFFF"/>
                        <ss:Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="2" ss:Color="#FFFFFF"/>
                        <ss:Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="2" ss:Color="#FFFFFF"/>
                    </ss:Borders>
                </ss:Style>

                <!-- Time Column Style -->
                <ss:Style ss:ID="TimeColumn">
                    <ss:Font ss:Bold="1" ss:Size="11" ss:Color="#000000"/>
                    <ss:Interior ss:Color="#D9E1F2" ss:Pattern="Solid"/>
                    <ss:Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
                    <ss:Borders>
                        <ss:Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
                        <ss:Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
                        <ss:Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
                        <ss:Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
                    </ss:Borders>
                </ss:Style>

                <!-- Regular Cell Style -->
                <ss:Style ss:ID="Cell">
                    <ss:Font ss:Size="11"/>
                    <ss:Alignment ss:Vertical="Center" ss:WrapText="1"/>
                    <ss:Borders>
                        <ss:Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#D9D9D9"/>
                        <ss:Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#D9D9D9"/>
                        <ss:Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#D9D9D9"/>
                        <ss:Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#D9D9D9"/>
                    </ss:Borders>
                </ss:Style>

                <!-- Alternate Row Style -->
                <ss:Style ss:ID="AlternateRow">
                    <ss:Font ss:Size="11"/>
                    <ss:Interior ss:Color="#F5F5F5" ss:Pattern="Solid"/>
                    <ss:Alignment ss:Vertical="Center" ss:WrapText="1"/>
                    <ss:Borders>
                        <ss:Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#D9D9D9"/>
                        <ss:Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#D9D9D9"/>
                        <ss:Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#D9D9D9"/>
                        <ss:Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#D9D9D9"/>
                    </ss:Borders>
                </ss:Style>
            </ss:Styles>

            <!-- Worksheet -->
            <ss:Worksheet ss:Name="Emploi du temps">
                <ss:Table ss:DefaultColumnWidth="120" ss:DefaultRowHeight="50">
                    <!-- Header Row -->
                    <ss:Row ss:Height="35">
                        <ss:Cell ss:StyleID="Header">
                            <ss:Data ss:Type="String">Horaire</ss:Data>
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
                        <xsl:variable name="currentTime" select="@t"/>
                        <xsl:variable name="rowPosition" select="position()"/>

                        <ss:Row>
                            <!-- Time Cell -->
                            <ss:Cell ss:StyleID="TimeColumn">
                                <ss:Data ss:Type="String">
                                    <xsl:value-of select="$currentTime"/>
                                </ss:Data>
                            </ss:Cell>

                            <!-- Days -->
                            <xsl:for-each select="/emploi/Days/day">
                                <xsl:variable name="currentDay" select="@name"/>
                                <!-- Matiere Data -->
                                <ss:Cell>
                                    <xsl:attribute name="ss:StyleID">
                                        <xsl:choose>
                                            <xsl:when test="$rowPosition mod 2 = 0">AlternateRow</xsl:when>
                                            <xsl:otherwise>Cell</xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:attribute>
                                    <ss:Data ss:Type="String">
                                        <xsl:for-each select="/emploi/matieres/matiere[jour=$currentDay and startTime=$currentTime]">
                                            <xsl:value-of select="concat(nom, ' - ', type, ' - ', nomProf, ' - ', salle)"/>
                                            <xsl:if test="position() != last()">
                                                <xsl:text>&#10;</xsl:text>
                                            </xsl:if>
                                        </xsl:for-each>
                                    </ss:Data>
                                </ss:Cell>
                            </xsl:for-each>
                        </ss:Row>
                    </xsl:for-each>
                </ss:Table>

                <!-- Set column widths -->
                <x:WorksheetOptions>
                    <x:Selected/>
                    <x:FreezePanes/>
                    <x:FrozenNoSplit/>
                    <x:SplitHorizontal>1</x:SplitHorizontal>
                    <x:TopRowBottomPane>1</x:TopRowBottomPane>
                    <x:ActivePane>2</x:ActivePane>
                </x:WorksheetOptions>
            </ss:Worksheet>
        </ss:Workbook>
    </xsl:template>
</xsl:stylesheet>