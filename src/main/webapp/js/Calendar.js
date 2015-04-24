var Calendar = {

  createdColor: "#A1D99B",
  createdBorderColor: "#a1d99b",
  bookedColor: "#FEB24C",
  bookedBorderColor: "#fff7bc",
  selectedColor: "#9ECAE1",
  selectedBorderColor: "#3182bd",

  opts: {

    eventSources: [
      {
        url: "http://localhost:2342/bookings/",
        textColor: 'black',
        ignoreTimezone: false
      }
    ],
    header: {
      left: 'title',
      center: '',
      right: 'prev,next today'
    },
    defaultView: 'agendaDay',
    lang: 'de',
    timezone: 'local',
    weekends: false,
    weekNumbers: true,
    weekNumberTitle: 'KW ',
    titleFormat: {
      day: 'dddd, D. MMMM YYYY'
    },
    axisFormat: 'H:mm',
    timeFormat: {
      agenda: 'H:mm'
    },
    allDaySlot: false,
    slotDuration: '00:15:00',
    minTime: "06:00:00",
    maxTime: "22:00:00",
    slotEventOverlap: false,
    height: 700

  },

  setEventColor: function (element, backgroundColor, borderColor) {

    $(element).css("backgroundColor", backgroundColor);
    $(element).css("border", "1px solid " + borderColor);

  },

  render: function () {

    var self = this;

    this.opts.eventAfterRender = function (event, element) {

      if (event.tracked) {
        self.setEventColor(element, self.bookedColor, self.bookedBorderColor);
      } else {
        self.setEventColor(element, self.createdColor, self.createdBorderColor);
      }

    }

    this.opts.editable = true;

    this.opts.eventClick = function (event, element) {

      $('#myTab a#tab-selected').tab('show');

      BookEntry.fillForm("editBookEntry", event);

    };

    this.opts.eventResize = function (event) {

      BookEntry.change(event);

    };

    this.opts.eventDrop = function (event) {

      BookEntry.change(event);

    };

    $('#calendar').fullCalendar(this.opts);

  },

  trackingSelection: {
    arrayOfSelectedElements: [],
    issueId: undefined,
    redmineId: undefined,
    activityId: undefined,
    duration: 0
  },

  renderForTracking: function () {

    var self = this;

    this.opts.eventAfterRender = function (event, element) {

      if (event.tracked) {
        self.setEventColor(element, self.bookedColor, self.bookedBorderColor);
      } else if (event.selected) {
        self.setEventColor(element, self.selectedColor, self.selectedBorderColor);
      } else {
        self.setEventColor(element, self.createdColor, self.createdBorderColor);
      }

    }

    this.opts.editable = false;

    this.opts.eventRender = function (event, element) {

      element.popover({
        title: "Stunden: " + event.duration,
        placement: 'top',
        html: true,
        trigger: 'hover',
        animation: 'true',
        content: event.comment
      });

    }

    this.opts.eventClick = function (event, element) {

      // check not yet booked
      if (event.tracked) {
        alert("Eintrag wurde bereits gebucht!");
      } else {

        if (self.trackingSelection.issueId == undefined) {
          self.trackingSelection.issueId = event.issueId;
        }

        if (self.trackingSelection.redmineId == undefined) {
          self.trackingSelection.redmineId = event.redmineId;
        }

        if (self.trackingSelection.activityId == undefined) {
          self.trackingSelection.activityId = event.activityId;
        }

        // check if issue ids are the same and book entry not yet selected
        if (self.trackingSelection.issueId == event.issueId
          && self.trackingSelection.redmineId == event.redmineId
          && self.trackingSelection.activityId == event.activityId
          ) {

          if ($.inArray(event.id, self.trackingSelection.arrayOfSelectedElements) == -1) {
            self.selectEntryForTracking(event);
          } else {
            self.deselectEntryForTracking(event);
          }

        } else {
          console.log("Issue: " + self.trackingSelection.issueId + " / " + event.issueId);
          console.log("Redmine: " + self.trackingSelection.redmineId + " / " + event.redmineId);
          console.log("Activity: " + self.trackingSelection.activityId + " / " + event.activityId);

          alert("Ticketnummer, Redmines oder Aktivitäten unterscheiden sich, Einträge können nicht zusammen gebucht werden!");
        }

      }

      console.log("Selected entries: " + self.trackingSelection.arrayOfSelectedElements);

    };

    $('#calendar').fullCalendar(this.opts);

  },

  selectEntryForTracking: function (event) {

    this.trackingSelection.arrayOfSelectedElements.push(event.id);

    var current = parseFloat($("#duration").html());
    var toBeAdded = parseFloat(event.duration);

    var total = current + toBeAdded;
    this.trackingSelection.duration = total;

    $("#duration").html(total);

    $("#issueId").html("#" + event.issueId);

    $("#comments").append("<div class=\"well\" id=\"" + event.id + "\">" +
      "<span>" + event.duration + " Stunden<br />" + event.comment + "</span>" +
      "</div>");


    var currentComment = $("#trackingForm .comment").val();
    var commentToBeAdded = event.comment;
    var newComment;

    if (currentComment.length == 0) {
      newComment = commentToBeAdded;
    } else {
      newComment = currentComment + " + " + commentToBeAdded;
    }

    $("#trackingForm .comment").val(newComment);
    CharCounter.count($("#trackingForm .comment").val(), "#trackingForm span.char-counter");

    event.selected = true;
    $('#calendar').fullCalendar('updateEvent', event);

  },

  deselectEntryForTracking: function (event) {

    // Find and remove item from an array
    var i = this.trackingSelection.arrayOfSelectedElements.indexOf(event.id);
    if (i != -1) {
      this.trackingSelection.arrayOfSelectedElements.splice(i, 1);
    }

    if (this.trackingSelection.arrayOfSelectedElements.length == 0) {

      this.resetTrackingSelection();

    } else {

      var current = parseFloat($("#duration").html());
      var toBeSubtracted = parseFloat(event.duration);

      var total = current - toBeSubtracted;
      this.trackingSelection.duration = total;

      $("#duration").html(total);

      $("#comments #" + event.id).remove();

      var currentComment = $("#trackingForm .comment").val();
      var commentToBeRemoved = event.comment;
      var newComment = currentComment.replace(commentToBeRemoved, "");

      $("#trackingForm .comment").val(newComment);
      CharCounter.count($("#trackingForm .comment").val(), "#trackingForm span.char-counter");

      event.selected = false;
      $('#calendar').fullCalendar('updateEvent', event);

    }

  },

  refetchEvents: function () {
    $('#calendar').fullCalendar('refetchEvents');
  },

  getSelectedDate: function () {
    return $("#calendar").fullCalendar('getView').start;
  },

  resetTrackingSelection: function () {

    $("#comments").empty();
    $("#issueId").empty();
    $("#duration").html("0");
    $("form .comment").val("");
    CharCounter.count($("#trackingForm .comment").val(), "#trackingForm span.char-counter");

    this.trackingSelection.arrayOfSelectedElements = [];
    this.trackingSelection.issueId = undefined;
    this.trackingSelection.redmineId = undefined;
    this.trackingSelection.activityId = undefined;
    this.trackingSelection.duration = 0;

    this.refetchEvents();

  }

}



