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
    }
        // 3. Traiter la suppression
    if ("delete".equals(action)) { // Vérifie si l'action demandée est "delete"
    try {
        // Récupère le paramètre "id" envoyé depuis le lien ou le bouton de suppression
        // et le convertit en entier (correspond à l'index de la tâche dans la liste)
        int index = Integer.parseInt(request.getParameter("id"));

        // Vérifie que l'index est valide (dans les bornes de la liste)
        if (index >= 0 && index < taskTitles.size()) {
            taskTitles.remove(index); // Supprime la tâche correspondante de la liste
        }

    } catch (Exception e) {
        // Si l'ID n'est pas un nombre ou qu'une erreur survient, on ignore l'erreur
        // Cela évite que la page plante à cause d'une mauvaise requête
    }

    // Après la suppression, on redirige vers la page principale
    // pour mettre à jour la liste et éviter les reposts
    response.sendRedirect("TP.jsp");

    return; // Stoppe immédiatement l'exécution du reste du code JSP
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

