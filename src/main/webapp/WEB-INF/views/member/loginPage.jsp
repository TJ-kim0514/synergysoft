<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bonvoyage</title>
<style type="text/css">
h1 {
    font-size: 48pt;
    color: navy;
}
div {
	margin: auto;
    width: 500px;
    height: 200px;
    border: 2px solid navy;
    position: relative;
}
div form {
    font-size: 16pt;
    color: navy;
    font-weight: bold;
    margin: 10px;
    padding: 10px;
}
div#loginForm form input.pos {
    position: absolute;
    left: 120px;
    width: 300px;
    height: 25px;
}
div#loginForm form input[type=submit] {
    margin: 10px;
    width: 250px;
    height: 40px;
    position: absolute;
    left: 120px;
    background-color: navy;
    color: white;
    font-size: 16pt;
    font-weight: bold;
}
</style>
</head>
<body>
<h1 align="center">본보야지 로그인 페이지</h1>
<div id="loginForm">    
    <form action="login.do" method="post">
        <label>아이디 : <input type="text" name="memId" id="memid" class="pos"></label> <br>
        <label>비밀번호 : <input type="password" name="memPw" id="memPw" class="pos"></label> <br>
        <input type="submit" value="로그인">
    </form>
</div>
</body>
</html>