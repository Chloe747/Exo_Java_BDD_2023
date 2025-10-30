<%@page contentType="text/html" pageEncoding="UTF-8"%> <!-- Définit le type de contenu renvoyé (HTML) et l'encodage UTF-8 -->
<%@page import="java.util.List"%> <!-- Importe l'interface List pour stocker plusieurs objets -->
<%@page import="java.util.ArrayList"%> <!-- Importe ArrayList, l'implémentation concrète de List -->
<%@page import="java.util.Date"%> <%-- Permet de manipuler des dates pour les échéances des tâches --%>
<%@page import="java.text.SimpleDateFormat"%> <%-- Sert à convertir ou formater les dates en texte et inversement --%>
<%@page import="java.text.ParseException"%> <%-- Gère les erreurs de conversion texte → date --%>

<%!
    
    private static int idCounter = 0; // Compteur global pour attribuer un ID unique à chaque tâche

    // Définition de la classe "Task"
    public class Task {
        // Déclaration des attributs de chaque tâche
        private int id; // Identifiant unique
        private String titre; // Titre de la tâche
        private String description; // Description de la tache 
        private Date dateEcheance; // Date d’échéance
        private boolean terminee; // Indique si la tâche est terminée

        // Constructeur appelé à la création d'une nouvelle tâche
        public Task(String titre, Date dateEcheance) {
            this.id = idCounter++; // Donne un ID unique à partir du compteur global
            this.titre = titre; // Enregistre le titre donné
            this.description = description; // Enregistre la description donné
            this.dateEcheance = dateEcheance; // Enregistre la date d’échéance donnée
            this.terminee = false;  // Par défaut, la tâche est non terminée
        }

        // Getters : permettent d'accéder aux attributs
        public int getId() { return id; }
        public String getTitre() { return titre; }
        public String getDescription() { return description; }
        public Date getDateEcheance() { return dateEcheance; }
        public boolean isTerminee() { return terminee; }

        // Setter : permet de changer l’état (terminée ou non)
        public void setTerminee(boolean terminee) {
            this.terminee = terminee;
        }
    }
%>

<%
  
    // 0. Création d’un format de date standard (aaaa-MM-jj)
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    
    // 1. Récupérer (ou créer) la liste des tâches en session
    List<Task> taskList = (List<Task>) session.getAttribute("tasks");
    if (taskList == null) { // Si la liste n’existe pas encore
        taskList = new ArrayList<>(); // On la crée
        session.setAttribute("tasks", taskList); // Et on la sauvegarde dans la session
    }

    // 2. Récupère l’action envoyée par l’utilisateur (add, delete, toggle)
    String action = request.getParameter("action");

    // Si une action a été transmise...
    if (action != null) {
        
        // === ACTION "AJOUTER" ===
        if ("add".equals(action) && request.getMethod().equals("POST")) {
            // On récupère le titre et la date du formulaire
            String titre = request.getParameter("titre");
            String description = request.getParameter("description");
            String dateStr = request.getParameter("dateEcheance");
            Date dateEcheance = null;

            try {
                dateEcheance = sdf.parse(dateStr); // Convertit le texte en objet Date
            } catch (Exception e) {
                // Si une erreur survient (mauvais format de date), on laisse la date à null
            }

            // Vérifie que le titre et la date sont valides avant d’ajouter la tâche
            if (titre != null && !titre.isEmpty() && dateEcheance != null) {
                taskList.add(new Task(titre, dateEcheance)); // Crée et ajoute une nouvelle tâche
            }

            // Redirection pour éviter un double envoi de formulaire (protection contre F5)
            response.sendRedirect("TP.jsp");
            return; // Stoppe le code ici
        }
        
        // === ACTION "SUPPRIMER" ===
        if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id")); // Récupère l’ID de la tâche à supprimer
                // Supprime la tâche correspondante (grâce à removeIf)
                taskList.removeIf(task -> task.getId() == id);
            } catch (Exception e) {
                // Si l’ID est invalide, on ignore
            }
            // Redirection pour mettre à jour la liste
            response.sendRedirect("TP.jsp");
            return;
        }
        
        // === ACTION "TERMINÉE / RÉ-OUVRIR" ===
        if ("toggle".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id")); // Récupère l’ID de la tâche
                // Parcourt la liste pour trouver la tâche correspondante
                for (Task task : taskList) {
                    if (task.getId() == id) {
                        // Inverse son état : si terminée → ré-ouverte, sinon → terminée
                        task.setTerminee(!task.isTerminee());
                        break;
                    }
                }
            } catch (Exception e) {
                // Ignore toute erreur de conversion
            }
            // Redirection pour actualiser la page
            response.sendRedirect("TP.jsp");
            return;
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> <!-- Définit l’encodage du document -->
    <title>Mini Tâches </title> <!-- Titre de la page -->
<style>
    /* Style général du corps de la page */
    body { 
        font-family: Arial, sans-serif; /* Police simple et lisible */
        background-color: #f4f4f4;      /* Couleur de fond gris clair */
        margin: 20px;                   /* Marge extérieure autour du contenu */
    }

    /* Titres principaux et secondaires */
    h1, h2 { 
        color: #333;                    /* Couleur du texte gris foncé */
    }

    /* Style du formulaire d’ajout de tâche */
    form { 
        background: #fff;               /* Fond blanc */
        border: 1px solid #ddd;         /* Bordure grise claire */
        padding: 15px;                  /* Espacement intérieur */
        border-radius: 5px;             /* Coins légèrement arrondis */
    }

    /* Espacement entre les blocs à l’intérieur du formulaire */
    form div { 
        margin-bottom: 10px; 
    }

    /* Style pour les labels (textes descriptifs des champs) */
    form label { 
        display: block;                 /* Les labels s’affichent sur une ligne complète */
        margin-bottom: 5px;             /* Petit espace entre le label et le champ */
    }

    /* Champs texte et date du formulaire */
    form input[type="text"], form input[type="date"] { 
        width: 300px;                   /* Largeur fixe des champs */
        padding: 8px;                   /* Espacement intérieur pour le confort de saisie */
    }

    /* Bouton de soumission du formulaire */
    form input[type="submit"] { 
        background: #007bff;            /* Couleur bleue typique des boutons */
        color: white;                   /* Texte blanc */
        padding: 10px;                  /* Taille du bouton */
        border: none;                   /* Supprime la bordure par défaut */
    }

    /* Liste des tâches (ul) */
    ul { 
        list-style-type: none;          /* Supprime les puces */
        padding-left: 0;                /* Enlève la marge à gauche */
    }

    /* Élément individuel de la liste (chaque tâche) */
    li {
        background: #fff;               /* Fond blanc */
        border: 1px solid #ddd;         /* Bordure grise claire */
        padding: 15px;                  /* Espacement intérieur */
        margin-bottom: 10px;            /* Espace entre les tâches */
        display: flex;                  /* Affichage flexible pour aligner le contenu */
        justify-content: space-between; /* Sépare le titre à gauche et les liens à droite */
        align-items: center;            /* Centre verticalement les éléments */
    }

    /* Classe appliquée aux tâches terminées */
    li.completed { 
        background: #e9e9e9;            /* Fond gris clair pour indiquer la complétion */
    }

    /* Le texte d’une tâche terminée est barré et grisé */
    li.completed span { 
        text-decoration: line-through;  /* Texte barré */
        color: #888;                    /* Couleur grise */
    }

    /* Style des liens (Supprimer, Terminer, etc.) */
    li a { 
        color: #dc3545;                 /* Couleur rouge (danger/suppression) */
        text-decoration: none;          /* Supprime le soulignement */
        margin-left: 10px;              /* Espacement entre les liens */
    }

    /* Lien pour marquer une tâche comme terminée ou ré-ouvrir */
    li a.toggle { 
        color: #28a745;                 /* Couleur verte (succès/valide) */
    }

    form textarea { 
        width: 300px; 
        padding: 8px; 
    }

    li small { 
        color: #555; 
    }
</style>

</head>
<body>

    <h1>Mon Gestionnaire de Tâches (v0.1 - avec date et état)</h1> <!-- En-tête principal -->

    
    <form action="TP.jsp" method="post"> <!-- Envoi vers la même page -->
        <input type="hidden" name="action" value="add"> <!-- Définit l’action comme "add" -->

        <div>
            <label for="titre">Titre de la tâche :</label> <!-- Label pour le champ titre -->
            <input type="text" id="titre" name="titre" required> <!-- Champ texte obligatoire -->
        </div>
        
        <br>

        <div>
            <label for="description">Description :</label>
            <textarea id="description" name="description" rows="3"></textarea>
        </div>

        <br>

        <div>
            <label for="dateEcheance">Date d'échéance :</label> <!-- Label pour la date -->
            <input type="date" id="dateEcheance" name="dateEcheance" required> <!-- Sélecteur de date obligatoire -->
        </div>

        <br>

        <input type="submit" value="Ajouter"> <!-- Bouton de validation -->
    </form>

    <hr> <!-- Ligne de séparation visuelle -->

    <h2>Mes Tâches</h2> <!-- Titre de la section d’affichage -->

   
    <ul>
    <% 
        // Si la liste est vide
        if (taskList.isEmpty()) {
    %>
        <li>Vous n'avez aucune tâche.</li>
    <%
        } else {
            // Prépare un format de date lisible (jj/MM/aaaa)
            SimpleDateFormat sdfDisplay = new SimpleDateFormat("dd/MM/yyyy");
            
            // Parcourt toutes les tâches
            for (Task tache : taskList) {
                // Si la tâche est terminée, on applique un style visuel différent
                String cssClass = tache.isTerminee() ? "class='completed'" : "";
    %>
        <!-- Affiche une tâche -->
        <li <%= cssClass %>>
        <%-- On met le texte dans un <span> pour le style --%>

        <span>
            <strong><%= tache.getTitre() %></strong> 
            <br>
            <small><%= tache.getDescription() %></small> 
            <br>
            <small>(Pour le : <%= sdfDisplay.format(tache.getDateEcheance()) %>)</small>
        </span>

        <div>
            <a href="TP.jsp?action=toggle&id=<%= tache.getId() %>" class="toggle">
                <%= tache.isTerminee() ? "Ré-ouvrir" : "Terminer" %>
            </a>
            <a href="TP.jsp?action=delete&id=<%= tache.getId() %>">
                Supprimer
            </a>
        </div>
    </li>
    <%
            } // Fin de la boucle for
        } // Fin du else
    %>
    </ul> <!-- Fin de la liste -->
</body>
</html>

