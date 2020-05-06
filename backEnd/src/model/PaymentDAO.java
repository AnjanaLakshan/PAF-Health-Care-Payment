package model;

import java.sql.Date;

public class PaymentDAO {
	
	private int id;
	private String paypalId;
	private Date date;
	private int appointmentId;
	private String type;
	private int amount;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getPaypalId() {
		return paypalId;
	}
	public void setPaypalId(String paypalId) {
		this.paypalId = paypalId;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public int getAppointmentId() {
		return appointmentId;
	}
	public void setAppointmentId(int appointmentId) {
		this.appointmentId = appointmentId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	
	
	
	
}
