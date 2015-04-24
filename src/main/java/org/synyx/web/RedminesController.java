package org.synyx.web;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.synyx.dao.RedmineDAO;

import org.synyx.domain.Redmine;


/**
 * @author  Aljona Murygina <murygina@synyx.de>
 */
@Controller
public class RedminesController {

    @Autowired
    private RedmineDAO redmineDAO;

    @RequestMapping(method = RequestMethod.GET, value = "redmines")
    public String getRedmines(Model model) {

        model.addAttribute("redmines", redmineDAO.findAll());

        return "redmines";
    }


    @RequestMapping(method = RequestMethod.GET, value = "redmines/new")
    public String newRedmine(Model model) {

        model.addAttribute("redmine", new Redmine());

        return "redmine_form";
    }


    @RequestMapping(method = RequestMethod.POST, value = "redmines")
    public String createRedmine(@ModelAttribute("redmine") Redmine redmine) {

        redmineDAO.save(redmine);

        return "redirect:/redmines";
    }


    @RequestMapping(method = RequestMethod.GET, value = "redmines/{redmineId}")
    public String editRedmine(@PathVariable("redmineId") Integer redmineId, Model model) {

        model.addAttribute("redmine", redmineDAO.findOne(redmineId));

        return "redmine_form";
    }


    @RequestMapping(method = RequestMethod.PUT, value = "redmines/{redmineId}")
    public String updateRedmine(@PathVariable("redmineId") Integer redmineId,
        @ModelAttribute("redmine") Redmine redmine) {

        redmineDAO.save(redmine);

        return "redirect:/redmines";
    }
}
