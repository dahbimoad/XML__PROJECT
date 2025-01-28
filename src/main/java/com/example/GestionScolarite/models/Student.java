package com.example.GestionScolarite.models;

import javafx.beans.property.SimpleStringProperty;

public class Student {
    private final SimpleStringProperty cne;
    private final SimpleStringProperty firstName;
    private final SimpleStringProperty lastName;

    public Student(String cne, String firstName, String lastName) {
        this.cne = new SimpleStringProperty(cne);
        this.firstName = new SimpleStringProperty(firstName);
        this.lastName = new SimpleStringProperty(lastName);
    }

    public String getCne() { return cne.get(); }
    public String getFirstName() { return firstName.get(); }
    public String getLastName() { return lastName.get(); }

    public SimpleStringProperty cneProperty() { return cne; }
    public SimpleStringProperty firstNameProperty() { return firstName; }
    public SimpleStringProperty lastNameProperty() { return lastName; }
}
