package com.example.GestionScolarite.services;

import org.apache.fop.apps.FOUserAgent;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.MimeConstants;

import javax.xml.transform.*;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.*;

public class DocumentGenerationService {

    private static final String config = "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n" +
            "<fop>\n" +
            "  <renderers>\n" +
            "    <renderer mime=\"application/pdf\">\n" +
            "      <fonts>\n" +
            "        <auto-detect/>\n" +
            "      </fonts>\n" +
            "    </renderer>\n" +
            "  </renderers>\n" +
            "</fop>";

    public void generatePDF(String inputXML, String xsltFile, String outputPDF, String paramName, String paramValue) throws Exception {
        // Set up the XSLT transformation
        TransformerFactory transformerFactory = TransformerFactory.newInstance();
        StreamSource xsltStreamSource = new StreamSource(new File(xsltFile));
        Transformer transformer = transformerFactory.newTransformer(xsltStreamSource);

        // Set parameter if provided
        if (paramName != null && paramValue != null) {
            transformer.setParameter(paramName, paramValue);
        }

        InputStream configSource = new ByteArrayInputStream(config.getBytes());
        // Set up the FOP processor
        FopFactory fopFactory = FopFactory.newInstance(new File(".").toURI(), configSource);
        FOUserAgent foUserAgent = fopFactory.newFOUserAgent();

        // Set up the output stream for the PDF
        try (OutputStream out = new FileOutputStream(outputPDF)) {
            Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, foUserAgent, out);
            Result res = new SAXResult(fop.getDefaultHandler());
            transformer.transform(new StreamSource(new File(inputXML)), res);
        }
    }

    public void generateHTML(String xmlPath, String xsltPath, String outputPath, String paramName, String paramValue) throws TransformerException {
    try {
        // Create transformer factory
        TransformerFactory transformerFactory = TransformerFactory.newInstance();

        // Set security properties to allow access to external files
        System.setProperty("javax.xml.transform.TransformerFactory", "com.sun.org.apache.xalan.internal.xsltc.trax.TransformerFactoryImpl");
        System.setProperty("javax.xml.accessExternalDTD", "all");
        System.setProperty("javax.xml.accessExternalStylesheet", "all");
        System.setProperty("javax.xml.accessExternalSchema", "all");

        // Get the base directory for resolving relative paths
        File xsltFile = new File(xsltPath);
        String baseDir = xsltFile.getParent();

        // Set up URI resolver for document() function
        transformerFactory.setURIResolver((href, base) -> {
            try {
                String resolvedPath;
                if (href.contains("etudiants.xml") || href.contains("Modules.xml") || href.contains("S3S4notessmall.xml")) {
                    resolvedPath = new File(baseDir, "../xml/" + href).getCanonicalPath();
                    System.out.println("Resolving document() href: " + href + " to: " + resolvedPath);
                    return new StreamSource(new File(resolvedPath));
                }
                return null;
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        });

        // Create XSLT transformer
        StreamSource xsltSource = new StreamSource(new File(xsltPath));
        Transformer transformer = transformerFactory.newTransformer(xsltSource);

        // Set parameter if provided
        if (paramName != null && paramValue != null) {
            transformer.setParameter(paramName, paramValue);
            System.out.println("Setting parameter: " + paramName + " = " + paramValue);
        }

        // Set up input and output
        StreamSource xmlSource = new StreamSource(new File(xmlPath));

        // Ensure output directory exists
        File outputFile = new File(outputPath);
        outputFile.getParentFile().mkdirs();

        // Create output stream
        StreamResult htmlOutput = new StreamResult(outputFile);

        // Perform transformation
        transformer.transform(xmlSource, htmlOutput);
        System.out.println("Transformation completed successfully");

    } catch (TransformerException e) {
        System.err.println("Transformation failed: " + e.getMessage());
        e.printStackTrace();
        throw e;
    }
}

    public void generateExcel(String xmlPath, String xsltPath, String outputPath) throws IOException, TransformerException {
        try (FileOutputStream excelOutput = new FileOutputStream(outputPath)) {
            // Source XML file
            Source xmlInput = new StreamSource(xmlPath);

            // XSLT file
            Source xslt = new StreamSource(xsltPath);

            // Create a transformer factory
            TransformerFactory transformerFactory = TransformerFactory.newInstance();

            // Create transformer for XSLT
            Transformer transformer = transformerFactory.newTransformer(xslt);

            // Perform transformation
            transformer.transform(xmlInput, new StreamResult(excelOutput));
        }
    }
}