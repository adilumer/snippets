/***************************************************************
 * July 26th, 2021                             M. Adil Umer    *
 *                                                             *
 * Data validation function for objects                        *
 * Example use case:                                           *
 *       request body of a REST API                            *
 *                                                             *
****************************************************************/

/***

var testObj = {

}

***/


module.exports = validate;

function validate(params, conditions, returnList){

}


function regexValidation(inputText, rgx) {
  return rgx && inputText.match(rgx);
}

function validateStructure(obj, structure) {
  if (!obj || typeof (obj) != "object" || typeof (structure) != "object") {
    return false;
  } else {
    return validate(obj, structure);
  }
}
