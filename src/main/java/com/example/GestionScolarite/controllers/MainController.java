package com.example.GestionScolarite.controllers;

import com.example.GestionScolarite.models.Module;
import com.example.GestionScolarite.models.Student;
import com.example.GestionScolarite.services.DocumentGenerationService;
import com.example.GestionScolarite.utils.AlertUtil;
import com.example.GestionScolarite.utils.PathResolver;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.FilteredList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.input.Clipboard;
import javafx.scene.input.ClipboardContent;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamSource;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.HashSet;
import java.util.Set;

public class MainController {
    @FXML private TextField CarteCne;
    @FXML private TextField ReuCne;
    @FXML private TextField InscCne;
    @FXML private CheckBox pdfinsc;
    @FXML private CheckBox htmlinsc;
    @FXML private CheckBox pdfreu;
    @FXML private CheckBox htmlreu;
    @FXML private CheckBox pdfcarte;
    @FXML private CheckBox htmlcarte;
    @FXML private CheckBox tousmod;
    @FXML private CheckBox unseulmod;
    @FXML private TextField CodeModule;
    @FXML private CheckBox EDTHTMLChoice;
    @FXML private CheckBox EDTPDFChoice;
    @FXML private CheckBox EDTExcelChoice;
    @FXML private CheckBox AffichageNotes;
    @FXML private CheckBox StudentAffichage;
    @FXML private TextField AffichageCne;
     @FXML private TableView<Student> studentTable;
    @FXML private TableColumn<Student, String> cneColumn;
    @FXML private TableColumn<Student, String> firstNameColumn;
    @FXML private TableColumn<Student, String> lastNameColumn;

    @FXML private TableView<Module> moduleTable;
    @FXML private TableColumn<Module, String> codeColumn;
    @FXML private TableColumn<Module, String> nameColumn;

    @FXML private TextField studentSearchField;
    @FXML private TextField moduleSearchField;

    private ObservableList<Student> students = FXCollections.observableArrayList();
    private ObservableList<Module> modules = FXCollections.observableArrayList();
    private FilteredList<Student> filteredStudents;
    private FilteredList<Module> filteredModules;

    private final DocumentGenerationService documentService;
    private final PathResolver pathResolver;


    public MainController() {
        this.documentService = new DocumentGenerationService();
        this.pathResolver = new PathResolver();
    }
    @FXML
    public void initialize() {
        setupStudentTable();
        setupModuleTable();
        loadStudentData();
        loadModuleData();
        setupSearch();
        setupContextMenus();
    }
    private void setupStudentTable() {
    if (cneColumn != null) {
        cneColumn.setCellValueFactory(data -> data.getValue().cneProperty());
    }
    if (firstNameColumn != null) {
        firstNameColumn.setCellValueFactory(data -> data.getValue().firstNameProperty());
    }
    if (lastNameColumn != null) {
        lastNameColumn.setCellValueFactory(data -> data.getValue().lastNameProperty());
    }

    filteredStudents = new FilteredList<>(students, p -> true);
    if (studentTable != null) {
        studentTable.setItems(filteredStudents);
    }
}

    private void setupModuleTable() {
        codeColumn.setCellValueFactory(data -> data.getValue().codeProperty());
        nameColumn.setCellValueFactory(data -> data.getValue().nameProperty());

        filteredModules = new FilteredList<>(modules, p -> true);
        moduleTable.setItems(filteredModules);
    }

    private void setupSearch() {
        studentSearchField.textProperty().addListener((observable, oldValue, newValue) -> {
            filteredStudents.setPredicate(student -> {
                if (newValue == null || newValue.isEmpty()) {
                    return true;
                }
                String lowerCaseFilter = newValue.toLowerCase();
                return student.getCne().toLowerCase().contains(lowerCaseFilter) ||
                       student.getFirstName().toLowerCase().contains(lowerCaseFilter) ||
                       student.getLastName().toLowerCase().contains(lowerCaseFilter);
            });
        });

        moduleSearchField.textProperty().addListener((observable, oldValue, newValue) -> {
            filteredModules.setPredicate(module -> {
                if (newValue == null || newValue.isEmpty()) {
                    return true;
                }
                String lowerCaseFilter = newValue.toLowerCase();
                return module.getCode().toLowerCase().contains(lowerCaseFilter) ||
                       module.getName().toLowerCase().contains(lowerCaseFilter);
            });
        });
    }

    private void loadStudentData() {
        try {
            String xmlPath = pathResolver.getResourcePath("etudiants.xml");
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(xmlPath);
            doc.getDocumentElement().normalize();

            NodeList nList = doc.getElementsByTagName("Etudiant");

            for (int i = 0; i < nList.getLength(); i++) {
                Element element = (Element) nList.item(i);
                String cne = element.getAttribute("CNE");
                if (cne != null && !cne.isEmpty()) {
                    String firstName = getElementContent(element, "firstName");
                    String lastName = getElementContent(element, "lastName");
                    students.add(new Student(cne, firstName, lastName));
                }
            }
        } catch (Exception e) {
            AlertUtil.showErrorAlert("Error", "Failed to load student data: " + e.getMessage());
        }
    }

    private void loadModuleData() {
        try {
            String xmlPath = pathResolver.getResourcePath("S3S4notessmall.xml");
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(xmlPath);
            doc.getDocumentElement().normalize();

            NodeList moduleList = doc.getElementsByTagName("module");
            Set<String> addedModules = new HashSet<>();

            for (int i = 0; i < moduleList.getLength(); i++) {
                Element element = (Element) moduleList.item(i);
                String code = element.getAttribute("code");

                if (code != null && !code.isEmpty() && !addedModules.contains(code)) {
                    NodeList matiereList = element.getElementsByTagName("matiere");
                    if (matiereList.getLength() > 0) {
                        Element matiere = (Element) matiereList.item(0);
                        String name = matiere.getAttribute("Nom");
                        modules.add(new Module(code, name));
                        addedModules.add(code);
                    }
                }
            }
        } catch (Exception e) {
            AlertUtil.showErrorAlert("Error", "Failed to load module data: " + e.getMessage());
        }
    }

    private String getElementContent(Element element, String tagName) {
        NodeList nodeList = element.getElementsByTagName(tagName);
        if (nodeList != null && nodeList.getLength() > 0) {
            return nodeList.item(0).getTextContent();
        }
        return "";
    }

    @FXML
    public void HandleGeneration() {
        if (EDTHTMLChoice.isSelected()) {
            handleGenerateHTML();
        }
        if (EDTPDFChoice.isSelected()) {
            handleGeneratePDF();
        }
        if (EDTExcelChoice.isSelected()) {
            handleGenerateExcel();
        }
    }

    private void handleGeneratePDF() {
        AlertUtil.showPDFAlert("Generation du PDF en cours...");
        try {
            String xmlFile = "EDT.xml";
            String xslFile = "EDT.xsl";
            String outputFile = "/EDT/EDT.pdf";

            String xmlPath = pathResolver.getResourcePath(xmlFile);
            String xslPath = pathResolver.getResourcePath(xslFile);
            String outputPath = pathResolver.getOutputPath("pdf" + outputFile);

            documentService.generatePDF(xmlPath, xslPath, outputPath, null, null);
            AlertUtil.showSuccessAlert("Succès", "PDF généré avec succès");
        } catch (Exception e) {
            AlertUtil.showErrorAlert("Erreur de génération PDF", e.getMessage());
        }
    }

    private void handleGenerateHTML() {
        AlertUtil.showHTMLAlert("Génération HTML en cours...");
        try {
            String xmlFile = "EDT.xml";
            String xsltFile = "EDT.xslt";
            String outputFile = "/EDT/EDT.html";

            String xmlPath = pathResolver.getResourcePath(xmlFile);
            String xsltPath = pathResolver.getResourcePath(xsltFile);
            String outputPath = pathResolver.getOutputPath("html" + outputFile);

            documentService.generateHTML(xmlPath, xsltPath, outputPath, null, null);
            AlertUtil.showSuccessAlert("Succès", "HTML généré avec succès");
        } catch (Exception e) {
            AlertUtil.showErrorAlert("Erreur de génération HTML", e.getMessage());
        }
    }

    private void handleGenerateExcel() {
        AlertUtil.showExcelAlert("Génération Excel en cours...");
        try {
            String xmlFile = "EDT.xml";
            String xsltFile = "EDT_Excel.xslt";
            String outputFile = "/EDT/EDT.xls";

            String xmlPath = pathResolver.getResourcePath(xmlFile);
            String xsltPath = pathResolver.getResourcePath(xsltFile);
            String outputPath = pathResolver.getOutputPath("excel" + outputFile);

            documentService.generateExcel(xmlPath, xsltPath, outputPath);
            AlertUtil.showSuccessAlert("Succès", "Excel généré avec succès");
        } catch (Exception e) {
            AlertUtil.showErrorAlert("Erreur de génération Excel", e.getMessage());
        }
    }

    @FXML
    private void HandleAffichage() {
    try {
        if (AffichageNotes.isSelected()) {
            generateClassNotes();
        }
        if (StudentAffichage.isSelected()) {
            generateStudentNotes();
        }
    } catch (Exception e) {
        e.printStackTrace(); // Add stack trace for debugging
        AlertUtil.showErrorAlert("Erreur d'affichage", e.getMessage());
    }
}

    private void generateClassNotes() {
    try {
        // Debug prints to verify paths
        System.out.println("Starting generateClassNotes");

        String xmlFile = "etudiants.xml";
        String xsltFile = "AffichageParEtu.xslt";
        String outputFile = "/notes/AffichageClasse.html";

        // Get absolute paths using PathResolver
        String xmlPath = pathResolver.getResourcePath(xmlFile);
        String xsltPath = pathResolver.getResourcePath(xsltFile);
        String outputPath = pathResolver.getOutputPath("html" + outputFile);

        // Debug prints
        System.out.println("XML Path: " + xmlPath);
        System.out.println("XSLT Path: " + xsltPath);
        System.out.println("Output Path: " + outputPath);

        // Verify file existence
        if (!new File(xmlPath).exists()) {
            throw new FileNotFoundException("XML file not found: " + xmlPath);
        }
        if (!new File(xsltPath).exists()) {
            throw new FileNotFoundException("XSLT file not found: " + xsltPath);
        }

        documentService.generateHTML(xmlPath, xsltPath, outputPath, null, null);
        AlertUtil.showSuccessAlert("Succès", "Notes de classe générées avec succès");
    } catch (Exception e) {
        e.printStackTrace(); // Add stack trace for debugging
        AlertUtil.showErrorAlert("Erreur de génération des notes", "Détail: " + e.getMessage());
    }
}

    private void generateStudentNotes() {
    String cne = AffichageCne.getText();
    if (cne.isEmpty()) {
        AlertUtil.showErrorAlert("Erreur", "Veuillez saisir un CNE");
        return;
    }

    try {
        // Debug prints to verify paths
        System.out.println("Starting generateStudentNotes for CNE: " + cne);

        String xmlFile = "etudiants.xml";
        String xsltFile = "AffichageParEtu.xslt";
        String outputFile = "/notes/" + cne + "_notes.html";

        // Get absolute paths using PathResolver
        String xmlPath = pathResolver.getResourcePath(xmlFile);
        String xsltPath = pathResolver.getResourcePath(xsltFile);
        String outputPath = pathResolver.getOutputPath("html" + outputFile);

        // Debug prints
        System.out.println("XML Path: " + xmlPath);
        System.out.println("XSLT Path: " + xsltPath);
        System.out.println("Output Path: " + outputPath);

        // Verify file existence
        if (!new File(xmlPath).exists()) {
            throw new FileNotFoundException("XML file not found: " + xmlPath);
        }
        if (!new File(xsltPath).exists()) {
            throw new FileNotFoundException("XSLT file not found: " + xsltPath);
        }

        documentService.generateHTML(xmlPath, xsltPath, outputPath, "studentCNE", cne);
        AlertUtil.showSuccessAlert("Succès", "Notes de l'étudiant générées avec succès");
    } catch (Exception e) {
        e.printStackTrace(); // Add stack trace for debugging
        AlertUtil.showErrorAlert("Erreur de génération des notes", "Détail: " + e.getMessage());
    }
}

    @FXML
    public void GenererReu(ActionEvent actionEvent) {
        String cne = ReuCne.getText();
        if (cne.isEmpty()) {
            AlertUtil.showErrorAlert("Erreur", "Veuillez saisir un CNE");
            return;
        }

        try {
            String xmlFile = "etudiants.xml";
            String xmlPath = pathResolver.getResourcePath(xmlFile);

            if (pdfreu.isSelected()) {
                String xslFile = "Attestation_reu_pdf.xsl";
                String xslPath = pathResolver.getResourcePath(xslFile);
                String outputPath = pathResolver.getOutputPath("pdf/reussite/" + cne + "_attestation.pdf");
                documentService.generatePDF(xmlPath, xslPath, outputPath, "cne", cne);
            }

            if (htmlreu.isSelected()) {
                String xsltFile = "AttestationReus.xslt";
                String xsltPath = pathResolver.getResourcePath(xsltFile);
                String outputPath = pathResolver.getOutputPath("html/reussite/" + cne + "_attestation.html");
                documentService.generateHTML(xmlPath, xsltPath, outputPath, "cne", cne);
            }

            AlertUtil.showSuccessAlert("Succès", "Attestation de réussite générée avec succès");
        } catch (Exception e) {
            AlertUtil.showErrorAlert("Erreur de génération de l'attestation", e.getMessage());
        }
    }

    @FXML
    public void GenererInsc(ActionEvent actionEvent) {
        String cne = InscCne.getText();
        if (cne.isEmpty()) {
            AlertUtil.showErrorAlert("Erreur", "Veuillez saisir un CNE");
            return;
        }

        try {
            String xmlFile = "etudiants.xml";
            String xmlPath = pathResolver.getResourcePath(xmlFile);

            if (pdfinsc.isSelected()) {
                String xslFile = "Attestation_ins_pdf.xsl";
                String xslPath = pathResolver.getResourcePath(xslFile);
                String outputPath = pathResolver.getOutputPath("pdf/inscription/" + cne + "_inscription.pdf");
                documentService.generatePDF(xmlPath, xslPath, outputPath, "cne", cne);
            }

            if (htmlinsc.isSelected()) {
                String xsltFile = "AttestationInsc.xslt";
                String xsltPath = pathResolver.getResourcePath(xsltFile);
                String outputPath = pathResolver.getOutputPath("html/inscription/" + cne + "_inscription.html");
                documentService.generateHTML(xmlPath, xsltPath, outputPath, "cne", cne);
            }

            AlertUtil.showSuccessAlert("Succès", "Attestation d'inscription générée avec succès");
        } catch (Exception e) {
            AlertUtil.showErrorAlert("Erreur de génération de l'attestation", e.getMessage());
        }
    }

    @FXML
    public void GenererCarte(ActionEvent actionEvent) {
        String cne = CarteCne.getText();
        if (cne.isEmpty()) {
            AlertUtil.showErrorAlert("Erreur", "Veuillez saisir un CNE");
            return;
        }

        try {
            String xmlFile = "etudiants.xml";
            String xmlPath = pathResolver.getResourcePath(xmlFile);

            if (pdfcarte.isSelected()) {
                String xslFile = "Carte_Etudiant.xsl";
                String xslPath = pathResolver.getResourcePath(xslFile);
                String outputPath = pathResolver.getOutputPath("pdf/cartes/" + cne + "_carte.pdf");
                documentService.generatePDF(xmlPath, xslPath, outputPath, "cne", cne);
            }

            if (htmlcarte.isSelected()) {
                String xsltFile = "CarteEtudiantxslt.xslt";
                String xsltPath = pathResolver.getResourcePath(xsltFile);
                String outputPath = pathResolver.getOutputPath("html/cartes/" + cne + "_carte.html");
                documentService.generateHTML(xmlPath, xsltPath, outputPath, "cne", cne);
            }

            AlertUtil.showSuccessAlert("Succès", "Carte d'étudiant générée avec succès");
        } catch (Exception e) {
            AlertUtil.showErrorAlert("Erreur de génération de la carte", e.getMessage());
        }
    }

@FXML
public void AffichageMod(ActionEvent actionEvent) {
    try {
        // Use S3S4notessmall.xml as the main XML file since it has all the module data
        String xmlFile = "Modules.xml";
        String xsltFile = "AffichageParModule.xslt";

        // Get absolute paths
        String xmlPath = pathResolver.getResourcePath(xmlFile);
        String xsltPath = pathResolver.getResourcePath(xsltFile);

        System.out.println("XML Path: " + xmlPath);
        System.out.println("XSLT Path: " + xsltPath);

        // Create transformer factory
        TransformerFactory transformerFactory = TransformerFactory.newInstance();

        // Set the URI resolver to handle document() function calls
        transformerFactory.setURIResolver((href, base) -> {
            String resolvedPath;
            if (href.contains("etudiants.xml")) {
                resolvedPath = pathResolver.getResourcePath("etudiants.xml");
            } else if (href.contains("modules.xml")) {
                resolvedPath = pathResolver.getResourcePath("Modules.xml");
            } else if (href.contains("S3S4notessmall.xml")) {
                resolvedPath = pathResolver.getResourcePath("S3S4notessmall.xml");
            } else {
                return null;
            }
            return new StreamSource(new File(resolvedPath));
        });

        if (tousmod.isSelected()) {
            String outputPath = pathResolver.getOutputPath("html/modules/AffichageModules.html");
            System.out.println("Output Path (all modules): " + outputPath);

            documentService.generateHTML(xmlPath, xsltPath, outputPath, null, null);
            AlertUtil.showSuccessAlert("Succès", "Affichage des modules généré avec succès");
        }

        if (unseulmod.isSelected()) {
            String code = CodeModule.getText();
            if (code.isEmpty()) {
                AlertUtil.showErrorAlert("Erreur", "Veuillez saisir un code module");
                return;
            }

            String outputPath = pathResolver.getOutputPath("html/modules/" + code + "_module.html");
            System.out.println("Output Path (single module): " + outputPath);
            System.out.println("Module Code: " + code);

            documentService.generateHTML(xmlPath, xsltPath, outputPath, "codeModu", code);
            AlertUtil.showSuccessAlert("Succès", "Affichage du module généré avec succès");
        }
    } catch (Exception e) {
        e.printStackTrace();  // Print full stack trace for debugging
        AlertUtil.showErrorAlert("Erreur d'affichage des modules", "Détail: " + e.getMessage());
    }
}
private void setupContextMenus() {
    // Setup context menu for student table
    ContextMenu studentContextMenu = new ContextMenu();
    MenuItem copyStudentCNE = new MenuItem("Copier CNE");
    copyStudentCNE.setOnAction(event -> {
        Student selectedStudent = studentTable.getSelectionModel().getSelectedItem();
        if (selectedStudent != null) {
            copyToClipboard(selectedStudent.getCne());
            AlertUtil.showSuccessAlert("Copié!", "CNE copié dans le presse-papiers");
        }
    });
    studentContextMenu.getItems().add(copyStudentCNE);

    studentTable.setContextMenu(studentContextMenu);

    // Setup context menu for module table
    ContextMenu moduleContextMenu = new ContextMenu();
    MenuItem copyModuleCode = new MenuItem("Copier Code");
    copyModuleCode.setOnAction(event -> {
        Module selectedModule = moduleTable.getSelectionModel().getSelectedItem();
        if (selectedModule != null) {
            copyToClipboard(selectedModule.getCode());
            AlertUtil.showSuccessAlert("Copié!", "Code module copié dans le presse-papiers");
        }
    });
    moduleContextMenu.getItems().add(copyModuleCode);

    moduleTable.setContextMenu(moduleContextMenu);
}

// Add this helper method to your class
private void copyToClipboard(String text) {
    final Clipboard clipboard = Clipboard.getSystemClipboard();
    final ClipboardContent content = new ClipboardContent();
    content.putString(text);
    clipboard.setContent(content);
}
}