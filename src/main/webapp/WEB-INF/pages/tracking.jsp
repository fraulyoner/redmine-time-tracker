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
                <li><a href="<c:url value='/' />">Tagesübersicht</a></li>
                <li class="active"><a href="<c:url value='/tracking' />">Buchen</a></li>
                <li><a href="<c:url value='/weeks' />">Wochenübersicht</a></li>
                <li><a href="<c:url value='/redmines' />">Konfiguration</a></li>
            </ul>
        </div><!--/.navbar-collapse -->
    </div>
</div>

<div class="container">

    <div class="row">

        <div class="col-xs-12">
          <!-- Alert for tracking was successful -->
          <div class="alert alert-success" id="tracking-success">
            <button type="button" class="close" data-dismiss="alert">&times;</button>
            Buchen wurde erfolgreich ausgeführt.
          </div>

          <!-- Alert for error occurred during tracking -->
          <div class="alert alert-danger" id="tracking-error">
            <button type="button" class="close" data-dismiss="alert">&times;</button>
            Buchen konnte nicht ausgeführt werden.
          </div>
        </div>

        <div class="col-lg-4">
            
            <legend>Buchen</legend>
            
            <div id="comments"></div>
            
            <div>
                <span>Ticketnummer: </span>
                <span id="issueId">-</span>
            </div>

            <div>
                <span>Gesamtstunden: </span>
                <span id="duration">0</span>
            </div>
            
            <hr>
            
            <form id="trackingForm">
              <div class="form-group">
                <label>Aktivit&auml;t</label>
                <select id="activity" class="form-control" required>
                </select>
              </div>
                <div class="form-group">
                    <label>Kommentar</label> (<span class="char-counter">0/</span>250)
                    <textarea class="form-control comment" placeholder="Kommentar" rows="5"
                              onkeyup="CharCounter.count(this.value, 'span.char-counter');"
                              onkeydown="CharCounter.maxChars(this, 250); CharCounter.count(this.value, 'span.char-counter');"></textarea>
                </div>
                <button type="button" class="btn btn-warning" onclick="BookEntry.track();">
                    <span class="glyphicon glyphicon-time"></span> Buchen
                </button>
                <button type="reset" class="btn btn-default" onclick="Calendar.resetTrackingSelection();">
                    <span class="glyphicon glyphicon-repeat"></span> Reset
                </button>
            </form>
            
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
<script src="<c:url value='/js/BookEntry.js' />"></script>
<script src="<c:url value='/js/Calendar.js' />"></script>

<script type="text/javascript">
    $(document).ready(function() {

        Calendar.renderForTracking();

    });
</script>

</body>
</html>
