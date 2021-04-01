$(document).ready(function () {

    //Toggle of button (Edit <-> Cancel) and Input field
    $(".admin-button.edit").click(function () {
        $(this).text(function (i, txt) {
            return txt === "Edit" ? "Cancel" : "Edit";
        });

        //Clear error message
        $(".admin-validation").children($("#Model_Name-error")).remove();

        //Toggle Input field 
        $(this).parents("form").find($(".toggle-input")).toggleClass("hidden");

        //Toggle Save button
        $(this).parent($(".admin-edit-buttons")).find($(".admin-button.save")).toggle();

        //Update indicator with the current text length
        lengthIndicatorUpdate($(this).parents("form").find($(".toggle-input > input")));
    });

    //Dynamically update indicator based on Input field text length
    $(".input-field > input, .input-field > textarea", this).keyup(function () {
        lengthIndicatorUpdate($(this));
    });

    //Dynamically convert Product name into slug
    $(".product-name", this).keyup(function () {
        var text = $(this).val();
        $(".slug").val(convertToSlug(text));
    });


    //Get Selected category from dropdown list
    $("#SelectedCategoryId").change(function () {
        id = $("option:selected", $(this)).val();
        text = $("option:selected", $(this)).text();

        $("option:selected", $(this)).remove();

        $("#SelectedCategoryAnchor").append(createHtmlElement("div", id, "", text + createHtmlElement("span", "", "deselect-category", "X")));

    });

    $(document).on("click", ".deselect-category", function () {
        var o = $(this).parent();
        $(this).remove();
        id = o.attr("id");
        text = o.text();
        o.remove();
        $("#SelectedCategoryId").append($('<option></option>').val(id).html(text));

        sortSelectOptions("#SelectedCategoryId", true);
    });


    //File upload
    //$("#ProductImage_Name").
    $("#upload").click(function () {
        var formData = new FormData();
        var totalFiles = document.getElementById("image-upload").files.length;
        for (var i = 0; i < totalFiles; i++) {
            var file = document.getElementById("image-upload").files[i];
            formData.append("image-upload", file);
        }
        $.ajax({
            url: '/Admin/Product/Upload',
            type: 'POST',
            data: formData,
            dataType: 'json',
            contentType: false,
            processData: false,
            success: function (data, textStatus, jqXHR) {
                if (data.Success) {
                    success(data, textStatus, jqXHR);
                } else {
                    if (error) {
                        error();
                    }
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                if (error)
                    error();
            }
        });
    });

    $(".admin-button").click(function () {
        console.log("clicked");
    });

});



//Dynamically update indicator based on Input field text length
function lengthIndicatorUpdate(o) {
    $(o).next(".char-num-display").html($(o).val().length);

    //Update slug length indicator based on the product name
    if ($(o).hasClass("product-name")) {
        $(".slug").next(".char-num-display").html($(o).val().length);
    }
};

//Convert string to slug (Product name to slug)
function convertToSlug(text) {
    return text
        .toLowerCase()
        .replace(/[^\w ]+/g, ' ')
        .replace(/ +/g, '-')
        ;
}

//Create an element with custom parameters
function createHtmlElement(customType, customId, customClass, customValue) {
    return (`<${customType} 
                ${customId === "" ? "" : `id=${customId}`}
                ${customClass === "" ? "" : `class=${customClass}`}>${customValue === "" ? "" : `${customValue}`}</${customType}>`);
}


function sortSelectOptions(selector, skip_first) {
    var options = (skip_first) ? $(selector + ' option:not(:first)') : $(selector + ' option');
    var arr = options.map(function (_, o) { return { t: $(o).text(), v: o.value, s: $(o).prop('selected') }; }).get();
    arr.sort(function (o1, o2) {
        var t1 = o1.t.toLowerCase(), t2 = o2.t.toLowerCase();
        return t1 > t2 ? 1 : t1 < t2 ? -1 : 0;
    });
    options.each(function (i, o) {
        o.value = arr[i].v;
        $(o).text(arr[i].t);
        if (arr[i].s) {
            $(o).attr('selected', 'selected').prop('selected', true);
        } else {
            $(o).removeAttr('selected');
            $(o).prop('selected', false);
        }
    });
}



