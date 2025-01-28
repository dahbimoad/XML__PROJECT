package com.example.GestionScolarite.utils;

import java.nio.file.Paths;

public class ProjectPaths {
    // Base paths
    private static final String PROJECT_ROOT = System.getProperty("user.dir");
    private static final String RESOURCES_DIR = "src/main/resources";
    private static final String APP_PACKAGE = "com/example/gestionscolarite";

    // Resource directories
    private static final String XML_DIR = "xml";
    private static final String XSL_DIR = "xsl";
    private static final String XSLT_DIR = "xslt";
    private static final String OUTPUT_DIR = "output";

    // Get full resource base path
    public static String getResourceBasePath() {
        return Paths.get(PROJECT_ROOT, RESOURCES_DIR, APP_PACKAGE).toString();
    }

    // Get XML directory path
    public static String getXmlPath() {
        return Paths.get(getResourceBasePath(), XML_DIR).toString();
    }

    // Get XSL directory path
    public static String getXslPath() {
        return Paths.get(getResourceBasePath(), XSL_DIR).toString();
    }

    // Get XSLT directory path
    public static String getXsltPath() {
        return Paths.get(getResourceBasePath(), XSLT_DIR).toString();
    }

    // Get output directory path
    public static String getOutputPath() {
        return Paths.get(PROJECT_ROOT, OUTPUT_DIR).toString();
    }

    // Debug method to print all paths
    public static void printPaths() {
        System.out.println("=== Project Paths ===");
        System.out.println("Project Root: " + PROJECT_ROOT);
        System.out.println("Resource Base: " + getResourceBasePath());
        System.out.println("XML Directory: " + getXmlPath());
        System.out.println("XSL Directory: " + getXslPath());
        System.out.println("XSLT Directory: " + getXsltPath());
        System.out.println("Output Directory: " + getOutputPath());
    }
}