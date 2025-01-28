package com.example.GestionScolarite.models;

import javafx.beans.property.SimpleStringProperty;

public class Module {
    private final SimpleStringProperty code;
    private final SimpleStringProperty name;

    public Module(String code, String name) {
        this.code = new SimpleStringProperty(code);
        this.name = new SimpleStringProperty(name);
    }

    public String getCode() { return code.get(); }
    public String getName() { return name.get(); }

    public SimpleStringProperty codeProperty() { return code; }
    public SimpleStringProperty nameProperty() { return name; }
}