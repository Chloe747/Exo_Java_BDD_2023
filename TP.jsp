<%@page contentType="text/html" pageEncoding="UTF-8"%> <!-- Définit le type de contenu renvoyé (HTML) et l'encodage UTF-8 -->
<%@page import="java.util.List"%> <!-- Importe la classe List (interface pour les listes en Java) -->
<%@page import="java.util.ArrayList"%> <!-- Importe la classe ArrayList (implémentation concrète de List) -->
<%@page import="java.util.Date"%> <%-- NOUVEL IMPORT : permet de manipuler les dates (java.util.Date) --%>
<%@page import="java.text.SimpleDateFormat"%> <%-- NOUVEL IMPORT : permet de formater et parser les dates en texte --%>
<%@page import="java.text.ParseException"%> <%-- NOUVEL IMPORT : permet de gérer les erreurs de conversion de dates --%>

<%!

    // Définition de la classe interne "Task"
    public class Task {
        private static int idCounter = 0; // Compteur statique qui génère un ID unique pour chaque tâche créée
        private int id; // Identifiant unique de la tâche
        private String titre; // Titre de la tâche
        private Date dateEcheance; // Date d'échéance de la tâche
        private boolean terminee; // Indique si la tâche est terminée ou non (true = terminée)

        // Constructeur : appelé lors de la création d'une nouvelle tâche
        public Task(String titre, Date dateEcheance) {
            this.id = idCounter++; // Affecte un ID unique en incrémentant le compteur
            this.titre = titre; // Associe le titre transmis à l'attribut de la classe
            this.dateEcheance = dateEcheance; // Associe la date d’échéance à l’attribut correspondant
            this.terminee = false; // Par défaut, une tâche nouvellement créée n’est pas terminée
        }

        // Getter : renvoie l'ID de la tâche
        public int getId() { return id; }

        // Getter : renvoie le titre de la tâche
        public String getTitre() { return titre; }

        // Getter : renvoie la date d'échéance de la tâche
        public Date getDateEcheance() { return dateEcheance; }

        // Getter : renvoie l'état de la tâche (terminée ou non)
        public boolean isTerminee() { return terminee; }

        // Setter : permet de modifier l'état "terminée" d'une tâche
        public void setTerminee(boolean terminee) {
            this.terminee = terminee;
        }
    }
%>



<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> <!-- Définit l'encodage du document -->
    <title>Gestionnaire Tâches </title> <!-- Titre de l'onglet -->
</head>
<body>

    <h1>Mon Gestionnaire de Tâches</h1> <!-- Titre principal -->

    <%-- =============================
         FORMULAIRE D'AJOUT DE TÂCHE
       ============================= --%>
    <form  method="post" action="TP.jsp"> <!-- Formulaire envoyé vers cette même page -->
        <input type="hidden" name="action" value="add"> <!-- Indique qu'il s'agit d'une action "add" -->

        <div>
            <label for="titre">Titre de la tâche :</label> <!-- Étiquette du champ -->
            <input type="text" id="titre" name="titre" required> <!-- Champ texte obligatoire -->
        </div>

        <br>
        <input type="submit" value="Ajouter"> <!-- Bouton pour valider le formulaire -->
    </form>

    <hr> <!-- Ligne de séparation visuelle -->

    <h2>Mes Tâches</h2> <!-- Sous-titre -->

    <%-- =============================
         AFFICHAGE DE LA LISTE DE TÂCHES
       ============================= --%>
   <ul> <!-- Début de la liste HTML non ordonnée pour afficher les tâches -->
    <% 
        // Vérifie si la liste des tâches est vide
        if (taskTitles.isEmpty()) {
    %>
        <!-- Si la liste est vide, affiche un message -->
        <li>Vous n'avez aucune tâche.</li>
    <%
        } else {
            // Si la liste contient des tâches :
            // On utilise ici une boucle "for" avec un index numérique
            // afin de pouvoir récupérer la position (index) de chaque tâche dans la liste.
            for (int i = 0; i < taskTitles.size(); i++) {
    
                // Récupère le titre de la tâche actuelle à l'indice i
                String titreTache = taskTitles.get(i);
    %>
        <!-- Chaque tâche est affichée dans un élément de liste -->
        <li>
            <!-- Affiche le titre de la tâche -->
            <%= titreTache %>
    
            <%-- 
               Lien de suppression :
               - Il renvoie vers la même page "TP.jsp"
               - Il passe deux paramètres dans l'URL :
                   action=delete → indique qu'on veut supprimer
                   id=<%= i %>   → indique l'index de la tâche à supprimer
               Exemple de lien généré : TP.jsp?action=delete&id=0
            --%>
            <a href="TP.jsp?action=delete&id=<%= i %>">[Supprimer]</a>
        </li>
    <%
            } // Fin de la boucle for
        } // Fin du else
    %>
</ul> <!-- Fin de la liste HTML -->

</body>
</html>

