<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>Gestion de taches</title>
</head>
<body bgcolor=white>
<h1>Gestionnaire de taches</h1>



<%
//--- Classe internet pour representer une tache ---
Class Task {
  private String titre;
  private String description;
  private String echeance;
  private boolean termine; 

  public Task (String titre, String descritpion, String echeance){
      this.titre = titre;
      this.description = description; 
      this.echeance = echeance;
      this.terminee = false;
  }

  public String getTitre() {return titre; }
  public String getDescription() { return description; }
  public String getEcheance() { return echeance; }
  public boolean isTerminee() { return terminee; }
  public void setTerminee(boolean terminee) { this.terminee = terminee; }
}

HttpSession sessionUser = request.getSession();
    ArrayList<Task> listeTaches = (ArrayList<Task>) sessionUser.getAttribute("listeTaches");
    if (listeTaches == null) {
        listeTaches = new ArrayList<>();
        sessionUser.setAttribute("listeTaches", listeTaches);
    }

    // ----- Gestion des actions -----
    String action = request.getParameter("action");
    if ("ajouter".equals(action)) {
        String titre = request.getParameter("titre");
        String desc = request.getParameter("description");
        String date = request.getParameter("echeance");
        if (titre != null && !titre.trim().isEmpty()) {
            listeTaches.add(new Task(titre, desc, date));
        }
    } else if ("supprimer".equals(action)) {
        int index = Integer.parseInt(request.getParameter("index"));
        if (index >= 0 && index < listeTaches.size()) {
            listeTaches.remove(index);
        }
    } else if ("terminer".equals(action)) {
        int index = Integer.parseInt(request.getParameter("index"));
        if (index >= 0 && index < listeTaches.size()) {
            listeTaches.get(index).setTerminee(true);
        }
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Mini Gestionnaire de Tâches</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; margin: 40px; }
        h1 { color: #2c3e50; }
        form { margin-bottom: 20px; background: #fff; padding: 15px; border-radius: 8px; box-shadow: 0 0 5px #ccc; }
        input, textarea { width: 100%; margin-top: 5px; margin-bottom: 10px; padding: 8px; }
        table { width: 100%; border-collapse: collapse; background: white; }
        th, td { padding: 10px; border-bottom: 1px solid #ddd; text-align: left; }
        .terminee { text-decoration: line-through; color: gray; }
        .btn { padding: 5px 10px; background: #3498db; color: white; border: none; border-radius: 4px; cursor: pointer; }
        .btn-danger { background: #e74c3c; }
        .btn-success { background: #2ecc71; }
    </style>
</head>
<body>
    <h1>🗂️ Mini Gestionnaire de Tâches Collaboratif</h1>

    <!-- Formulaire d'ajout -->
    <form method="post">
        <input type="hidden" name="action" value="ajouter">
        <label>Titre :</label>
        <input type="text" name="titre" required>
        <label>Description :</label>
        <textarea name="description" rows="3"></textarea>
        <label>Date d’échéance :</label>
        <input type="date" name="echeance">
        <button type="submit" class="btn">Ajouter la tâche</button>
    </form>

    <!-- Liste des tâches -->
    <h2>Liste de vos tâches :</h2>
    <table>
        <tr>
            <th>#</th>
            <th>Titre</th>
            <th>Description</th>
            <th>Échéance</th>
            <th>Statut</th>
            <th>Actions</th>
        </tr>
        <%
            int i = 0;
            for (Task t : listeTaches) {
        %>
        <tr class="<%= t.isTerminee() ? "terminee" : "" %>">
            <td><%= i %></td>
            <td><%= t.getTitre() %></td>
            <td><%= t.getDescription() %></td>
            <td><%= t.getEcheance() %></td>
            <td><%= t.isTerminee() ? "✅ Terminée" : "🕒 En cours" %></td>
            <td>
                <% if (!t.isTerminee()) { %>
                <form method="post" style="display:inline;">
                    <input type="hidden" name="action" value="terminer">
                    <input type="hidden" name="index" value="<%= i %>">
                    <button class="btn-success btn">Terminer</button>
                </form>
                <% } %>
                <form method="post" style="display:inline;">
                    <input type="hidden" name="action" value="supprimer">
                    <input type="hidden" name="index" value="<%= i %>">
                    <button class="btn-danger btn">Supprimer</button>
                </form>
            </td>
        </tr>
        <%
                i++;
            }
            if (listeTaches.isEmpty()) {
        %>
        <tr><td colspan="6" style="text-align:center;">Aucune tâche pour le moment.</td></tr>
        <% } %>
    </table>

    <footer style="margin-top:30px; font-size:14px; color:gray;">
        Hébergé sur : <a href="http://ec2-15-237-190-40.eu-west-3.compute.amazonaws.com/votre_prenom">
        http://ec2-15-237-190-40.eu-west-3.compute.amazonaws.com/votre_prenom</a>
    </footer>
</body>
</html>
  
