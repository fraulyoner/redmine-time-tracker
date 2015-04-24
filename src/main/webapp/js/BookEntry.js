var BookEntry = {

  save: function (json) {
    $.ajax({
      url: "http://localhost:2342/bookings",
      async: true,
      dataType: "json",
      contentType: "application/json; charset=utf-8",
      data: json,
      type: "POST",
      complete: function (data) {

        if (data.status == 200) {
          Calendar.refetchEvents();

          // do this that way, because $("form#newBookEntry").reset() is not working
          document.getElementById("newBookEntry").reset();
        } else {
          alert("Speichern fehlgeschlagen, bitte Eingaben überprüfen!");
        }

      }
    });
  },

  askRemove: function () {

    $('#modal-remove').modal('toggle');

  },

  remove: function () {

    var editForm = $("form#editBookEntry");
    var id = editForm.find("input.id").val();

    $.ajax({
      url: "http://localhost:2342/bookings/" + id,
      async: true,
      type: "DELETE",
      complete: function (data) {

        if (data.status == 200) {
          Calendar.refetchEvents();
        } else {
          alert("Löschen fehlgeschlagen!");
        }

        $('#modal-remove').modal('toggle');

        // reset form
        var formId = "editBookEntry";

        // do this that way, because $("form#editBookEntry").reset() is not working
        document.getElementById(formId).reset();

        var form = $("#" + formId);

        form.find("span.char-counter").html("0/");
        form.find("input.id").val("");
        form.find("input.color").val("");


      }
    });
  },

  getByForm: function (formId) {

    var form = $(formId);

    var event = new Object();

    event.id = form.find("input.id").val();
    event.issueId = form.find("input.issue").val();

    event.redmineId = form.find("select.redmine").val();
    event.activityId = form.find("select.activity").val();

    // get selected date in calendar
    var day = Calendar.getSelectedDate();
    var start = form.find("input.start").val();
    var end = form.find("input.end").val();

    event.day = new Date(day).toString("yyyy-MM-dd");

    if (start && end) {
      event.start = new Date(day).at(start).toString();
      event.end = new Date(day).at(end).toString();
    } else {
      var now = new Date().getTime();

      var currentMinutes = new Date(now).getMinutes();

      var minutes = currentMinutes;

      if (currentMinutes < 15) {
        minutes = 0;
      }

      if (currentMinutes > 15 && currentMinutes < 30) {
        minutes = 15;
      }

      if (currentMinutes > 30 && currentMinutes < 45) {
        minutes = 30;
      }

      if (currentMinutes > 45) {
        minutes = 45;
      }

      var currentTime = new Date(now).getHours() + ":" + minutes;

      var later = new Date().at(currentTime);
      var laterTime = new Date(later.getTime() + 30 * 60 * 1000).getTime();

      var currentTimePlusThirtyMinutes = new Date(laterTime).getHours() + ":" + new Date(laterTime).getMinutes();

      event.start = new Date(day).at(currentTime).toString();
      event.end = new Date(day).at(currentTimePlusThirtyMinutes).toString();
    }

    event.comment = form.find("textarea.comment").val();

    var color = form.find("input.color").val();

    if (!color || 0 == color.length) {
      event.color = Calendar.createdColor;
    } else {
      event.color = color;
    }

    event.allDay = false;

    return event;

  },

  fillForm: function (formId, bookEntry) {

    var form = $("form#" + formId);

    form.find("input.id").val(bookEntry.id);
    form.find("input.issue").val(bookEntry.issueId);

    form.find("select.redmine").val(bookEntry.redmineId);
    TimeEntryActivities.render(formId, function () {
      form.find("select.activity").val(bookEntry.activityId);
    });

    form.find("input.start").val(bookEntry.start.toString("HH:mm"));
    form.find("input.end").val(bookEntry.end.toString("HH:mm"));
    form.find("textarea.comment").val(bookEntry.comment);
    form.find("input.color").val(bookEntry.color);

    form.find("p.duration").html(bookEntry.duration);

    var commentField = form.find("textarea.comment");
    var comment = commentField.val();
    var counterPath = "form#" + formId + " span.char-counter";

    CharCounter.count(comment, counterPath);

  },

  track: function () {

    var json = new Object();

    json.ids = Calendar.trackingSelection.arrayOfSelectedElements;
    json.color = Calendar.bookedColor;
    json.comment = $("form#trackingForm .comment").val();
    json.duration = Calendar.trackingSelection.duration;

    $.ajax({
      url: "http://localhost:2342/bookings/track",
      async: true,
      dataType: "json",
      contentType: "application/json; charset=utf-8",
      data: JSON.stringify(json),
      type: "POST",
      complete: function (data) {

        if (data.status == 200) {
          $('#modal-success').modal('toggle');
          Calendar.refetchEvents();
          Calendar.resetTrackingSelection();
        } else {
          $('#modal-error').modal('toggle');
        }

      }
    });

  },

  change: function (bookEntry) {

    console.log("Event has been changed: " + bookEntry.start + " - " + bookEntry.end);

    var duration = this.duration(bookEntry);

    bookEntry.duration = duration;
    this.save(JSON.stringify(bookEntry));

    var editForm = $("form#editBookEntry");
    var id = editForm.find("input.id").val();

    if (bookEntry.id == id) {
      editForm.find("p.duration").html(duration);
      editForm.find("input.start").val(bookEntry.start.toString("HH:mm"));
      editForm.find("input.end").val(bookEntry.end.toString("HH:mm"));
    }


  },

  duration: function (bookEntry) {

    var startTime = new Date(bookEntry.start);
    var endTime = new Date(bookEntry.end);
    var difference = endTime.getTime() - startTime.getTime(); // difference in milliseconds
    var minutes = Math.round(difference / 60000);

    var duration = minutes / 60;

    return duration;

  }

}