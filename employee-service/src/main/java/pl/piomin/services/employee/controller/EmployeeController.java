package pl.piomin.services.employee.controller;

import java.util.List;

import client.DepartmentClient;
import client.Employee;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import org.springframework.web.client.RestTemplate;
import pl.piomin.services.employee.repository.EmployeeRepository;

@RestController
public class EmployeeController {

	private static final Logger LOGGER = LoggerFactory.getLogger(EmployeeController.class);
	
	@Autowired
	EmployeeRepository repository;

	@Autowired
	DepartmentClient departmentClient;

	@GetMapping("/hello/default")
	public String hello() {
		return "hello from employee";
	}


	@GetMapping("/hello/department")
	public String helloD() {
		System.out.println("call /hello/department");
		return departmentClient.hello();
	}


	@PostMapping("/")
	public Employee add(@RequestBody Employee employee) {
		LOGGER.info("Employee add: {}", employee);
		return repository.save(employee);
	}
	
	@GetMapping("/{id}")
	public Employee findById(@PathVariable("id") String id) {
		LOGGER.info("Employee find: id111111={}", id);
		return repository.findById(id).get();
	}
	
	@GetMapping("/")
	public Iterable<Employee> findAll() {
		LOGGER.info("Employee find");
		return repository.findAll();
	}
	
	@GetMapping("/department/{departmentId}")
	public List<Employee> findByDepartment(@PathVariable("departmentId") Long departmentId) {
		LOGGER.info("Employee find: departmentId={}", departmentId);
		return repository.findByDepartmentId(departmentId);
	}
	
	@GetMapping("/organization/{organizationId}")
	public List<Employee> findByOrganization(@PathVariable("organizationId") Long organizationId) {
		LOGGER.info("Employee find: organizationId={}", organizationId);
		return repository.findByOrganizationId(organizationId);
	}
	
}
