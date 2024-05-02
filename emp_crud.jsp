<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head><%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee CRUD</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 20px;
}

h1 {
    text-align: center;
    color: #333;
}

label {
    margin-bottom: 5px;
    color: #666;
}

input[type="text"],
input[type="date"],
button {
    padding: 8px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    width: 200px;
}

button {
    cursor: pointer;
    background-color: #007bff;
    color: #fff;
    border: none;
}

button:hover {
    background-color: #0056b3;
}

#employeeTable {
    margin-top: 400px;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    background-color: #fff;
}

table {
	margin-top:400px;
    width: 100%;
    border-collapse: collapse;
}

table th,
table td {
    padding: 8px;
    border-bottom: 1px solid #ccc;
}

table th {
    background-color: #007bff;
    color: #fff;
}

table td {
    text-align: center;
}

.alert {
    padding: 10px;
    margin-top: 10px;
    border-radius: 5px;
    background-color: #ffc107;
    color: #333;
}
.container{
    display: flex;
    flex-wrap: wrap;
    justify-content: space-evenly;
    gap:20px;
    align-items: center;
}
.set{
    margin: 20px 0px;
}   
.main{
position:fixed;
top:0px;
}
    </style>
</head>
<body>
<div class="main">
    <h1>Employee CRUD</h1>
    <div class="container">
    <div class="set">
    <label for="empNo">Employee Number:</label>
    <input type="text" id="empNo"  readonly>
    </div>
    <div class="set">
    <label for="name">Name:</label>
    <input type="text" id="name" >
    </div>
    <div class="set">
    <label for="job">Job:</label>
    <input type="text" id="job" >
    </div>
    <div class="set">
    <label for="salary">Salary:</label>
    <input type="text" id="salary" >
    </div>
    <div class="set">
    <label for="deptNo">Department Number:</label>
    <input type="text" id="deptNo" >
    </div>
    <div class="set">
    <label for="hireDate">Hire Date:</label>
    <input type="date" id="hireDate" >
    </div>
    </div>
    <div class="container">
    <button id="btnFirst">First</button>
    
    <button id="btnNext">Next</button>
    <button id="btnPrev">Prev</button>
    <button id="btnLast">Last</button>
    <button id="btnAdd">Add</button>
    <button id="btnEdit">Edit</button>
    <button id="btnDelete">Delete</button>
    <button id="btnClear">Clear</button>
    </div>
    </div>
    	<table id="employeeTable">
    	<tbody></tbody>
    	</table>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function(){
            var currentIndex = 0; 
            var flag=false;
        	   function updateInputFields(row) {
        	        var empNo = row.find('td:eq(0)').text();
        	        var name = row.find('td:eq(1)').text();
        	        var job = row.find('td:eq(2)').text();
        	        var salary = row.find('td:eq(3)').text();
        	        var deptNo = row.find('td:eq(4)').text();
        	        var hireDate = row.find('td:eq(5)').text();
        	        
        	        $("#empNo").val(empNo);
        	        $("#name").val(name);
        	        $("#job").val(job);
        	        $("#salary").val(salary);
        	        $("#deptNo").val(deptNo);
        	        $("#hireDate").val(hireDate);
        	    }
        	   function getTable(){
        		   
            $.ajax({
                url: 'EmployessServelet',
                type: 'GET',
                success: function(response) {
                    var tableBody = $('#employeeTable tbody');
                    tableBody.empty(); 
                    var headers = '<tr>' +
                    '<th>Employee Number</th>' +
                    '<th>Name</th>' +
                    '<th>Job</th>' +
                    '<th>Salary</th>' +
                    '<th>Department Number</th>' +
                    '<th>Hire Date</th>' +
                    '</tr>';
      					tableBody.html(headers);
                    response.forEach(function(employee) {
                        var row = $('<tr>');
                        row.append($('<td>').text(employee.emp_no));
                        row.append($('<td>').text(employee.emp_name));
                        row.append($('<td>').text(employee.emp_job));
                        row.append($('<td>').text(employee.sal));
                        row.append($('<td>').text(employee.dept_no));
                        var hireDate = new Date(employee.Hire_Date);
                    	 var formattedDate = hireDate.getFullYear() + '-' + ('0' + (hireDate.getMonth() + 1)).slice(-2) + '-' + ('0' + hireDate.getDate()).slice(-2);
                     		row.append($('<td>').text(formattedDate));
                        	tableBody.append(row);
                    });
                    currentIndex = 1;
                    updateInputFields(tableBody.find('tr:eq(' + currentIndex + ')'));
                },
                error: function(xhr, status, error) {
                    // Handle error
                    console.error(xhr, status, error);
                }
            });
        	   }
        	   getTable();  
            var tableBody = $('#employeeTable tbody');
            tableBody.on('click', 'tr', function() {
                // Extract values from the clicked row
                var empNo = $(this).find('td:eq(0)').text();
                var name = $(this).find('td:eq(1)').text();
                var job = $(this).find('td:eq(2)').text();
                var salary = $(this).find('td:eq(3)').text();
                var deptNo = $(this).find('td:eq(4)').text();
                var hireDate = $(this).find('td:eq(5)').text();
                 $("#empNo").val(empNo);
                $("#name").val(name);
                $("#job").val(job);
                $("#salary").val(salary);
                $("#deptNo").val(deptNo);
                $("#hireDate").val(hireDate);
            });
            $('#btnNext').on('click', function() {
                var numRows = tableBody.find('tr').length;
                currentIndex++;
                        if (currentIndex >= numRows) {
                        	currentIndex=numRows-1;   	
                    alert("End of table reached!");
                    return;
                }
                
                    updateInputFields(tableBody.find('tr:eq(' + currentIndex + ')'));
            });
            $('#btnPrev').on('click', function() {
                var numRows = tableBody.find('tr').length;
                currentIndex--;
                        if (currentIndex == 0) {
                        	currentIndex=1;
                    alert("Can't go backward");
                    return;
                }
                
                // Update input fields with values from the next row
                updateInputFields(tableBody.find('tr:eq(' + currentIndex + ')'));
            });
            $('#btnFirst').on('click', function() {
                currentIndex = 1;
                updateInputFields(tableBody.find('tr:eq(' + currentIndex + ')'));
            });
            $('#btnLast').on('click', function() {
                currentIndex = tableBody.find('tr').length-1;
                updateInputFields(tableBody.find('tr:eq(' + currentIndex + ')'));
            });
            	$('#btnClear').click(function() {
            	    $('#empNo').val('');
            	    $('#name').val('');
            	    $('#job').val('');
            	    $('#salary').val('');
            	    $('#deptNo').val('');
            	    $('#hireDate').val('');
            	    $('#empNo').prop('readonly', false);
            	    flag = true;
            	});

    
           
            $('#btnAdd').on('click', function() {
            	
            	if(!flag){
            		alert("please clear all inputs using input buttons before add");
            		return
            		}
                var empNo = $('#empNo').val();
                var name = $('#name').val();
                var job = $('#job').val();
                var salary = $('#salary').val();
                var deptNo = $('#deptNo').val();
                var hireDate = $('#hireDate').val();
                $.ajax({
                    url: 'AddEmp',
                    type: 'POST',
                    data: {
                        empNo: empNo,
                        name: name,
                        job: job,
                        salary: salary,
                        deptNo: deptNo,
                        hireDate: hireDate
                    },
                    success: function(response) {
                        getTable();  
                        alert("employee added .....");
                        flag=false;
                        return
                    },
                    error: function(xhr, status, error) {
                        // Handle error response
                        console.error(xhr, status, error);
                    }
                });  
                $('#empNo').prop('readonly', true);
            });
            $('#btnDelete').on('click', function() {
                // Get the employee ID to delete
                var empIdToDelete = $('#empNo').val(); // Assuming you have an input field for entering the employee ID to delete

                // AJAX call to delete the employee
                $.ajax({
                    url: 'DeleteEMP',
                    type: 'POST',
                    data: {
                    	empno: empIdToDelete
                    },
                    success: function(response) {
            			alert("deleted Sucessfully.....");
                        getTable();
                    },
                    error: function(xhr, status, error) {
                        console.error(xhr, status, error);
                    }
                });
            });
            $('#btnEdit').on('click', function() {
                var empNo = $('#empNo').val();
                var name = $('#name').val();
                var job = $('#job').val();
                var salary = $('#salary').val();
                var deptNo = $('#deptNo').val();
                var hireDate = $('#hireDate').val();
                $.ajax({
                    url: 'UpdateEmployee', 
                    type: 'POST',
                    data: {
                        empNo: empNo,
                        name: name,
                        job: job,
                        salary: salary,
                        deptNo: deptNo,
                        hireDate: hireDate
                    },
                    success: function(response) {
           
                        getTable(); 
                    },
                    error: function(xhr, status, error) {
                        // Handle error response
                        console.error('Error updating employee:', xhr, status, error);
                    }
                });
            });

        });
        
    </script>
</body>
</html>
    
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee CRUD</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 20px;
}

h1 {
    text-align: center;
    color: #333;
}

label {
    margin-bottom: 5px;
    color: #666;
}

input[type="text"],
input[type="date"],
button {
    padding: 8px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    width: 200px;
}

button {
    cursor: pointer;
    background-color: #007bff;
    color: #fff;
    border: none;
}

button:hover {
    background-color: #0056b3;
}

#employeeTable {
    margin-top: 400px;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    background-color: #fff;
}

table {
	margin-top:400px;
    width: 100%;
    border-collapse: collapse;
}

table th,
table td {
    padding: 8px;
    border-bottom: 1px solid #ccc;
}

table th {
    background-color: #007bff;
    color: #fff;
}

table td {
    text-align: center;
}

.alert {
    padding: 10px;
    margin-top: 10px;
    border-radius: 5px;
    background-color: #ffc107;
    color: #333;
}
.container{
    display: flex;
    flex-wrap: wrap;
    justify-content: space-evenly;
    gap:20px;
    align-items: center;
}
.set{
    margin: 20px 0px;
}   
.main{
position:fixed;
top:0px;
}
    </style>
</head>
<body>
<div class="main">
    <h1>Employee CRUD</h1>
    <div class="container">
    <div class="set">
    <label for="empNo">Employee Number:</label>
    <input type="text" id="empNo"  readonly>
    </div>
    <div class="set">
    <label for="name">Name:</label>
    <input type="text" id="name" >
    </div>
    <div class="set">
    <label for="job">Job:</label>
    <input type="text" id="job" >
    </div>
    <div class="set">
    <label for="salary">Salary:</label>
    <input type="text" id="salary" >
    </div>
    <div class="set">
    <label for="deptNo">Department Number:</label>
    <input type="text" id="deptNo" >
    </div>
    <div class="set">
    <label for="hireDate">Hire Date:</label>
    <input type="date" id="hireDate" >
    </div>
    </div>
    <div class="container">
    <button id="btnFirst">First</button>
    
    <button id="btnNext">Next</button>
    <button id="btnPrev">Prev</button>
    <button id="btnLast">Last</button>
    <button id="btnAdd">Add</button>
    <button id="btnEdit">Edit</button>
    <button id="btnDelete">Delete</button>
    <button id="btnClear">Clear</button>
    </div>
    </div>
    	<table id="employeeTable">
    	<tbody></tbody>
    	</table>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function(){
            var currentIndex = 0; 
            var flag=false;
        	   function updateInputFields(row) {
        	        // Extract values from the row
        	        var empNo = row.find('td:eq(0)').text();
        	        var name = row.find('td:eq(1)').text();
        	        var job = row.find('td:eq(2)').text();
        	        var salary = row.find('td:eq(3)').text();
        	        var deptNo = row.find('td:eq(4)').text();
        	        var hireDate = row.find('td:eq(5)').text();
        	        
        	        // Update input fields with extracted values
        	        $("#empNo").val(empNo);
        	        $("#name").val(name);
        	        $("#job").val(job);
        	        $("#salary").val(salary);
        	        $("#deptNo").val(deptNo);
        	        $("#hireDate").val(hireDate);
        	    }
        	   function getTable(){
        		   
            $.ajax({
                url: 'EmployessServelet',
                type: 'GET',
                success: function(response) {
                    var tableBody = $('#employeeTable tbody');
                    tableBody.empty(); 
                    var headers = '<tr>' +
                    '<th>Employee Number</th>' +
                    '<th>Name</th>' +
                    '<th>Job</th>' +
                    '<th>Salary</th>' +
                    '<th>Department Number</th>' +
                    '<th>Hire Date</th>' +
                    '</tr>';
      					tableBody.html(headers);
      					console.log(response[0]);
      					$("#empNo").val(response[0].emp_no);
						$("#name").val(response[0].emp_name);
						$("#job").val(response[0].emp_job);
						$("#salary").val(response[0].sal);
						$("#deptNo").val(response[0].dept_no);
						 var hireDate = new Date(response[0].Hire_Date);
                   		 var formattedDate = hireDate.getFullYear() + '-' + ('0' + (hireDate.getMonth() + 1)).slice(-2) + '-' + ('0' + hireDate.getDate()).slice(-2);

						$("#hireDate").val(formattedDate);
                    response.forEach(function(employee) {
                        var row = $('<tr>');
                        row.append($('<td>').text(employee.emp_no));
                        row.append($('<td>').text(employee.emp_name));
                        row.append($('<td>').text(employee.emp_job));
                        row.append($('<td>').text(employee.sal));
                        row.append($('<td>').text(employee.dept_no));
                        var hireDate = new Date(employee.Hire_Date);
                    	 var formattedDate = hireDate.getFullYear() + '-' + ('0' + (hireDate.getMonth() + 1)).slice(-2) + '-' + ('0' + hireDate.getDate()).slice(-2);
                     		row.append($('<td>').text(formattedDate));
                        	tableBody.append(row);
                    });
                    currentIndex = 1;
                    updateInputFields(tableBody.find('tr:eq(' + currentIndex + ')'));
                },
                error: function(xhr, status, error) {
                    // Handle error
                    console.error(xhr, status, error);
                }
            });
        	   }
        	   getTable();  
            var tableBody = $('#employeeTable tbody');
            tableBody.on('click', 'tr', function() {
                // Extract values from the clicked row
                var empNo = $(this).find('td:eq(0)').text();
                var name = $(this).find('td:eq(1)').text();
                var job = $(this).find('td:eq(2)').text();
                var salary = $(this).find('td:eq(3)').text();
                var deptNo = $(this).find('td:eq(4)').text();
                var hireDate = $(this).find('td:eq(5)').text();
                 $("#empNo").val(empNo);
                $("#name").val(name);
                $("#job").val(job);
                $("#salary").val(salary);
                $("#deptNo").val(deptNo);
                $("#hireDate").val(hireDate);
            });
            $('#btnNext').on('click', function() {
                var numRows = tableBody.find('tr').length;
                currentIndex++;
                        if (currentIndex >= numRows) {
                    alert("End of table reached!");
                    return;
                }
                
                // Update input fields with values from the next row
                updateInputFields(tableBody.find('tr:eq(' + currentIndex + ')'));
            });
            $('#btnPrev').on('click', function() {
                var numRows = tableBody.find('tr').length;
                currentIndex--;
                        if (currentIndex == 0) {
                        	currentIndex=1;
                    alert("Can't go backward");
                    return;
                }
                
                // Update input fields with values from the next row
                updateInputFields(tableBody.find('tr:eq(' + currentIndex + ')'));
            });
            $('#btnFirst').on('click', function() {
                currentIndex = 1;
                updateInputFields(tableBody.find('tr:eq(' + currentIndex + ')'));
            });
            $('#btnLast').on('click', function() {
                currentIndex = tableBody.find('tr').length-1;
                updateInputFields(tableBody.find('tr:eq(' + currentIndex + ')'));
            });
            	$('#btnClear').click(function() {
            	    $('#empNo').val('');
            	    $('#name').val('');
            	    $('#job').val('');
            	    $('#salary').val('');
            	    $('#deptNo').val('');
            	    $('#hireDate').val('');
            	    $('#empNo').prop('readonly', false);
            	    flag = true;
            	});

    
           
            $('#btnAdd').on('click', function() {
            	
            	if(!flag){
            		alert("please clear all inputs using input buttons before add");
            		return
            		}
                var empNo = $('#empNo').val();
                var name = $('#name').val();
                var job = $('#job').val();
                var salary = $('#salary').val();
                var deptNo = $('#deptNo').val();
                var hireDate = $('#hireDate').val();
                $.ajax({
                    url: 'AddEmp',
                    type: 'POST',
                    data: {
                        empNo: empNo,
                        name: name,
                        job: job,
                        salary: salary,
                        deptNo: deptNo,
                        hireDate: hireDate
                    },
                    success: function(response) {
                        getTable();  
                        alert("employee added .....");
                        flag=false;
                        return
                    },
                    error: function(xhr, status, error) {
                        // Handle error response
                        console.error(xhr, status, error);
                    }
                });  
                $('#empNo').prop('readonly', true);
            });
            $('#btnDelete').on('click', function() {
                // Get the employee ID to delete
                var empIdToDelete = $('#empNo').val(); // Assuming you have an input field for entering the employee ID to delete

                // AJAX call to delete the employee
                $.ajax({
                    url: 'DeleteEMP',
                    type: 'POST',
                    data: {
                    	empno: empIdToDelete
                    },
                    success: function(response) {
            			alert("deleted Sucessfully.....");
                        getTable();
                    },
                    error: function(xhr, status, error) {
                        console.error(xhr, status, error);
                    }
                });
            });
            $('#btnEdit').on('click', function() {
                var empNo = $('#empNo').val();
                var name = $('#name').val();
                var job = $('#job').val();
                var salary = $('#salary').val();
                var deptNo = $('#deptNo').val();
                var hireDate = $('#hireDate').val();
                $.ajax({
                    url: 'UpdateEmployee', 
                    type: 'POST',
                    data: {
                        empNo: empNo,
                        name: name,
                        job: job,
                        salary: salary,
                        deptNo: deptNo,
                        hireDate: hireDate
                    },
                    success: function(response) {
           
                        getTable(); 
                    },
                    error: function(xhr, status, error) {
                        // Handle error response
                        console.error('Error updating employee:', xhr, status, error);
                    }
                });
            });

        });
        
    </script>
</body>
</html>
    
