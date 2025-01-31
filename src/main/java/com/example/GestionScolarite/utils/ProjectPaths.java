package com.example.GestionScolarite.utils;

import java.nio.file.Path;
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
        Path path = Paths.get(PROJECT_ROOT, RESOURCES_DIR, APP_PACKAGE);
        ensureDirectoryExists(path);
        return path.toString();
    }

    // Get XML directory path
    public static String getXmlPath() {
        Path path = Paths.get(getResourceBasePath(), XML_DIR);
        ensureDirectoryExists(path);
        return path.toString();
    }

    // Get XSL directory path
    public static String getXslPath() {
        Path path = Paths.get(getResourceBasePath(), XSL_DIR);
        ensureDirectoryExists(path);
        return path.toString();
    }

    // Get XSLT directory path
    public static String getXsltPath() {
        Path path = Paths.get(getResourceBasePath(), XSLT_DIR);
        ensureDirectoryExists(path);
        return path.toString();
    }

    // Get output directory path
    public static String getOutputPath() {
        Path path = Paths.get(PROJECT_ROOT, OUTPUT_DIR);
        ensureDirectoryExists(path);
        return path.toString();
    }

    // Ensure directory exists
    private static void ensureDirectoryExists(Path path) {
        if (!path.toFile().exists()) {
            path.toFile().mkdirs();
        }
    }
}