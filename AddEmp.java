package empDetails;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddEmp")
public class AddEmp extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DBConnection dc;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			dc = new DBConnection();
			int empNo = Integer.parseInt(request.getParameter("empNo"));
			String name = request.getParameter("name");
			String job = request.getParameter("job");
			double salary = Double.parseDouble(request.getParameter("salary"));
			int deptNo = Integer.parseInt(request.getParameter("deptNo"));
			Date hireDate = Date.valueOf(request.getParameter("hireDate"));
			int res = dc.insertRow(empNo, name, job, salary, deptNo, hireDate);
			response.setContentType("text");
			response.getWriter().println("hi");
		} catch (Exception e) {
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
