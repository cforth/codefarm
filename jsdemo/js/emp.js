function validateEmpno() {
    return validateRegex("empno", /^\d{4}$/);
}

function validateEname() {
    return validateEmpty("ename");
}

function validateJob() {
    return validateEmpty("job");
}

function validateHiredate() {
    return validateRegex("hiredate", /^\d{4}-\d{2}-\d{2}$/);
}

function validateSal() {
    return validateRegex("sal",/^\d+(\.\d{1,2})?$/);
}

function validateComm() {
    return validateRegex("comm",/^\d+(\.\d{1,2})?$/);
}

function validate() {
    return validateEmpno() &&
            validateEname() &&
            validateJob() &&
            validateHiredate() &&
            validateSal() &&
            validateComm();
}