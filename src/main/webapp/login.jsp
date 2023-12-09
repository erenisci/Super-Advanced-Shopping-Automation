<%-- 
    Document   : login
    Created on : 9 Ara 2023, 01:53:45
    Author     : iscie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta
          name="viewport"
          content="width=device-width, initial-scale=1.0"
        />
        <link
          rel="preconnect"
          href="https://fonts.googleapis.com"
        />
        <link
          rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin
        />
        <link
          href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap"
          rel="stylesheet"
        />
        <link
          rel="stylesheet"
          href="css/login.css"
        />
        <link
          rel="stylesheet"
          href="css/general.css"
        />
        <title>Login</title>
    </head>
    <body>
        <div class="login-div">
            <p class="title">GİRİŞ YAP</p>
            <form class="loginForm" action="index.jsp" method="post">
                <div class="inputs"><p>E-Posta</p><input class="inp loginName" type="email" name="userName"/></div>
                <div class="inputs"><p>Şifre</p><input class="inp loginPassword" type="password" name="userPassword"/></div>
                <div class="inputs marg-top"><p class="hid">EŞ</p><button class="inp sub" type="submit">Giriş Yap</button></div>
            </form>
            <p class="newregister">Henüz üye olmadınız mı? <a class="linktoregister" href="register.jsp">Üye Ol</a></p>
        </div>
    </body>
</html>