function validateAddProductForm() {
    return validateProductForm("addProductForm");
}

function validateUpdateProductForm() {
    return validateProductForm("updateProductForm");
}

function validateProductForm(formName) {
    var form = document.forms[formName];
    var name = form["name"].value.trim();
    var type = form["type"].value.trim();
    var info = form["info"].value.trim();
    var price = form["price"].value.trim();
    var quantity = form["quantity"].value.trim();
    var image = form["image"] ? form["image"].value.trim() : null;

    var blankRegex = /.*\S.*/;

    if (name == "" || !blankRegex.test(name)) {
        alert("Product Name must be filled out and cannot be just spaces");
        return false;
    }

    if (info == "" || !blankRegex.test(info)) {
        alert("Product info must be filled out and cannot be just spaces");
        return false;
    }
    if (price == "" || isNaN(price) || price <= 0) {
        alert("Please enter a valid Unit Price");
        return false;
    }
    if (quantity == "" || isNaN(quantity) || quantity <= 0) {
        alert("Please enter a valid Stock Quantity");
        return false;
    }

    if (image != null) {
        var imageField = form["image"];
        var allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i;
        if (!allowedExtensions.exec(imageField.value)) {
            alert("Please upload file having extensions .jpeg/.jpg/.png/.gif only.");
            imageField.value = '';
            return false;
        }
    }

    return true;
}

function validateRegisterForm() {
    var form = document.forms["registerForm"];
    var username = form["username"].value.trim();
    var email = form["email"].value.trim();
    var address = form["address"].value.trim();
    var mobile = form["mobile"].value.trim();
    var pincode = form["pincode"].value.trim();
    var password = form["password"].value.trim();
    var confirmPassword = form["confirmPassword"].value.trim();

    var blankRegex = /.*\S.*/;

    if (username == "" || !blankRegex.test(username)) {
        alert("Username must be filled out and cannot be just spaces");
        return false;
    }
    if (email == "") {
        alert("Email must be filled out");
        return false;
    }
    if (address == "") {
        alert("Address must be filled out");
        return false;
    }
    if (mobile == "" || isNaN(mobile) || mobile.length != 10) {
        alert("Please enter a valid 10-digit Mobile number");
        return false;
    }
    if (pincode == "" || isNaN(pincode) || pincode.length != 5) {
        alert("Please enter a valid 5-digit Pin Code");
        return false;
    }
    if (confirmPassword == "") {
        alert("Confirm Password must be filled out");
        return false;
    }
    if (password !== confirmPassword) {
        alert("Passwords do not match");
        return false;
    }

    return true;
}

