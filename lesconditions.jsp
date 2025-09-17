<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>Les conditions</title>
</head>
<body bgcolor=white>
<h1>Exercices sur les conditions</h1>

<!-- Un seul formulaire pour tout -->
<form action="#" method="post">
    <p>Saisir la valeur A : <input type="text" name="valeur1">
    <p>Saisir la valeur B : <input type="text" name="valeur2">
    <p>Saisir la valeur C : <input type="text" name="valeur3">
    <p><input type="submit" value="Vérifier">
</form>

<%
String valeur1 = request.getParameter("valeur1");
String valeur2 = request.getParameter("valeur2");
String valeur3 = request.getParameter("valeur3");

if (valeur1 != null && valeur2 != null && !valeur1.isEmpty() && !valeur2.isEmpty()) {
    int intValeur1 = Integer.parseInt(valeur1);
    int intValeur2 = Integer.parseInt(valeur2);

    // Comparaison simple entre 2 valeurs
%>
    <h2>Comparaison de deux valeurs</h2>
<%
    if (intValeur1 > intValeur2) {
%>
        <p>Valeur 1 (<%= intValeur1 %>) est supérieure à Valeur 2 (<%= intValeur2 %>).</p>
<%
    } else if (intValeur1 < intValeur2) {
%>
        <p>Valeur 1 (<%= intValeur1 %>) est inférieure à Valeur 2 (<%= intValeur2 %>).</p>
<%
    } else {
%>
        <p>Valeur 1 (<%= intValeur1 %>) est égale à Valeur 2 (<%= intValeur2 %>).</p>
<%
    }
}

if (valeur1 != null && valeur2 != null && valeur3 != null 
        && !valeur1.isEmpty() && !valeur2.isEmpty() && !valeur3.isEmpty()) {

    int A = Integer.parseInt(valeur1);
    int B = Integer.parseInt(valeur2);
    int C = Integer.parseInt(valeur3);
%>

    <h2>Exercice 1 : Comparaison 1</h2>
    <p>Ecrire un programme qui demande à l'utilisateur de saisir 3 valeurs (A, B et C) 
    et dites-nous si la valeur de C est comprise entre A et B.</p>

<%
    // Comparaison : C entre A et B
    if ((C >= A && C <= B) || (C >= B && C <= A)) {
%>
        <p>Oui, C = <%= C %> est compris entre A = <%= A %> et B = <%= B %>.</p>
<%
    } else {
%>
        <p>Non, C = <%= C %> n'est pas compris entre A = <%= A %> et B = <%= B %>.</p>
<%
    }
%>
    <p><b>Exemple :</b><br/>
    A = 10<br/>
    B = 20<br/>
    C = 15<br/>
    Oui, C est compris entre A et B</p>

    <h2>Exercice 2 : Pair ou Impair ?</h2>
    <p>Écrivez un programme pour vérifier si un nombre est pair ou impair en utilisant une structure if.</p>

<%
    // Vérification pair/impair
    if (C % 2 == 0) {
%>
        <p>C = <%= C %> est pair.</p>
<%
    } else {
%>
        <p>C = <%= C %> est impair.</p>
<%
    }
%>
    <p><b>Exemple :</b><br/>
    C = 12 → Pair<br/>
    C = 7 → Impair</p>
<%
}
%>

<p><a href="index.html">Retour au sommaire</a></p>
</body>
</html>
