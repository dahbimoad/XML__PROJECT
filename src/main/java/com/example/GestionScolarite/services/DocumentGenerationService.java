package com.example.GestionScolarite.services;

import org.apache.fop.apps.*;
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
        // Source XML file
        Source xmlInput = new StreamSource(xmlPath);

        // XSLT file
        Source xslt = new StreamSource(xsltPath);

        // Output HTML file
        Result htmlOutput = new StreamResult(outputPath);

        // Create a transformer factory
        TransformerFactory transformerFactory = TransformerFactory.newInstance();

        // Create transformer for XSLT
        Transformer transformer = transformerFactory.newTransformer(xslt);

        // Set parameter if provided
        if (paramName != null && paramValue != null) {
            transformer.setParameter(paramName, paramValue);
        }

        // Perform the transformation
        transformer.transform(xmlInput, htmlOutput);
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