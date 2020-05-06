var payment = {	
		id:'',
		paypalId:'',
		date:'',
		appointmentId:'',
		type:'',
		amount:''

};
var payments = [];
var paidAppointmentId;
var Searchpayments = [];
var paymenttable = ["id", "paypalId", "date","appointmentId", "type","amount"];
var $rootUrl = "http://localhost:8080/HospitalMng/PaymentService/Payment/";
var $globalUrl = "";
$(document).ready(function() {
    $.ajax({
        url: $rootUrl,
        contentType: 'application/json',
        dataType: 'json',
        type: 'GET',
        success: function(data) {
        	payments = data;
        	tableCreation(payments);

        }
    });


});

function addPayment(){
	  $.ajax({
	        url: $rootUrl+"appointments",
	        contentType: 'application/json',
	        dataType: 'json',
	        type: 'GET',
	        success: function(data) {
	        	appointments = data;
	        	tableCreation2(appointments);

	        }
	    });
}
function ViewbuttonClick(para) {
	 $.ajax({
	        url: $rootUrl+para,
	        contentType: 'application/json',
	        dataType: 'json',
	        type: 'GET',
	        success: function(data) {
	        	payment = data;
	        	 setViewData();

	        }
	    });

   
}

function deletebuttonClick(para) {
    $globalUrl = $rootUrl + para;

}

function editbuttonClick(para) {
	$.ajax({
        url: $rootUrl+para,
        contentType: 'application/json',
        dataType: 'json',
        type: 'GET',
        success: function(data) {
        	payment=data;
        	setEditViewData();
        }
	});
    
}

$(document).on("click", "#formDeleteBtn", function() {
    $.ajax({
        url: $globalUrl,
        contentType: 'application/json',
        dataType: 'json',
        type: 'DELETE',
        success: function(data) {
            alertModifier('delete', 'success');
            $('#AlertModal').modal('show');
        },
        error: function(jqXHR, exception) {
            var msg = '';
            if (jqXHR.status === 0) {
                msg = 'Cannot delete the Record \nRelated Payment Found';
            } else if (jqXHR.status == 404) {
                msg = 'No Access';
            } else if (jqXHR.status == 500) {
                msg = 'Internal Server Error [500].';
            } else if (exception === 'parsererror') {
                msg = 'Requested JSON parse failed.';
            } else if (exception === 'timeout') {
                msg = 'Time out error.';
            } else if (exception === 'abort') {
                msg = 'Ajax request aborted.';
            } else {
                msg = 'Uncaught Error.\n' + jqXHR.responseText;
            }
            alertModifier('create', msg);
            $('#AlertModal').modal('show');
        }
    });
});

$(document).on("click", "#formEditBtn", function() {
    setEditData();
    $url = $rootUrl;
    $.ajax({
        type: "PUT",
        url: $url,
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(payment),
        dataType: 'json',
        success: function() {
            alertModifier('update', 'success');
            $('#AlertModal').modal('show');
        },
        error: function(jqXHR, exception) {
            var msg = '';
            if (jqXHR.status === 0) {
                msg = 'Cannot update the Record';
            } else if (jqXHR.status == 404) {
                msg = 'No Access';
            } else if (jqXHR.status == 500) {
                msg = 'Internal Server Error [500].';
            } else if (exception === 'parsererror') {
                msg = 'Requested JSON parse failed.';
            } else if (exception === 'timeout') {
                msg = 'Time out error.';
            } else if (exception === 'abort') {
                msg = 'Ajax request aborted.';
            } else {
                msg = 'Uncaught Error.\n' + jqXHR.responseText;
            }
            alertModifier('create', msg);
            $('#AlertModal').modal('show');
        }
    });
});

$(document).on("click", "#searchBtn", function() {
    Searchpayments = [];
    removetble(document.getElementById('listtable'));
    var searchinput = document.getElementById("inputSearch").value;
    document.getElementById("inputSearch").value = '';
    payments.forEach(function(item) {
        if (item["appointmentId"] == searchinput) {
            Searchpayments.push(item)
        }
    });
 
    tableCreation(Searchpayments);

});

$(document).on("click", "#ResetBtn", function() {
    removetble(document.getElementById('listtable'));
    tableCreation(payments)
});

function tableCreation(para) {
    if (document.getElementById("listtable") != null) {
        var table = document.getElementById("listtable");
        var tbody = document.createElement("tbody");
        table.appendChild(tbody);
        para.forEach(function(item) {
            userSelect = item["id"];
            var row = document.createElement("tr");
            paymenttable.forEach(function(key) {
                var cell = document.createElement("td");
                if (key == "date") {
                    cell.textContent = item[key].replace('Z', '');
                } else {
                    cell.textContent = item[key];
                }
                row.appendChild(cell);
            });
            var cellview = document.createElement("td");
            cellview.innerHTML = "<a href='#viewModal' onclick='ViewbuttonClick(" + userSelect + ")' class='view' data-toggle='modal'><i class='material-icons' data-toggle='tooltip' title='Edit'>visibility</i></a>";
            row.appendChild(cellview);
	    	var celledit = document.createElement("td");
	        celledit.innerHTML = "<a href='#editModal' class='edit' onclick='editbuttonClick(" + userSelect + ")'  data-toggle='modal'><i class='material-icons' data-toggle='tooltip' title='Edit'>&#xE254;</i></a>";
	        row.appendChild(celledit);
	        var celldelete = document.createElement("td");
	        celldelete.innerHTML = "<a href='#deleteModal' class='delete' onclick='deletebuttonClick(" + userSelect + ")' data-toggle='modal'><i  class='material-icons' data-toggle='tooltip' title='Delete'>&#xE872;</i></a>";
	        row.appendChild(celldelete);
	        tbody.appendChild(row);
        });
    }
}

function tableCreation2(para) {
    if (document.getElementById("appointmentlisttable") != null) {
    	removetble(document.getElementById("appointmentlisttable"))
        var table = document.getElementById("appointmentlisttable");
        var tbody = document.createElement("tbody");
        table.appendChild(tbody);
        para.forEach(function(item) {
            userSelect = item;
            var row = document.createElement("tr");
            
            var cellview = document.createElement("td");
            cellview.innerHTML = item;
            row.appendChild(cellview);
	        var cellpay = document.createElement("td");
	        cellpay.innerHTML = "<a onclick='pay(" + userSelect + ")'  class='btn btn-success' data-toggle='modal'> <span>Pay</span></a>";
	        
	        row.appendChild(cellpay);
	        tbody.appendChild(row);
        });
        $('#addModal').modal('show');
    }
}

function pay(para){
	paidAppointmentId=para;
	$('#AlertPymentModal').modal('show');
}
function processPayment(para){
	  payment = {

		        date:new Date().toISOString().slice(0,10),
		        amount: document.getElementById("payingAmount").value,
		        appointmentId:paidAppointmentId,
		        paypalId:para,
		        type:"paypal"

		    }

		    $.ajax({
		        type: "POST",
		        url: $rootUrl,
		        contentType: "application/json; charset=utf-8",
		        data: JSON.stringify(payment),
		        dataType: 'json',
		        success: function() {
		        	$("#paypal-button-container").addClass("disabledDiv");
		        	 $.ajax({
		 		        type: "PUT",
		 		        url: $rootUrl+"doPayment/"+paidAppointmentId,
		 		        contentType: "application/json; charset=utf-8",
		 		        dataType: 'json',
		 		        success: function(data) {
		 		        	$('#AlertPymentModal').modal('toggle');
		 		        	$('#addModal').modal('toggle');
		 		        	alertModifier('payment','success');
		 		        	$('#AlertModal').modal('show');
		 		        }});

		        },
		        error: function(jqXHR, exception) {
		            var msg = '';
		            if (jqXHR.status === 0) {
		                msg = 'Failed';
		            } else if (jqXHR.status == 404) {
		                msg = 'No Access';
		            } else if (jqXHR.status == 500) {
		                msg = 'Internal Server Error [500].';
		            } else if (exception === 'parsererror') {
		                msg = 'Requested JSON parse failed.';
		            } else if (exception === 'timeout') {
		                msg = 'Time out error.';
		            } else if (exception === 'abort') {
		                msg = 'Ajax request aborted.';
		            } else {
		                msg = 'Uncaught Error.\n' + jqXHR.responseText;
		            }
		            alertModifier('payment',msg);
		        	$('#AlertModal').modal('show');
		        },
		    });
}

$(document).on("click", "#InsurancePay", function() {
	 if (document.getElementById("payingAmount").value == "") {
		 document.getElementById("payingAmount").style.outline = "solid red 2px";
	    }
	    else
	        {
	    	document.getElementById("payingAmount").style.outline = "";
	  payment = {
		        date:new Date().toISOString().slice(0,10),
		        amount: document.getElementById("payingAmount").value,
		        appointmentId:paidAppointmentId,
		        paypalId:"",
		        type:"Insurance"

		    }

		    $.ajax({
		        type: "POST",
		        url: $rootUrl,
		        contentType: "application/json; charset=utf-8",
		        data: JSON.stringify(payment),
		        dataType: 'json',
		        success: function() {
		        	$("#paypal-button-container").addClass("disabledDiv");
		        	 $.ajax({
		 		        type: "PUT",
		 		        url: $rootUrl+"doPayment/"+paidAppointmentId,
		 		        contentType: "application/json; charset=utf-8",
		 		        dataType: 'json',
		 		        success: function(data) {
		 		        	window.location.reload();
		 		        }});

		        },
		        error: function(jqXHR, exception) {
		            var msg = '';
		            if (jqXHR.status === 0) {
		                msg = 'Failed';
		            } else if (jqXHR.status == 404) {
		                msg = 'No Access';
		            } else if (jqXHR.status == 500) {
		                msg = 'Internal Server Error [500].';
		            } else if (exception === 'parsererror') {
		                msg = 'Requested JSON parse failed.';
		            } else if (exception === 'timeout') {
		                msg = 'Time out error.';
		            } else if (exception === 'abort') {
		                msg = 'Ajax request aborted.';
		            } else {
		                msg = 'Uncaught Error.\n' + jqXHR.responseText;
		            }
		            alertModifier('payment',msg);
		        	$('#AlertModal').modal('show');
		        },
		    });
	        }
});

function setViewData() {
	document.getElementById("paypalId").innerHTML = payment.paypalId;
    document.getElementById("appointmentId").innerHTML = payment.appointmentId;
    document.getElementById("type").innerHTML = payment.type;
    document.getElementById("amount").innerHTML = payment.amount;
    document.getElementById("date").innerHTML = payment.date.replace('Z', '');
}

function setEditViewData() {

	document.getElementById("paypalIdEdit").value = payment.paypalId;
    document.getElementById("appointmentIdEdit").value = payment.appointmentId;
    document.getElementById("typeEdit").value = payment.type;
    document.getElementById("amountEdit").value = payment.amount;
    document.getElementById("dateEdit").value = payment.date.replace('Z', '');
	  
}

function setEditData() {
	payment.paypalId=document.getElementById("paypalIdEdit").value;
    payment.appointmentId=document.getElementById("appointmentIdEdit").value;
    payment.type=document.getElementById("typeEdit").value;
    payment.amount=document.getElementById("amountEdit").value;
    payment.date=document.getElementById("dateEdit").value;
}



function removetble(para) {
    var myTable = para;
    var rowCount = myTable.rows.length;
    for (var x = rowCount - 1; x > 0; x--) {
        myTable.deleteRow(x);
    }

}
$(document).on("click", "#CloseBtn", function(payment) {
    window.location.reload();
});

function alertModifier(para1, para2) {
    if (para2 == 'success') {
        document.getElementById('alertTitle').innerHTML = "Succeed";
        switch (para1) {
            case 'create':
                document.getElementById('AlertMsg').innerHTML = "payment Added Successfully";
                break;
            case 'update':
                document.getElementById('AlertMsg').innerHTML = "payment Updated Successfully";
                break;
            case 'delete':
                document.getElementById('AlertMsg').innerHTML = "payment Deleted Successfully";
                break;
            case 'closed':
                document.getElementById('AlertMsg').innerHTML = "payment Closed Successfully";
                break;
            case 'payment':
                document.getElementById('AlertMsg').innerHTML = "payment Successful";
                break;
        }
    } else {
        document.getElementById('alertTitle').innerHTML = "Failed";
        document.getElementById('AlertMsg').innerHTML = para2;

    }
}