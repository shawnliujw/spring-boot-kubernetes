package pl.piomin.services.employee.repository;

import java.util.List;

import client.Employee;
import org.springframework.data.repository.CrudRepository;


public interface EmployeeRepository extends CrudRepository<Employee, String> {
	
	List<Employee> findByDepartmentId(Long departmentId);
	List<Employee> findByOrganizationId(Long organizationId);
	
}
