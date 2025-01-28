package com.example.GestionScolarite.utils;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class PathResolver {

    public String getResourcePath(String filename) {
        try {
            String directory;
            if (filename.endsWith(".xml")) {
                directory = ProjectPaths.getXmlPath();
            } else if (filename.endsWith(".xsl")) {
                directory = ProjectPaths.getXslPath();
            } else if (filename.endsWith(".xslt")) {
                directory = ProjectPaths.getXsltPath();
            } else {
                directory = ProjectPaths.getResourceBasePath();
            }

            Path fullPath = Paths.get(directory, filename);
            System.out.println("Resolved path: " + fullPath);

            // Validate path exists
            if (!Files.exists(fullPath)) {
                System.out.println("Warning: File not found at " + fullPath);
            }

            return fullPath.toString();
        } catch (Exception e) {
            throw new RuntimeException("Failed to resolve resource path for: " + filename, e);
        }
    }

    public String getOutputPath(String relativePath) {
        try {
            Path path = Paths.get(ProjectPaths.getOutputPath(), relativePath);
            ensureDirectoryExists(path.getParent());
            return path.toString();
        } catch (Exception e) {
            throw new RuntimeException("Failed to resolve output path: " + relativePath, e);
        }
    }

    private void ensureDirectoryExists(Path directory) {
        if (directory != null && !Files.exists(directory)) {
            try {
                Files.createDirectories(directory);
                System.out.println("Created directory: " + directory);
            } catch (IOException e) {
                throw new RuntimeException("Failed to create directory: " + directory, e);
            }
        }
    }
}