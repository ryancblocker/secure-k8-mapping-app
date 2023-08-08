package com.example.springboot;

import org.springframework.stereotype.Controller;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.view.RedirectView;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Scanner;

@RestController
@Controller
public class HelloController {

@GetMapping("/")
public ResponseEntity<String> showLoginPage() throws IOException {
	Resource resource = new ClassPathResource("static/homepage.html");
	String htmlContent;
	try (Scanner scanner = new Scanner(resource.getInputStream(), StandardCharsets.UTF_8)) {
		htmlContent = scanner.useDelimiter("\\A").next();
	}
	return ResponseEntity.ok().body(htmlContent);
}

@GetMapping("/redirect")
public ResponseEntity<String> showLogoutPage() throws IOException {
	Resource resource = new ClassPathResource("static/logout.html");
	String htmlContent;
	try (Scanner scanner = new Scanner(resource.getInputStream(), StandardCharsets.UTF_8)) {
		htmlContent = scanner.useDelimiter("\\A").next();
	}
	return ResponseEntity.ok().body(htmlContent);
}

@GetMapping("/search")
public ResponseEntity<String> showSearchPage() throws IOException {
	Resource resource = new ClassPathResource("static/kibana.html");
	String htmlContent;
	try (Scanner scanner = new Scanner(resource.getInputStream(), StandardCharsets.UTF_8)) {
		htmlContent = scanner.useDelimiter("\\A").next();
	}
	return ResponseEntity.ok().body(htmlContent);
}
}
