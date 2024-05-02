package empDetails;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateEmployee
 */
@WebServlet("/UpdateEmployee")
public class UpdateEmployee extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DBConnection dc;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int empId = Integer.parseInt(request.getParameter("empNo"));
		String updatedName = request.getParameter("name");
		String updatedJob = request.getParameter("job");
		double updatedSalary = Double.parseDouble(request.getParameter("salary"));
		int updatedDeptNo = Integer.parseInt(request.getParameter("deptNo"));
		Date hireDate = Date.valueOf(request.getParameter("hireDate"));
		try {
			dc = new DBConnection();
			int res = dc.updateRow(empId, updatedName, updatedJob, updatedSalary, updatedDeptNo, hireDate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
