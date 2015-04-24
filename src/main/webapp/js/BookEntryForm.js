var BookEntryForm = {

    init: function() {

        $('form#newBookEntry').bind('submit', function(event) {

            BookEntryForm.submitBehavior("form#newBookEntry", event);

        });

        $('form#newBookEntry').bind('reset', function(event) {

            $("form#newBookEntry span.char-counter").html("0/");

        });

        $('form#editBookEntry').bind('submit', function(event) {

            BookEntryForm.submitBehavior("form#editBookEntry", event);

        });

    },

    submitBehavior: function submitBehavior(formId, event) {

        event.preventDefault();

        try {
            var bookEntry = BookEntry.getByForm(formId);

            if(bookEntry.start != undefined || bookEntry.end != undefined) {

                // start and end should not have the same time!
                if(bookEntry.start != bookEntry.end) {

                    var duration = BookEntry.duration(bookEntry);
                    bookEntry.duration = duration;
                    BookEntry.save(JSON.stringify(bookEntry));
                    $(formId).find("p.duration").html(duration);

                } else {
                    throw "start and end should not have same time";
                }

            } else {
                throw "start and end must not be empty";
            }

        } catch(ex) {
            alert("Bitte Eingaben für Von/Bis überprüfen!");
        }

    }

}