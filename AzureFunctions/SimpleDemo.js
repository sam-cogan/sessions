module.exports = function(context, req) {
  context.log("JavaScript HTTP trigger function processed a request.");
  context.log("DOB:" + req.query.dob);
  var today = new Date();
  var birthDate = new Date(req.query.dob);
  var age = today.getFullYear() - birthDate.getFullYear();
  var m = today.getMonth() - birthDate.getMonth();
  if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
    age--;
  }

  if (req.query.name && req.query.dob) {
    context.res = {
      // status: 200, /* Defaults to 200 */
      body: req.query.name + " is age " + age
    };
  } else {
    context.res = {
      status: 400,
      body: "Please pass a name and dob on the query string"
    };
  }
  context.done();
};
