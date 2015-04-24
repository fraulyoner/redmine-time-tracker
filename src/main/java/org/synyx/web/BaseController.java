package org.synyx.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.synyx.dao.RedmineDAO;


@Controller
@RequestMapping("/")
public class BaseController {

    @Autowired
    private RedmineDAO redmineDAO;

    @RequestMapping(method = RequestMethod.GET)
    public String index(Model model) {

        model.addAttribute("redmines", redmineDAO.findAll());

        return "index";
    }

}
