<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@attribute name="formId" type="java.lang.String" required="true"%>
<%@attribute name="edit" type="java.lang.Boolean" required="true"%>

<form id="${formId}" role="form">

    <c:if test="${edit}">
        <input type="hidden" class="id" />
        <input type="hidden" class="color" />
    </c:if>

    <div class="form-group">
        <label>Redmine</label>
        <select class="form-control redmine" onchange="TimeEntryActivities.render('${formId}');">
            <c:forEach items="${redmines}" var="redmine">
                <option value="${redmine.id}"><c:out value="${redmine.name}" /></option>
            </c:forEach>
        </select>
    </div>
    <div class="form-group">
        <label>Ticketnummer</label>
        <input type="number" class="form-control issue" placeholder="1234">
    </div>
    <div class="form-group">
        <label>Von (optional)</label>
        <input type="text" class="form-control start" placeholder="HH:mm">
    </div>
    <div class="form-group">
        <label>Bis (optional)</label>
        <input type="text" class="form-control end" placeholder="HH:mm">
    </div>
    <div class="form-group">
        <label>Aktivit&auml;t</label>
        <select class="form-control activity">
            <script type="text/javascript">
                $(document).ready(function() {
                    TimeEntryActivities.render("${formId}", function(data) {
                        console.log(data);
                    });
                });
            </script>
        </select>
    </div>
    <div class="form-group">
        <label>Kommentar (optional)</label> (<span class="char-counter">0/</span>250)
        <textarea class="form-control comment" placeholder="Kommentar" rows="5"
                  onkeyup="CharCounter.count(this.value, 'form#${formId} span.char-counter');"
                  onkeydown="CharCounter.maxChars(this, 250); CharCounter.count(this.value, 'form#${formId} span.char-counter');"></textarea>
    </div>
    <c:if test="${edit}">
    <div class="form-group">
        <label>Dauer</label>
        <p class="duration"></p>
    </div>
    </c:if>
    <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-ok"></span> Speichern</button>
    <c:choose>
        <c:when test="${edit}">
            <button type="button" class="btn btn-default" onclick="Favorites.add();">
                <span class="glyphicon glyphicon-star"></span> Favorit
            </button>
            <button type="button" class="btn btn-default" onclick="BookEntry.askRemove();">
                <span class="glyphicon glyphicon-remove"></span> L&ouml;schen
            </button>
        </c:when>
        <c:otherwise>
            <button type="reset" class="btn btn-default">
                <span class="glyphicon glyphicon-repeat"></span> Reset
            </button>
        </c:otherwise>
    </c:choose>
</form>