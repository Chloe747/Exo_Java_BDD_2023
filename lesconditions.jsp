<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>Les conditions</title>
</head>
<body bgcolor=white>
<h1>Exercices sur les conditions</h1>

<!-- Un seul formulaire pour tout -->
<form action="#" method="post">
    <p>Saisir la valeur 1 (A) : <input type="text" name="valeur1">
    <p>Saisir la valeur 2 (B) : <input type="text" name="valeur2">
    <p>Saisir la valeur 3 (C) : <input type="text" name="valeur3">
    <p><input type="submit" value="Vérifier">
</form>

<%
String valeur1 = request.getParameter("valeur1");
String valeur2 = request.getParameter("valeur2");
String valeur3 = request.getParameter("valeur3");

if (valeur1 != null && valeur2 != null && !valeur1.isEmpty() && !valeur2.isEmpty()) {
    int intValeur1 = Integer.parseInt(valeur1);
    int intValeur2 = Integer.parseInt(valeur2);

    // Exercice 0 : Comparaison 2 valeurs
    if (intValeur1 > intValeur2) {
%>
        <p>Valeur 1 est supérieure à Valeur 2.</p>
<%
    } else if (intValeur1 < intValeur2) {
%>
        <p>Valeur 1 est inférieure à Valeur 2.</p>
<%
    } else {
%>
        <p>Valeur 1 est égale à Valeur 2.</p>
<%
    }
}

if (valeur1 != null && valeur2 != null && valeur3 != null 
        && !valeur1.isEmpty() && !valeur2.isEmpty() && !valeur3.isEmpty()) {

    int A = Integer.parseInt(valeur1);
    int B = Integer.parseInt(valeur2);
    int C = Integer.parseInt(valeur3);

    // Exercice 1 : C entre A et B
    if ((C >= A && C <= B) || (C >= B && C <= A)) {
%>
        <p>Oui, C = <%= C %> est compris entre A = <%= A %> et B = <%= B %>.</p>
<%
    } else {
%>
        <p>Non, C = <%= C %> n'est pas compris entre A = <%= A %> et B = <%= B %>.</p>
<%
    }

    // Exercice 2 : Pair ou impair ?
    if (C % 2 == 0) {
%>
        <p>C = <%= C %> est pair.</p>
<%
    } else {
%>
        <p>C = <%= C %> est impair.</p>
<%
    }
}
%>

<p><a href="index.html">Retour au sommaire</a></p>
</body>
</html>
