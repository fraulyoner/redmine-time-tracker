var CharCounter = {

    count: function(val, id) {
    $(id).html(val.length + "/");
    },

    maxChars: function(elem, max) {
        if (elem.value.length > max) {
            elem.value = elem.value.substring(0, max);
        }
    }

};