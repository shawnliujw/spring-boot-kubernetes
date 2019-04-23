package client;

import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Configuration
@EnableAutoConfiguration
public class MyConfiguration {

    @Bean
    public  void test() {
        System.out.println("=======================");
        System.out.println("=======================");
        System.out.println("=======================");
        System.out.println("=======================");
        System.out.println("=======================");
        System.out.println("=======================");
        System.out.println("=======================");
        System.out.println("=======================");
        System.out.println("=======================");
        System.out.println("=======================");
        System.out.println("=======================");
        System.out.println("=======================");
        System.out.println("=======================");
        System.out.println("=======================");
    }

    @FeignClient(name = "employee", path = "/employee")
    public static interface EmployeeClient {

        @GetMapping("/department/{departmentId}")
        List<Employee> findByDepartment(@PathVariable("departmentId") String departmentId);

        @GetMapping("/organization/{organizationId}")
        List<Employee> findByOrganization(@PathVariable("organizationId") String organizationId);

    }
}
