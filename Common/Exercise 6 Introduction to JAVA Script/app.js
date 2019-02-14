'use strict';

function simpleInterest() {
  var amount = prompt("Enter amount: ","");

  var interest_rate = prompt("Enter interest rate: ", "");
  var  num_years = prompt("Enter number of years: ", "");
  var simple_interest;

  if (amount!= null && interest_rate != null && num_years != null) {

      document.getElementById("amount").innerHTML = "Amount: " + amount;
      document.getElementById("interest").innerHTML = "Total Interest: " + interest_rate;
      document.getElementById("years").innerHTML = "Total Years: " + num_years;
      simple_interest = (amount * interest_rate * num_years) / 100;
      document.getElementById("SI").innerHTML = "Simple Interest: " + simple_interest;
  }
}

function isPalindrome() {
  var str = prompt("Enter a string to check: ", "");
  var len = str.length;
  var mid = Math.floor(len/2);

  for(var i = 0; i < mid;  i++ ) {
    if (str[i] !== str[len - 1 - i]) {
          alert(str +" not Palindrome.");
          break;
       }
    else {
      alert(str +" is Palindrome.");
    }
  }
}

function areaCircle() {
  var radius = prompt("Enter radius for CIRCLE: ", "");
  var area = 2.14 * radius * radius;

  alert("Required Circle Area: " + area);
}

var person = {
  firstName:"Abhishek",
  lastName:"Maurya",
  age:21,
  City:"Ghaziabad"
};

var personCopy = {};

function copyObj() {
  for (var key in person) {
  personCopy[key] = person[key];
  }
  alert("Press ctrl+shift+i and open console tab to see effects.");
  console.log(personCopy);
}

var Employee = [
    { Name: 'Rahul', Age: 22, Salary: 12000, DOB: '26/08/1996' },
    { Name: 'Deepak', Age: 18, Salary: 11500, DOB: '12/06/2000' },
    { Name: 'Aditya', Age: 35, Salary: 700, DOB: '31/04/1986' },
    { Name: 'Swati', Age: 21, Salary: 35000, DOB: '06/12/1997' },
    { Name: 'Arushi', Age: 29, Salary: 45000, DOB: '11/4/1989' },
    { Name: 'Abdul', Age: 30, Salary: 45000, DOB: '11/4/1988' },
];


function listEmployee() {
  var len = Employee.length;
  var employeeName = "";
  var trainee = "";
  var software_engineer = "";
  var senior_engineer = "";

  document.getElementById('emp').innerHTML = "<tr><th>Name</th><th>Age</th><th>Salary</th><th>DOB</th></tr>";
  for (var j = 0; j < len; j++) {
    document.getElementById('emp').innerHTML+="<tr><td>" + Employee[j].Name+"</td><td>"+Employee[j].Age+"</td><td>"+Employee[j].Salary+"</td><td>"+Employee[j].DOB+"</td></tr>";
  }

  for(var i = 0; i<len; i++) {
    if(Employee[i].Salary > 5000) {
      employeeName += Employee[i].Name + ", ";
    }

    if(Employee[i].Age < 20) {
      trainee += Employee[i].Name + " ";
    } else if (Employee[i].Age >= 21 && Employee[i].Age <35) {
      software_engineer += Employee[i].Name + ", ";
    } else {
      senior_engineer += Employee[i].Name + ", ";
    }

    if(Employee[i].Salary < 1000 && Employee[i].Age > 20) {
      Employee[i].Salary  *= 5;
    }
  }

  document.getElementById("salary_less").innerHTML = "Employee salary greater than 5000: " + employeeName;
  document.getElementById("trainee").innerHTML = "Trainee Age < 20: " + trainee;

  document.getElementById("software_engineer").innerHTML = "21 =< Software_Engineer_list Age < 35: " + software_engineer;

  document.getElementById("senior_engineer").innerHTML = "Senior_Engineer_list Age >= 35: " + senior_engineer;
  document.getElementById("salary_inc").innerHTML = Employee[2].Salary;

}
