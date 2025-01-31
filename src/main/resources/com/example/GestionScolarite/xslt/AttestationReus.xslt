<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:java="java">
    <xsl:output method="html" indent="yes"/>
    
    <xsl:param name="cne"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Class Results</title>
                <link href="C:/XML__PROJECT/src/main/resources/com/example/GestionScolarite/css/stylesHTML.css" rel="stylesheet" type="text/css"/>
                <style type="text/css">
                    .text-align-left {
                    text-align: left;
                    max-width: 100%;
                    width: auto; 
                    justify-content:left;
                    }
                </style>
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
                
                
                    <h2><u>ATTESTATION DE REUSSITE</u></h2>
                    <div class="text-align-left">
                    <p>
                        Le Directeur de l'Ecole Nationale des Sciences Appliquées de Tanger atteste que
                    </p>
                    <p>
                        <xsl:variable name="full_name" select="concat(/Etudiants/Etudiant[@CNE=$cne]/lastName, ' ', Etudiants/Etudiant[@CNE=$cne]/firstName)"/>
                        Mr/Mme : <xsl:value-of select="$full_name"/> 
                    </p>
                    <p>
                        né le <xsl:value-of select="/Etudiants/Etudiant[@CNE=$cne]/Naissance"/> à <xsl:value-of select="/Etudiants/Etudiant[@CNE=$cne]/Ville"/> ( Maroc )
                    </p>
                    <p>
                        a été déclaré admis(e) au niveau : GINF-2, au titre de l'année universitaire 2023/2024
                    </p>
                    </div>
                    <p>
                        Fait à Tanger le <xsl:value-of select="java:util.Date.new()"/>
                    </p>
                                    <p>
                        Directeur de l'Ensa De Tanger
                    </p>
                    
                    <p>
                        Avis important: Le présent document n'est délivré qu'en un seul exemplaire.
                        Il appartient à l'étudiant d'en faire des photocopies certifiées conformes.
                    </p>
                

                <p>-------------------------------------------------------------------------------------------------------------</p>
                <div style="text-align:center;">
                    <div class="footer-item">N° Téléphone : +212 5 39 39 37 44</div>
                    <div class="footer-item">Fax: 05-39-39-37-43</div>
                    <div class="footer-item">Adresse: Ecole Nationale des Sciences Appliquées de Tanger BP 1818 - 90000s</div>
                    <div class="footer-item email" style="clear:both;">Contact : info@ensat.ac.ma</div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
