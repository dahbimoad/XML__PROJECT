module com.example.demo1 {
    requires javafx.controls;
    requires javafx.fxml;
    requires java.xml;
    requires fop;



    opens com.example.GestionScolarite to javafx.fxml;
    exports com.example.GestionScolarite;
    exports com.example.GestionScolarite.services;
    opens com.example.GestionScolarite.services to javafx.fxml;
    exports com.example.GestionScolarite.controllers;
    opens com.example.GestionScolarite.controllers to javafx.fxml;
}