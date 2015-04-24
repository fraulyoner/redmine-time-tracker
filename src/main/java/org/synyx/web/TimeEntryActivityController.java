package org.synyx.web;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import com.taskadapter.redmineapi.RedmineException;
import com.taskadapter.redmineapi.RedmineManager;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import org.synyx.dao.RedmineDAO;
import org.synyx.dao.TimeEntryActivityDAO;

import org.synyx.domain.Redmine;
import org.synyx.domain.TimeEntryActivity;

import java.lang.reflect.Type;

import java.util.List;


@Controller
public class TimeEntryActivityController {

    @Autowired
    private TimeEntryActivityDAO activityDAO;

    @Autowired
    private RedmineDAO redmineDAO;

    @RequestMapping(method = RequestMethod.GET, value = "activities", produces = "application/json; charset=utf-8")
    @ResponseBody
    public String getTimeEntryActivities(@RequestParam(value = "redmineId", required = false) Integer redmineId) {

        Gson gson = new Gson();

        Redmine redmine = redmineDAO.findOne(redmineId);

        RedmineManager manager = new RedmineManager(redmine.getLink(), redmine.getApiKey());

        try {
            List<com.taskadapter.redmineapi.bean.TimeEntryActivity> timeEntryActivitiesFetchedFromRedmine =
                manager.getTimeEntryActivities();

            Type type = new TypeToken<List<com.taskadapter.redmineapi.bean.TimeEntryActivity>>() {
                }.getType();

            return gson.toJson(timeEntryActivitiesFetchedFromRedmine, type);
        } catch (RedmineException ex) {
            // NOTE: If not possible to fetch time entry activities from Redmine, then fetch them from database
            // Fetching time entry activities from API is possible only for version >= 2.2.
            Type type = new TypeToken<List<TimeEntryActivity>>() {
                }.getType();

            return gson.toJson(activityDAO.findByRedmine(redmine), type);
        }
    }
}
