var TimeEntryActivities = {

    render: function(formId, callback) {

        var selectedRedmine = $("form#" + formId + " select.redmine").val();

        this.load(selectedRedmine, function(data) {

            var options = "";
            var activities = data.responseJSON;

            _.each(activities, function(activity) {

                options += "<option value='" + activity.activityId + "'>" + activity.name + "</option>";

            })

            $("#" + formId + " select.activity").html(options);

          if(callback) {
            callback("Loaded time entry activities for redmine with id=" + selectedRedmine);
          }

        });

    },

    load: function(selectedRedmine, callback) {

        $.ajax({
            url: "http://localhost:2342/activities?redmineId=" + selectedRedmine,
            async: true,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            type: "GET",
            complete: function(data) {

                callback(data);

            }
        });

    }

}



