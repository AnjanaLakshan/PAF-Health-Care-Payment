package com;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import model.PaymentDAO;
import services.PaymentService;

import java.sql.SQLException;
import java.util.List;

@Path("/Payment")
public class PaymentController {

	PaymentDAO PaymentDAO = new PaymentDAO();
	PaymentService payService= new PaymentService();
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public List<PaymentDAO> getPayments() throws SQLException {
		return payService.getPayments();
	}
	@Path("/appointments")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public List<Integer> getAppointments() throws SQLException {
		return payService.getAppointmentsIds();
	}
	
	@Path("/{id}")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public PaymentDAO getPayment(@PathParam("id") int id) throws SQLException {
		return payService.getPayment(id);
	}
	
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	public PaymentDAO createPayment(PaymentDAO a) throws SQLException {
		payService.createPayment(a);
		return a;
	}
	
	@PUT
	@Consumes(MediaType.APPLICATION_JSON)
	public PaymentDAO updatePayment(PaymentDAO a) throws SQLException {
		
		if(payService.getPayment(a.getId()).getId()==0) {
			payService.createPayment(a);
		}
		else
		{
			payService.updatePayment(a);
						
		}
		return a;
	}
	@Path("/doPayment/{id}")
	@PUT
	@Consumes(MediaType.APPLICATION_JSON)
	public void doPayment(@PathParam("id") int id) throws SQLException {

			payService.doPayment(id);
					
	}
	
	@Path("/{id}")
	@DELETE
	@Produces(MediaType.APPLICATION_JSON)
	public void deletePayment(@PathParam("id") int id) throws SQLException {
		payService.deletePayment(id);
	}
	
}
