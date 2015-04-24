<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="custom" tagdir="/WEB-INF/tags"%>

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

  <link href="<c:url value='/lib/fullcalendar/dist/fullcalendar.min.css' />" rel='stylesheet' />
  <script src="<c:url value='/lib/jquery/dist/jquery.min.js' />"></script>
  <script src="<c:url value='/lib/moment/min/moment.min.js' />"></script>
  <script src="<c:url value='/lib/underscore/underscore-min.js' />"></script>
  <script src="<c:url value='/lib/date.js' />"></script>
  <script src="<c:url value='/lib/fullcalendar/dist/fullcalendar.min.js' />"></script>
  <script src="<c:url value='/lib/fullcalendar/dist/lang-all.js' />"></script>

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
                <li class="active"><a href="<c:url value='/' />">Tagesübersicht</a></li>
                <li><a href="<c:url value='/tracking' />">Buchen</a></li>
                <li><a href="<c:url value='/weeks' />">Wochenübersicht</a></li>
                <li><a href="<c:url value='/redmines' />">Konfiguration</a></li>
            </ul>
        </div><!--/.navbar-collapse -->
    </div>
</div>

<div class="container">

    <div class="row">

        <!-- Modal for asking if book entry should be removed -->
        <div class="modal fade" id="modal-remove" tabindex="-1" role="dialog" aria-labelledby="modal-remove-label" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="modal-remove-label">Eintrag wirklich löschen?</h4>
                    </div>
                    <div class="modal-body">
                        Soll der Eintrag wirklich gelöscht werden?
                        <div class="text-right">
                            <button type="button" class="btn btn-danger" onclick="BookEntry.remove();">Löschen</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Abbrechen</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal for asking if favorite should be removed -->
        <div class="modal fade" id="modal-favorite" tabindex="-1" role="dialog" aria-labelledby="modal-favorite-label" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="modal-favorite-label">Wirklich löschen?</h4>
                    </div>
                    <div class="modal-body">
                        <!-- is generated in Favorites.js --> 
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-lg-4">

            <ul class="nav nav-tabs" id="myTab">
                <li class="active"><a href="#new" data-toggle="tab">Neu</a></li>
                <li><a id="tab-selected" href="#selected" data-toggle="tab">Ausgewählt</a></li>
                <li><a id="tab-favorites" href="#favorites" data-toggle="tab">Favoriten</a></li>
            </ul>

            <div class="tab-content">

                <br />

                <div class="tab-pane active" id="new">
                    <custom:book-entry-form formId="newBookEntry" edit="false" />
                </div>

                <div class="tab-pane" id="selected">
                    <custom:book-entry-form formId="editBookEntry" edit="true" />
                </div>

                <div class="tab-pane" id="favorites">
                    <custom:favorites />
                </div>

            </div>

        </div>

        <div id='calendar' class="col-lg-8"></div>

    </div>

    <hr>

    <footer>
        <p class="pull-right text-muted"><a href="https://github.com/murygina/redmine-time-tracker">View project on GitHub</a></p>
    </footer>
</div> <!-- /container -->

<script src="<c:url value='/lib/bootstrap/dist/js/bootstrap.min.js' />"></script>

<script src="<c:url value='/js/CharCounter.js' />"></script>
<script src="<c:url value='/js/TimeEntryActivities.js' />"></script>
<script src="<c:url value='/js/Calendar.js' />"></script>
<script src="<c:url value='/js/BookEntry.js' />"></script>
<script src="<c:url value='/js/BookEntryForm.js' />"></script>
<script src="<c:url value='/js/Favorites.js' />"></script>

<script type="text/javascript">
    $(document).ready(function() {

        Calendar.render();
        BookEntryForm.init();
        Favorites.fetch();

    });
</script>

</body>
</html>
