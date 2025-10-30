<%@page contentType="text/html" pageEncoding="UTF-8"%> <!-- Définit le type de contenu (HTML) et l'encodage UTF-8 -->
<%@page import="java.util.List"%> <!-- Importe la classe List de Java -->
<%@page import="java.util.ArrayList"%> <!-- Importe la classe ArrayList de Java -->

<%

    // Récupère la liste des tâches depuis la session (si elle existe)
    List<String> taskTitles = (List<String>) session.getAttribute("tasks");

    // Si la liste n'existe pas encore (premier chargement), on la crée
    if (taskTitles == null) {
        taskTitles = new ArrayList<>(); // Création d'une nouvelle liste vide
        session.setAttribute("tasks", taskTitles); // Sauvegarde dans la session
    }

    // Récupère le paramètre "action" envoyé par le formulaire
    String action = request.getParameter("action");

    // Vérifie si le formulaire a été soumis (action = "add" et méthode POST)
    if ("add".equals(action) && request.getMethod().equals("POST")) {

        // Récupère le titre saisi dans le formulaire
        String titre = request.getParameter("titre");

        // Vérifie que le titre n'est pas vide
        if (titre != null && !titre.isEmpty()) {
            taskTitles.add(titre); // Ajoute le titre à la liste des tâches
        }

        // Redirection vers la page principale pour éviter le repost avec F5
        response.sendRedirect("TP.jsp");
        return; // Stoppe l'exécution ici (important)
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> <!-- Définit l'encodage du document -->
    <title>Gestionnaire Tâches </title> <!-- Titre de l'onglet -->
</head>
<body>

    <h1>Mon Gestionnaire de Tâches (v0.1 - Titre seulement)</h1> <!-- Titre principal -->

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
    <ul>
    <%
        // Si la liste est vide, afficher un message
        if (taskTitles.isEmpty()) {
    %>
        <li>Vous n'avez aucune tâche.</li>
    <%
        } else {
            // Sinon, parcourir et afficher chaque titre
            for (String titreTache : taskTitles) {
    %>
        <li><%= titreTache %></li> <!-- Affiche le titre de la tâche -->
    <%
            } // Fin de la boucle for
        } // Fin du else
    %>
    </ul>

</body>
</html>

