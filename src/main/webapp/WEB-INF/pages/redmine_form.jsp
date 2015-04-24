<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title></title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width">

    <script src="<c:url value='/calendar/lib/jquery.min.js' />"></script>
    <script src="<c:url value='/calendar/lib/jquery-ui.custom.min.js' />"></script>
    <script src="<c:url value='/js/underscore-min.js' />"></script>
    <script src="<c:url value='/js/date.js' />"></script>

    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css' />">
    <style>
        body {
            padding-top: 100px;
            padding-bottom: 20px;
        }
    </style>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap-theme.min.css' />">
    <link rel="stylesheet" href="<c:url value='/css/main.css' />">

    <script src="<c:url value='/js/vendor/modernizr-2.6.2-respond-1.1.0.min.js' />"></script>

</head>
<body>
<!--[if lt IE 7]>
<p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
<![endif]-->
<div class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Redmine Time Tracker</a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li><a href="<c:url value='/' />">Tagesübersicht</a></li>
                <li><a href="<c:url value='/tracking' />">Buchen</a></li>
                <li><a href="<c:url value='/weeks' />">Wochenübersicht</a></li>
                <li class="active"><a href="<c:url value='/redmines' />">Konfiguration</a></li>
            </ul>
        </div><!--/.navbar-collapse -->
    </div>
</div>

<div class="container">

    <div class="row">

        <div class="col-lg-4">

            <c:choose>
              <c:when test="${redmine.id == null}">
                <c:url var="ACTION" value="/redmines" />
                <c:set var="METHOD" value="POST" />
              </c:when>
              <c:otherwise>
                <c:url var="ACTION" value="/redmines/${redmine.id}" />
                <c:set var="METHOD" value="PUT" />
              </c:otherwise>
            </c:choose>

            <form:form action="${ACTION}" method="${METHOD}" modelAttribute="redmine">
                <form:hidden path="id" />
                <div class="form-group">
                  <label>Name</label>
                  <form:input path="name" class="form-control" placeholder="Name" />
                </div>
                <div class="form-group">
                  <label>Link</label>
                  <form:input path="link" class="form-control" placeholder="Link" />
                </div>
                <div class="form-group">
                    <label>API-Key</label>
                    <form:input path="apiKey" class="form-control" placeholder="API-Key" />
                </div>
                <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-ok"></span> Speichern</button>
                <a href="<c:url value='/redmines' />" class="btn btn-default"><span class="glyphicon glyphicon-remove"></span> Abbrechen</a>
            </form:form>
        </div>


    </div>

    <hr>

    <footer>
        <p>&copy; Aljona Murygina 2014</p>
    </footer>
</div> <!-- /container -->

<script src="<c:url value='/js/vendor/bootstrap.min.js' />"></script>

</body>
</html>
