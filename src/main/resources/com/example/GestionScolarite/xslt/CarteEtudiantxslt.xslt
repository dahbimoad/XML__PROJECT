<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:param name="cne"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <style type="text/css">
                    /* Add your CSS styles here */
                    body {
                    font-family: Arial, Helvetica, sans-serif;
                    margin: 0;
                    padding: 0;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 50%;
                    }
                    
                    /* Style the outer container */
                    .card-container {
                    width: 20%;
                    border: 1px solid #031599;
                    padding: 10px;
                    box-sizing: border-box;
                    text-align: center;
                    background: url('../images/background.jpg') no-repeat center center fixed; 
                    }
                    
                    .left-content, .right-content {
                    flex: 1;
                    }
                    
                    /* Add more styles as needed */
                </style>
            </head>
            <body>
                <div class="card-container">
                    
                    <div class="center-content">
                        <table style="font-size: 9px;width: 100%;">
                            <tr>
                                <td style="text-align: left;">
                                    <img src="../images/ensa_tanger.png" height="40" width="60"/>
                        </td>
                                <td style="text-align: center;">
                         <p>Royaume Du Maroc</p>
                        <p>Université Abdelmalek Essadi</p>
                        <p>Ecole nationale des sciences appliquées de Tanger</p>
                    </td>
                                <td style="text-align: right;">
                                    <img src="../images/logoUAE.png" height="50" width="30"/>
                       </td>
                        
                        </tr></table>
                        <hr style="border-bottom-width: 1px; width: auto; border-bottom-style: solid; border-color: #031599;"/>
                        <p style="font-size: 9px; font-weight: bold;">Carte d'Étudiant</p>
                        <table style="width: 100%;">
                            <tr>
                                <td style="width: 25%; padding-left: 5mm;">
                                    <img src="../images/Unknown_person.jpg" height="100" width="80"/>
                                </td>
                                <td style="width: 50%; text-align: left; vertical-align: top; font-size: 11px;">
                                    <p>Prénom: <xsl:value-of select="/Etudiants/Etudiant[@CNE=$cne]/firstName"/></p>
                                    <p>Nom: <xsl:value-of select="/Etudiants/Etudiant[@CNE=$cne]/lastName"/></p>
                                    <p>CNE: <xsl:value-of select="Etudiants/Etudiant[@CNE=$cne]/@CNE"/></p>
                                    <p>Naissance: <xsl:value-of select="/Etudiants/Etudiant[@CNE=$cne]/Naissance"/></p>
                                </td>
                                <td style="text-align: right;">
                                    <img src="../images/qr_code.jpg" height="80" width="80"/>
                                </td>
                            </tr>
                        </table>
                        <p style="font-size: 10px;">Année universitaire 2023-2024</p>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
