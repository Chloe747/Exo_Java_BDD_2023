<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>Gestion de taches</title>
</head>
<body bgcolor=white>
<h1>Gestionnaire de taches</h1>


<%
  class Tache {
    String titre; 
    String description; 
  
  
    public Tache(String titre, String descritpion){
      this.titre = titre; 
      this.descritpion = description;
  
    public String getTitre() { return titre; }
    public String gestDescrition() { return descritpion; }

%>



  
