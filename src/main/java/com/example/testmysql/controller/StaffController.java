package com.example.testmysql.controller;

import com.example.testmysql.repository.StaffRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class StaffController {

    @Autowired
    private StaffRepository staffRepository;

    @GetMapping("/staff")
    public String showStaffList(Model model) {
        model.addAttribute("staffList", staffRepository.findAll());
        return "staff-list";
    }
}
