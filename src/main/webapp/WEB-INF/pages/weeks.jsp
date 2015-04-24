<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Redmine Time Tracker</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width">

    <script src="<c:url value='/lib/jquery/dist/jquery.min.js' />"></script>

    <link rel="stylesheet" href="<c:url value='/lib/bootstrap/dist/css/bootstrap.min.css' />">
    <link rel="stylesheet" href="<c:url value='/lib/bootstrap/dist/css/bootstrap-theme.min.css' />">
    <link rel="stylesheet" href="<c:url value='/css/main.css' />">

    <script src="<c:url value='/lib/modernizr-2.6.2-respond-1.1.0.min.js' />"></script>

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
                <li class="active"><a href="<c:url value='/weeks' />">Wochenübersicht</a></li>
                <li><a href="<c:url value='/redmines' />">Konfiguration</a></li>
            </ul>
        </div><!--/.navbar-collapse -->
    </div>
</div>

<div class="container">

    <div class="row">

        <div class="col-lg-12">
            <table class="table">
                <thead>
                    <tr>
                        <th></th>
                        <th>Montag</th>
                        <th>Dienstag</th>
                        <th>Mittwoch</th>
                        <th>Donnerstag</th>
                        <th>Freitag</th>
                        <th>Gesamt</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach items="${statistics}" var="stat">
                    <tr>
                        <c:set var="KW" value="${stat.key}" />
                        <c:set var="weekDurations" value="${stat.value}" />

                        <c:set var="totalDuration" value="0" />
                        <th>KW ${KW}</th>
                        <c:forEach items="${weekDurations}" var="duration">
                            <c:choose>
                                <c:when test="${duration.value >= 8}">
                                    <c:set var="CSS_CLASS" value="sufficient" />
                                </c:when>
                                <c:otherwise>
                                    <c:set var="CSS_CLASS" value="insufficient" />
                                </c:otherwise>
                            </c:choose>
                            <td class="${CSS_CLASS}">${duration.value}</td>
                            <c:set var="totalDuration" value="${totalDuration + duration.value}" />
                        </c:forEach>

                        <c:choose>
                            <c:when test="${totalDuration >= 40}">
                                <c:set var="CSS_CLASS_TOTAL" value="sufficient" />
                            </c:when>
                            <c:otherwise>
                                <c:set var="CSS_CLASS_TOTAL" value="insufficient" />
                            </c:otherwise>
                        </c:choose>

                        <th class="${CSS_CLASS_TOTAL}"><c:out value="${totalDuration}" /></th>

                    </tr>
                </c:forEach>
                </tbody>
            </table>

        </div>


    </div>

    <hr>

    <footer>
      <p class="pull-right text-muted"><a href="https://github.com/murygina/redmine-time-tracker">View project on GitHub</a></p>
    </footer>
</div> <!-- /container -->

<script src="<c:url value='/lib/bootstrap/dist/js/bootstrap.min.js' />"></script>

</body>
</html>
