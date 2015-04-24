package org.synyx.web;

import com.google.gson.Gson;

import com.taskadapter.redmineapi.RedmineException;
import com.taskadapter.redmineapi.RedmineManager;
import com.taskadapter.redmineapi.bean.TimeEntry;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import org.synyx.dao.BookEntryDAO;
import org.synyx.dao.RedmineDAO;

import org.synyx.domain.BookEntry;
import org.synyx.domain.Redmine;
import org.synyx.domain.Tracking;


/**
 * @author  Aljona Murygina <murygina@synyx.de>
 */
@Controller
public class TrackingController {

    @Autowired
    private BookEntryDAO bookEntryDAO;

    @Autowired
    private RedmineDAO redmineDAO;

    @RequestMapping(method = RequestMethod.GET, value = "tracking")
    public String getTrackingPage(Model model) {

        return "tracking";
    }


    @RequestMapping(method = RequestMethod.POST, value = "bookings/track")
    @ResponseBody
    public String trackBookEntryInRedmine(@RequestBody String json) throws RedmineException {

        Gson gson = new Gson();

        Tracking tracking = gson.fromJson(json, Tracking.class);

        Integer bookEntryId = tracking.getIds().get(0);
        BookEntry bookEntry = bookEntryDAO.findOne(bookEntryId);

        /**
         * time_entry (required): a hash of the time entry attributes, including: issue_id or project_id (only one is
         * required): the issue id or project id to log time on spent_on: the date the time was spent (default to the
         * current date) hours (required): the number of spent hours activity_id: the id of the time activity. This
         * parameter is required unless a default activity is defined in Redmine. comments: short description for the entry
         * (255 characters max)
         */
        TimeEntry timeEntry = new TimeEntry();
        timeEntry.setIssueId(bookEntry.getIssueId());
        timeEntry.setSpentOn(bookEntry.getDate().toDate());
        timeEntry.setHours(tracking.getDuration());
        timeEntry.setActivityId(bookEntry.getActivityId());
        timeEntry.setComment(tracking.getComment());

        Redmine redmine = redmineDAO.findOne(bookEntry.getRedmineId());
        RedmineManager manager = new RedmineManager(redmine.getLink(), redmine.getApiKey());

        try {
            manager.createTimeEntry(timeEntry);

            for (Integer id : tracking.getIds()) {
                BookEntry entry = bookEntryDAO.findOne(id);
                entry.setTracked(true);
                bookEntryDAO.save(entry);
            }

            return "Successfully booked entries: " + tracking.getIds().toString();
        } catch (RedmineException ex) {
            throw ex;
        }
    }
}
