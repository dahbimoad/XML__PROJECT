<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
    xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
    xmlns:x="urn:schemas-microsoft-com:office:excel"
    xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
    xmlns:html="http://www.w3.org/TR/REC-html40"
    xmlns:emp="http://GINF2Emploi.org">

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />

    <xsl:template match="/">
        <Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
            xmlns:o="urn:schemas-microsoft-com:office:office"
            xmlns:x="urn:schemas-microsoft-com:office:excel"
            xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
            xmlns:html="http://www.w3.org/TR/REC-html40">

            <!-- Define cell styles -->
            <Styles>
                <Style ss:ID="HeaderCell">
                    <Borders>
                        <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
                        <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
                    </Borders>
                    <Interior ss:Color="#BFBFBF" ss:Pattern="Solid"/>
                </Style>
                <Style ss:ID="BodyCell">
                    <Borders>
                        <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
                        <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
                    </Borders>
                </Style>
            </Styles>

            <Worksheet ss:Name="Sheet1">
                <Table x:FullColumns="1" x:FullRows="1">
                    <!-- Add table header -->
                    <Row>
                        <Cell ss:StyleID="HeaderCell"><Data ss:Type="String">Time</Data></Cell>
                        <xsl:for-each select="//emp:Days/emp:day">
                            <Cell ss:StyleID="HeaderCell"><Data ss:Type="String"><xsl:value-of select="@name"/></Data></Cell>
                        </xsl:for-each>
                    </Row>

                    <!-- Generate table rows for each time -->
                    <xsl:for-each select="//emp:times/emp:time">
                        <Row>
                            <Cell ss:StyleID="BodyCell"><Data ss:Type="String"><xsl:value-of select="@t"/></Data></Cell>

                            <!-- Generate matiere cells for each day -->
                            <xsl:variable name="currentTime" select="@t"/>
                            <xsl:for-each select="//emp:Days/emp:day">
                                <xsl:variable name="currentDay" select="@name"/>
                                <xsl:variable name="matchingMatieres" select="//emp:matieres/emp:matiere[emp:jour = $currentDay and contains(emp:startTime, $currentTime)]"/>
                                <Cell ss:StyleID="BodyCell">
                                    <Data ss:Type="String">
                                        <!-- Check if there's a matching emp:matiere -->
                                        <xsl:for-each select="$matchingMatieres">
                                            <!-- Add content for matching condition -->
                                            <xsl:if test="emp:jour = $currentDay and contains(emp:startTime, $currentTime)">
                                                <xsl:value-of select="concat(emp:nom, ' - ', emp:nomProf, ' - ', emp:salle, ' - ',emp:type)"/>
                                                <xsl:text>&#10;</xsl:text> <!-- Line break after each matching matiere -->
                                            </xsl:if>
                                        </xsl:for-each>
                                    </Data>
                                </Cell>
                            </xsl:for-each>
                        </Row>
                    </xsl:for-each>

                </Table>
            </Worksheet>
        </Workbook>
    </xsl:template>
</xsl:stylesheet>
