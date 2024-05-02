package empDetails;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

@WebServlet("/EmployessServelet")
public class EmployessServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private List<Employee> empList;
	DBConnection dc;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			dc = new DBConnection();
			empList = dc.getEmployees();
			Gson gson = new Gson();

			// Convert empList to JSON using Gson
			String json = gson.toJson(empList);

			// Set response content type to JSON
			response.setContentType("application/json");

			// Get PrintWriter
			PrintWriter out = response.getWriter();

			// Write JSON string to response
			out.print(json);

		} catch (Exception e) {
			System.out.println(e);

		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}