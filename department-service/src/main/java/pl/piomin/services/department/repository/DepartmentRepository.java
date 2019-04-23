package pl.piomin.services.department.repository;

import java.util.List;

import client.Department;
import org.springframework.data.repository.CrudRepository;


public interface DepartmentRepository extends CrudRepository<Department, String> {

	List<Department> findByOrganizationId(Long organizationId);
	
}
