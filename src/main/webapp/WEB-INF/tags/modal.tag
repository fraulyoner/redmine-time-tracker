<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@attribute name="modalId" type="java.lang.String" required="true"%>
<%@attribute name="modalLabelId" type="java.lang.String" required="true"%>
<%@attribute name="modalCssClass" type="java.lang.String" required="true"%>
<%@attribute name="modalTitle" type="java.lang.String" required="true"%>
<%@attribute name="modalBody" type="java.lang.String" required="true"%>

<div class="modal fade ${modalCssClass}" id="${modalId}" tabindex="-1" role="dialog" aria-labelledby="${modalLabelId}" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="${modalLabelId}">${modalTitle}</h4>
            </div>
            <div class="modal-body">
                ${modalBody}
                <div class="text-right">
                    <c:choose>
                        <c:when test="${modalCssClass == 'success'}">
                            <c:set var="BUTTON_CSS_CLASS" value="btn-success" />
                        </c:when>
                        <c:when test="${modalCssClass == 'error'}">
                            <c:set var="BUTTON_CSS_CLASS" value="btn-danger" />
                        </c:when>
                        <c:otherwise>
                            <c:set var="BUTTON_CSS_CLASS" value="btn-primary" />
                        </c:otherwise>
                    </c:choose>
                    <button type="button" class="btn ${BUTTON_CSS_CLASS}" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>
</div>