package com.pack;

public class Employee {
	int empno;
	String name;
	String job;
	Double sal;
	int dept;
	public Employee(int empno, String name, String job, Double sal, int dept) {
		super();
		this.empno = empno;
		this.name = name;
		this.job = job;
		this.sal = sal;
		this.dept = dept;
	}
	public int getEmpno() {
		return empno;
	}
	public void setEmpno(int empno) {
		this.empno = empno;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public Double getSal() {
		return sal;
	}
	public void setSal(Double sal) {
		this.sal = sal;
	}
	public int getDept() {
		return dept;
	}
	public void setDept(int dept) {
		this.dept = dept;
	}

}
