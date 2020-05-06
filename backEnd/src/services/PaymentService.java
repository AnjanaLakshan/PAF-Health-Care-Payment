package services;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.PaymentDAO;

public class PaymentService {
	
	List<PaymentDAO> payments;
	Connection conn=null;
	
	public PaymentService() {
		
		String url="jdbc:mysql://localhost:3306/payment";
		String usrName="root";
		String pw="";
	
		
			try {
				Class.forName("com.mysql.jdbc.Driver");
				conn=DriverManager.getConnection(url,usrName,pw);
			} catch (ClassNotFoundException | SQLException e) {
				System.out.println(e);
			}
		
		
	}
	
	public List<PaymentDAO> getPayments() throws SQLException {
		
		List<PaymentDAO> payments=new ArrayList<>();
		String query="select * from payment_details";
			
			Statement st=conn.createStatement();
			ResultSet rs=st.executeQuery(query);
			
			while (rs.next()) {
				PaymentDAO a=new PaymentDAO();
				a.setId(rs.getInt(1));
				a.setAppointmentId(rs.getInt(2));
				a.setPaypalId(rs.getString(3));
				a.setAmount(rs.getInt(4));
				a.setDate(rs.getDate(5));
				a.setType(rs.getString(6));
				payments.add(a);
			}

		return payments;
	}
	public List<Integer> getAppointmentsIds() throws SQLException {
			
			List<Integer> appointments=new ArrayList<>();
			String query="select * from appointment_details where status='not Paid'";
				
				Statement st=conn.createStatement();
				ResultSet rs=st.executeQuery(query);
				
				while (rs.next()) {
					appointments.add(rs.getInt(1));
				}
	
			return appointments;
		}
	public void doPayment(int id) throws SQLException {
		

		String query="UPDATE appointment_details SET status=? WHERE id=?";
		
		PreparedStatement st=conn.prepareStatement(query);
		st.setString(1, "paid");
		st.setInt(2, id);

		st.executeUpdate();
		
	}
	
	public PaymentDAO getPayment(int id) throws SQLException {
	
		PaymentDAO a=new PaymentDAO();
		String query="select * from payment_details where id="+id;

			
			Statement st=conn.createStatement();
			ResultSet rs=st.executeQuery(query);
			
			if (rs.next()) {
				
				a.setId(rs.getInt(1));
				a.setAppointmentId(rs.getInt(2));
				a.setPaypalId(rs.getString(3));
				a.setAmount(rs.getInt(4));
				a.setDate(rs.getDate(5));
				a.setType(rs.getString(6));

			}
			

		return a;
		
	}
	
	
	public void createPayment(PaymentDAO a) throws SQLException {
		
		 String query = " insert into payment_details (appointmentId, paypalId, amount, date,type) "
	    		  + " values ( ?, ?, ?, ?, ?)";
			PreparedStatement st=conn.prepareStatement(query);
			st.setInt(1, a.getAppointmentId());
			st.setString(2, a.getPaypalId());
			st.setInt(3, a.getAmount());
			st.setDate(4, a.getDate());
			st.setString(5, a.getType());
			st.executeUpdate();
		

		
	}
	
	public void updatePayment(PaymentDAO a) throws SQLException {
		
		String query="UPDATE payment_details SET appointmentId=?,paypalId=?,amount=?,date=?,type=? WHERE id=?";
			
			PreparedStatement st=conn.prepareStatement(query);
			st.setInt(1, a.getAppointmentId());
			st.setString(2, a.getPaypalId());
			st.setInt(3, a.getAmount());
			st.setDate(4, a.getDate());
			st.setString(5, a.getType());
			st.setInt(6, a.getId());
			st.executeUpdate();

		
	}
	
	
	
	public void deletePayment(int id) throws SQLException {
		
		String query="delete from payment_details where id=?";
			
			PreparedStatement st=conn.prepareStatement(query);

			st.setInt(1, id);
			st.executeUpdate();

	}
	
}
