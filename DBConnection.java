package empDetails;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DBConnection {
	private Connection con;
	private List<Employee> empList;
	private PreparedStatement ps;
	private ResultSet rs;

	DBConnection() throws Exception {
		Class.forName("org.postgresql.Driver");
		con = DriverManager.getConnection("jdbc:postgresql://192.168.110.48:5432/plf_training", "plf_training_admin",
				"pff123");
	}

	public List<Employee> getEmployees() throws SQLException {
		empList = new ArrayList<>();
		ps = con.prepareStatement("select * from nmurthy_emp");
		rs = ps.executeQuery();
		while (rs.next()) {
			empList.add(new Employee(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getDouble(4), rs.getInt(5),
					rs.getDate(6)));
		}
		return empList;
	}

	public int insertRow(int empno, String ename, String job, Double sal, int deptno, Date hire_date)
			throws SQLException {
		String sql = "INSERT INTO nmurthy_emp (emp_no, emp_name, job, salary, dept_no, hire_date) VALUES (?, ?, ?, ?, ?, ?)";
		ps = con.prepareStatement(sql);
		ps.setInt(1, empno);
		ps.setString(2, ename);
		ps.setString(3, job);
		ps.setDouble(4, sal);
		ps.setInt(5, deptno);
		ps.setDate(6, hire_date);
		int rowsAffected = ps.executeUpdate();
		return rowsAffected;
	}

	public int deleteRow(int empno) throws SQLException {
		System.out.println("hii");
		ps = con.prepareStatement("delete  from nmurthy_emp where emp_no=?");
		ps.setInt(1, empno);
		int res = ps.executeUpdate();
		return res;
	}

	public int updateRow(int empId, String updatedName, String updatedJob, double updatedSalary, int updatedDeptNo,
			Date updatedHireDate) throws SQLException {
		String sql = "UPDATE nmurthy_emp SET emp_name=?, job=?, salary=?, dept_no=?, hire_date=? WHERE emp_no=?";
		ps = con.prepareStatement(sql);
		ps.setString(1, updatedName);
		ps.setString(2, updatedJob);
		ps.setDouble(3, updatedSalary);
		ps.setInt(4, updatedDeptNo);
		ps.setDate(5, updatedHireDate);
		ps.setInt(6, empId);
		int rowsUpdated = ps.executeUpdate();
		return rowsUpdated;
	}
}
