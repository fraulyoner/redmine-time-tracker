var Favorites = {

    fetch: function() {

        $.ajax({
            url: "http://localhost:2342/favorites",
            async: true,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            type: "GET",
            complete: function(data) {

                var list = "";

                var favoritesArray = data.responseJSON;

                _.each(favoritesArray, function(favorite) {
                    list += "<div class='well'>" +
                        "<span id='" + favorite.id + "'" +
                        " onclick='Favorites.book(" + favorite.id + ")'" +
                        " class='add-favorite glyphicon glyphicon-plus'></span>" +
                        "<span onclick='Favorites.askRemove(" + favorite.id + ")' class='remove-favorite glyphicon glyphicon-remove'>" + "</span>" +
                        "<span>" + favorite.title + "<br />" + favorite.start + " - " + favorite.end + "</span>" +
                        "</div>";
                })

                $(".favorites").html(list);

            }
        });

    },

    add: function() {
        var json = new Object();

        var form = $("form#editBookEntry");

        json.id = form.find("input.id").val();
        json.issueId = form.find("input.issue").val();

        json.redmineId = form.find("select.redmine").val();
        json.activityId = form.find("select.activity").val();

        json.start = form.find("input.start").val();
        json.end = form.find("input.end").val();
        json.comment = form.find("textarea.comment").val();

        json.duration = form.find("p.duration").html();

        json.allDay = false;

        var self = this;

        $.ajax({
            url: "http://localhost:2342/favorites",
            async: true,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(json),
            type: "POST",
            complete: function() {

                self.fetch();
                $('#myTab a#tab-favorites').tab('show');

            }
        });
    },

    book: function(id) {

        var day = Calendar.getSelectedDate();

        var json = new Object();
        json.favoriteId = id;
        json.day = new Date(day).toString("yyyy-MM-dd");
        json.color = Calendar.createdColor;

        $.ajax({
            url: "http://localhost:2342/favorites/book",
            async: true,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(json),
            type: "POST",
            complete: function(data) {

                console.log(data);
                Calendar.refetchEvents();

            }
        });

    },
    
    askRemove: function(id) {

        $('#modal-favorite div.modal-body').html(
            'Favorit unwiderruflich löschen?' +
                '<div class="text-right">' +
                '<button type="button" class="btn btn-danger" onclick="Favorites.remove(' + id + ');">Löschen</button> ' +
                '<button type="button" class="btn btn-default" data-dismiss="modal">Abbrechen</button>' +
                '</div>'  
        );
        
        $('#modal-favorite').modal('toggle');
        
    },
    
    remove: function(id) {

        var self = this;
        
        $.ajax({
            url: "http://localhost:2342/favorites/" + id,
            async: true,
            type: "DELETE",
            complete: function(data) {

                console.log(data);
                $('#modal-favorite').modal('toggle');
                
                self.fetch();

            }
        }); 
        
    }

}