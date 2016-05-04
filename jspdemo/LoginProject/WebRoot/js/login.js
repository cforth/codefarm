function validateMid() {
	return validateEmpty("mid");
}

function validatePassword() {
	return validateEmpty("password");
}

function validate() {
	return validateMid() && validatePassword();
}
