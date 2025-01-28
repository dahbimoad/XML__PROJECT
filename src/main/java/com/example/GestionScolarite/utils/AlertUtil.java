package com.example.GestionScolarite.utils;

import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;

public class AlertUtil {

    public static void showPDFAlert(String message) {
        showAlert(AlertType.INFORMATION, "PDF Generation", message);
    }

    public static void showHTMLAlert(String message) {
        showAlert(AlertType.INFORMATION, "HTML Generation", message);
    }

    public static void showExcelAlert(String message) {
        showAlert(AlertType.INFORMATION, "Excel Generation", message);
    }

    public static void showAffichageAlert(String message) {
        showAlert(AlertType.INFORMATION, "Affichage", message);
    }

    public static void showErrorAlert(String title, String message) {
        showAlert(AlertType.ERROR, title, message);
    }

    public static void showSuccessAlert(String title, String message) {
        showAlert(AlertType.INFORMATION, title, message);
    }

    private static void showAlert(AlertType alertType, String title, String message) {
        Alert alert = new Alert(alertType);
        alert.setTitle(title);
        alert.setHeaderText(null);
        alert.setContentText(message);
        alert.showAndWait();
    }
}