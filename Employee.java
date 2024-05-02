package empDetails;

import java.sql.Date;

public class Employee {
	private int emp_no;
	private String emp_name;
	private String emp_job;
	private double sal;
	private int dept_no;
	private Date Hire_Date;

	public Employee(int emp_no, String emp_name, String emp_job, double sal, int dept_no, Date hire_Date) {
		super();
		this.emp_no = emp_no;
		this.emp_name = emp_name;
		this.emp_job = emp_job;
		this.sal = sal;
		this.dept_no = dept_no;
		Hire_Date = hire_Date;
	}

	public int getEmp_no() {
		return emp_no;
	}

	public void setEmp_no(int emp_no) {
		this.emp_no = emp_no;
	}

	public String getEmp_name() {
		return emp_name;
	}

	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}

	public String getEmp_job() {
		return emp_job;
	}

	public void setEmp_job(String emp_job) {
		this.emp_job = emp_job;
	}

	public double getSal() {
		return sal;
	}

	public void setSal(double sal) {
		this.sal = sal;
	}

	public int getDept_no() {
		return dept_no;
	}

	public void setDept_no(int dept_no) {
		this.dept_no = dept_no;
	}

	public Date getHire_Date() {
		return Hire_Date;
	}

	public void setHire_Date(Date hire_Date) {
		Hire_Date = hire_Date;
	}

}
