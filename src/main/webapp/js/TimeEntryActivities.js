var TimeEntryActivities = {

    render: function($el, redmineId) {

        this.load(redmineId, function(data) {

            var options = "";
            var activities = data.responseJSON;

            _.each(activities, function(activity) {

                options += "<option value='" + activity.activityId + "'>" + activity.name + "</option>";

            });

          $el.attr("data-redmine", redmineId);
          $el.html(options);

        });

    },

    load: function(redmineId, callback) {

        $.ajax({
            url: "http://localhost:2342/activities?redmineId=" + redmineId,
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



