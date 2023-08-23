<%@ page language="java" import="java.util.*,java.sql.*,com.pack.Employee" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>employee details</title>
</head>
<body>
	<form action="Selfsub.jsp" method="get">

		<h1>Employee details</h1>
		<label>employee number</label> <input type="text" id="enum"
			name="numc"><br>
		<br> <label> employee name</label> <input type="text" id="ename"
			name="namec"><br>
		<br> <label>job</label> <input type="text" id="job" name="jobc"><br>
		<br> <label>salary</label> <input type="text" id="sal"
			name="salc"><br>
		<br> <label>dept number</label> <input type="text" id="dept"
			name="deptc"><br>
		<br>


		<button type="submit" name="n" value="first" class="first">First</button>
		<button type="submit" name="n" value="last" class="last">Last</button>
		<button type="submit" name="n" value="next" class="next">Next</button>
		<button type="submit" name="n" value="prev" class="prev">Previous</button>
		<button type="submit" name="n" value="search" class="search">Search</button>
		<br>
		<br>
		<button type="submit" name="n" value="edit" class="edit">Edit</button>
		<button type="submit" name="n" value="add" class="add">Add</button>
		<button type="submit" name="n" value="save" class="save">Save</button>
		<button type="submit" name="n" value="delete" class="delete">Delete</button>
		<br>
		<br>
		<button type="submit" name="n" value="clear1" class="clear1">Clear</button>
		<select name="sel" value="select" id="s">
			<option>---</option>
			<option value="add">add</option>

			<option value="edit">edit</option>

		</select>
	</form>
	<%
	//database connection

	Class.forName("org.postgresql.Driver");
	Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres",
			"pff123");

	PreparedStatement ps = con.prepareStatement("Select * from Employees");
	ResultSet rs = ps.executeQuery();
	
	System.out.println(rs);
	//arraylist
	ArrayList<Employee> elist = new ArrayList<>();
	while (rs.next()) {
		int eno = rs.getInt(1);
		String ename = rs.getString(2);
		String ejob = rs.getString(3);
		Double esal = rs.getDouble(4);
		int edept = rs.getInt(5);

		Employee e = new Employee(eno, ename, ejob, esal, edept);
		elist.add(e);
	}

	//session

	HttpSession ses = request.getSession();
	ses.setAttribute("alist", elist);
	System.out.println(ses.getAttribute("alist")+"arraylist");
	int eno = 0;
	String ename = "";
	String ejob = "";
	double esal = 0;
	int edept = 0;

	String mo = request.getParameter("n");
	if (mo != null && mo.equals("first")) {
		int c = 0;
		ses.setAttribute("cur", c);
		ArrayList<Employee> l = (ArrayList<Employee>) ses.getAttribute("alist");
		eno = l.get(c).getEmpno();
		ename = l.get(c).getName();
		ejob = l.get(c).getJob();
		esal = l.get(c).getSal();
		edept = l.get(c).getDept();
		//System.out.println(ename);

	}
	if (mo != null && mo.equals("last")) {

		ArrayList<Employee> l = (ArrayList<Employee>) ses.getAttribute("alist");
		int c = l.size() - 1;
		//System.out.println(c);
		ses.setAttribute("cur", c);
		eno = l.get(c).getEmpno();
		ename = l.get(c).getName();
		ejob = l.get(c).getJob();
		esal = l.get(c).getSal();
		edept = l.get(c).getDept();
		//System.out.println(l.get(c).getDept());

	}
	if (mo != null && mo.equals("next")) {
		int c = (Integer) ses.getAttribute("cur");
		ArrayList<Employee> l = (ArrayList<Employee>) ses.getAttribute("alist");
		c = (c + 1) % l.size();
		ses.setAttribute("cur", c);
		eno = l.get(c).getEmpno();
		ename = l.get(c).getName();
		ejob = l.get(c).getJob();
		esal = l.get(c).getSal();
		edept = l.get(c).getDept();

	}
	if (mo != null && mo.equals("prev")) {
		int c = (Integer) ses.getAttribute("cur");
		ArrayList<Employee> l = (ArrayList<Employee>) ses.getAttribute("alist");
		if (c == 0) {
			c = l.size() - 1;
		} else {
			c = (c - 1);
		}
		ses.setAttribute("cur", c);
		//System.out.println(c+"value");
		eno = l.get(c).getEmpno();
		ename = l.get(c).getName();
		ejob = l.get(c).getJob();
		esal = l.get(c).getSal();
		edept = l.get(c).getDept();
		//System.out.println(l.get(c).getEmpno()+"emp");

	}
	if (mo != null && mo.equals("search")) {
		int a = Integer.parseInt(request.getParameter("numc"));
		ArrayList<Employee> l = (ArrayList<Employee>) ses.getAttribute("alist");
		int c = -1;
		for (Employee e : l) {
			c = c + 1;
			if (e.getEmpno() == a) {

		eno = l.get(c).getEmpno();
		ename = l.get(c).getName();
		ejob = l.get(c).getJob();
		esal = l.get(c).getSal();
		edept = l.get(c).getDept();

			}

		}

	}
	if (mo != null && mo.equals("delete")) {
		System.out.println("deleted");
		int a = Integer.parseInt(request.getParameter("numc"));
		PreparedStatement p = con.prepareStatement("delete from Employees where EmployeeNumber=?");
		p.setInt(1, a);

		PreparedStatement p1 = con.prepareStatement("Select * from Employees");
		ResultSet r1 = ps.executeQuery();
		/* while(rs.next()){
			System.out.println(rs.getInt(1));	
		}
		
		System.out.println(rs);*/
		//arraylist
		elist = new ArrayList<>();
		while (r1.next()) {
			eno = r1.getInt(1);
			ename = r1.getString(2);
			ejob = r1.getString(3);
			esal = r1.getDouble(4);
			edept = r1.getInt(5);

			Employee e = new Employee(eno, ename, ejob, esal, edept);
			elist.add(e);
		}
		ses.setAttribute("alist", elist);

	}
	if (mo != null && mo.equals("edit")) {
		String x = request.getParameter("edit");
	%>
	<script>
	document.getElementById("s").value="edit";
	</script>
	<%
	}
	if (mo != null && mo.equals("add")){
		%>
		<script>
	document.getElementById("s").value="add";
	</script>
		<%
	}
	if (mo != null && mo.equals("save")) {
		String v=request.getParameter("sel");
		System.out.println(v);
		if(v.equals("edit")){
			int v1=Integer.parseInt(request.getParameter("numc"));
			String v2=request.getParameter("namec");
			String v3=request.getParameter("jobc");
			Double v4=Double.parseDouble(request.getParameter("salc"));
			int v5=Integer.parseInt(request.getParameter("deptc"));
			
			PreparedStatement p = con.prepareStatement("UPDATE Employees SET Name=?,Job=?,Salary=?,DeptNo=? WHERE EmployeeNumber= ?");
			p.setString(1, v2);
			p.setString(2, v3);
			p.setDouble(3, v4);
			p.setInt(4, v5);
			p.setInt(5, v1);
			
			p.executeUpdate();
			
			PreparedStatement p1 = con.prepareStatement("Select * from Employees");
			ResultSet r1 = ps.executeQuery();
			/* while(rs.next()){
				System.out.println(rs.getInt(1));	
			}
			
			System.out.println(rs);*/
			//arraylist
			elist = new ArrayList<>();
			while (r1.next()) {
				eno = r1.getInt(1);
				ename = r1.getString(2);
				ejob = r1.getString(3);
				esal = r1.getDouble(4);
				edept = r1.getInt(5);

				Employee e = new Employee(eno, ename, ejob, esal, edept);
				elist.add(e);
			}
			ses.setAttribute("alist", elist);
			
			
			
			
			
			
		}
		
		
	}
	if (mo != null && mo.equals("add")) {
		String v=request.getParameter("sel");
		System.out.println(v);
		if(v.equals("add")){
			int v1=Integer.parseInt(request.getParameter("numc"));
			String v2=request.getParameter("namec");
			String v3=request.getParameter("jobc");
			Double v4=Double.parseDouble(request.getParameter("salc"));
			int v5=Integer.parseInt(request.getParameter("deptc"));
			
			PreparedStatement p = con.prepareStatement("insert into Employees(EmployeeNumber,Name,Job,Salary,DeptNo) values(?,?,?,?,?) ");
			p.setInt(1, v1);
			p.setString(2, v2);
			p.setString(3, v3);
			p.setDouble(4, v4);
			p.setInt(5, v5);
			
			
			p.executeUpdate();
			
			PreparedStatement p1 = con.prepareStatement("Select * from Employees");
			ResultSet r1 = ps.executeQuery();
			/* while(rs.next()){
				System.out.println(rs.getInt(1));	
			}
			
			System.out.println(rs);*/
			//arraylist
			elist = new ArrayList<>();
			while (r1.next()) {
				eno = r1.getInt(1);
				ename = r1.getString(2);
				ejob = r1.getString(3);
				esal = r1.getDouble(4);
				edept = r1.getInt(5);

				Employee e = new Employee(eno, ename, ejob, esal, edept);
				elist.add(e);
			}
			ses.setAttribute("alist", elist);
			
			
			
			
			
			
		}
		
		
	}
	
	
	
	
	%>
	
	
	
	<script>
document.getElementById("enum").value='<%=eno%>';
document.getElementById("ename").value='<%=ename%>';

document.getElementById("job").value='<%=ejob%>';

document.getElementById("sal").value='<%=esal%>';

document.getElementById("dept").value='<%=edept%>';
	</script>



</body>
</html>