<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Payments </title>
    
    <link rel="stylesheet" href="/FrontEnd/css/material-icons.css">
    <link rel="stylesheet" href="/FrontEnd/css/font-awesome.min.css">
    <link rel="stylesheet" href="/FrontEnd/css/bootstrap.min.css">
    <link rel="stylesheet" href="/FrontEnd/css/customStyles.css">
    <script src="/FrontEnd/js/jquery.min.js"></script>
    <script src="/FrontEnd/js/bootstrap3.3.7.min.js"></script>
    <script src="/FrontEnd/Controllers/paymentController.js"></script>
    <script src="https://www.paypal.com/sdk/js?client-id=AQx4zvzIj7DBk55SgQF0_JMY4ncrKIIszJ6zBlxkKyHQQ9Go3zisKtJIxfbe9NEXQsWp0n83rAGYTo9X&disable-funding=credit,card"></script>
    <style>
        /* Media query for mobile viewport */
        @media screen and (max-width: 400px) {
            #paypal-button-container {
                width: 100%;
            }
        }

        /* Media query for desktop viewport */
        @media screen and (min-width: 400px) {
            #paypal-button-container {
                width: 200px;
            }
        }
    </style>
</head>

<body>
<div class="wrapper d-flex align-items-stretch">
        
         <!-- Page Content  -->

        <div class="container" >
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-6">
                            <h2> <b>Payments</b></h2>
                        </div>
                        <div class="col-sm-6">
                            <a onclick='addPayment()' class="btn btn-success" data-toggle="modal"> <span>Appointments</span></a>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <input type="text" id="inputSearch" class="form-control" placeholder="Appointment ID">
                    <input type="button" class="btn btn-default" id="searchBtn" value="Search">
                    <input type="button" class="btn btn-warning" id="ResetBtn" value="Reset">
                </div>
                <table class="table table-striped table-hover" id="listtable">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Paypal ID</th>
                            <th>date</th>
                            <th>AppointmentId ID</th>
                            <th>type</th>
                            <th>amount</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                </table>

            </div>
        </div>
        <!-- Add Modal HTML -->
        <div id="addModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form>
                        <div class="modal-header">
                            <h4 class="modal-title">Add Appointment</h4>
                            
                        </div>
                        <div class="modal-body">
                            <table class="table table-striped table-hover" id="appointmentlisttable">
			                    <thead>
			                        <tr>
			                            <th>ID</th>
			                            <th>Actions</th>
			                        </tr>
			                    </thead>
			                </table>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Close">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- View Modal HTML -->
        <div id="viewModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form>
                        <div class="modal-header">
                            <h4 class="modal-title">View Appointment</h4>
                            
                        </div>
                        <div class="modal-body">
                        	<div class="form-group">
                                <label>paypal Id :</label>
                                <span id="paypalId"></span>
                            </div>
                            <div class="form-group">
                                <label>date :</label>
                                <span id="date"></span>
                            </div>
                            <div class="form-group">
                                <label>appointmentId :</label>
                                <span id="appointmentId"></span>
                            </div>
                            <div class="form-group">
                                <label>type :</label>
                                <span id="type"></span>
                            </div>
                            <div class="form-group" >
                                <label>amount :</label>
                                <span id="amount"></span>
                            </div>
    
                            
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Close">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Edit Modal HTML -->
        <div id="editModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form>
                        <div class="modal-header">
                            <h4 class="modal-title">Edit Appointment</h4>
                            
                        </div>
                  		<div class="modal-body">
                            <div class="form-group">
                                <label>Paypal ID :</label>
                                <input type="text" class="form-control" id="paypalIdEdit" required>
                            </div>
                            <div class="form-group">
                                <label>Date :</label>
                                <input type="date" class="form-control" id="dateEdit">
                            </div>
                            <div class="form-group">
                                <label>Appointment ID :</label>
                                <input type="text"  class="form-control" id="appointmentIdEdit"  required>
                            </div>
                            <div class="form-group">
                                <label>Payment Type :</label>
                                <input type="text" class="form-control" id="typeEdit"  required>
                            </div>
                            <div class="form-group">
                                <label>Amount :</label>
                                <input type="text" class="form-control" id="amountEdit"  required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="button" class="btn btn-info" id="formEditBtn" value="Update">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Delete Modal HTML -->
        <div id="deleteModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form>
                        <div class="modal-header">
                            <h4 class="modal-title">Delete Appointment</h4>
                            
                        </div>
                        <div class="modal-body">
                            <p>Are you sure you want to delete these Records?</p>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="button" class="btn btn-danger" id="formDeleteBtn" value="Delete">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Alert Modal HTML -->
        <div id="AlertModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form>
                        <div class="modal-header">
                            <h4 class="modal-title" id="alertTitle"></h4>
                        </div>
                        <div class="modal-body">
                            <p id="AlertMsg"></p>
                        </div>
                        <div class="modal-footer">
                            <input type="button" id="CloseBtn" class="btn btn-default" data-dismiss="modal" value="close">
                        </div>
                    </form>
                </div>
            </div>
        </div>
         <!-- Alertpayment Modal HTML -->
        <div id="AlertPymentModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form>
                        <div class="modal-header">
                        </div>
                        <div class="modal-body">
                          <div class="form-group">
                                <label>Amount :</label>
                                <input type="text" class="form-control" id="payingAmount"  required>
                                <br/>
                                <div id="paypal-button-container"></div>
                                <div><input type="button" style="width: 200px;" id="InsurancePay" class="btn btn-primary" value="Pay by Insurance"></div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="button" id="CloseBtn2" class="btn btn-default" data-dismiss="modal" value="close">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
    </div>

    <script>
        paypal.Buttons({
            enableStandardCardFields: true,
            createOrder: function(data, actions) {
                return actions.order.create({
                    purchase_units: [{
                        amount: {
                            value: 99.00
                        }
                    }],
                    application_context: {
                        shipping_preference: 'NO_SHIPPING'
                    }
                });
            },
            onApprove: function(data, actions) {
                // This function captures the funds from the transaction.
                return actions.order.capture().then(function(details) {
                    // This function shows a transaction success message to your buyer.
                    processPayment(details.id)
                });
            },
            onAuthorize: function(data, actions) {
                // This function captures the funds from the transaction.
                return actions.order.capture().then(function(details) {
                    // This function shows a transaction success message to your buyer.
                    processPayment(details.id)
                });
            }
        }).render('#paypal-button-container');
        // This function displays Smart Payment Buttons on your web page.
    </script>
</body>

</html>