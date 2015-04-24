package org.synyx.web;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import com.taskadapter.redmineapi.RedmineException;
import com.taskadapter.redmineapi.RedmineManager;
import com.taskadapter.redmineapi.bean.Issue;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import org.synyx.dao.BookEntryDAO;
import org.synyx.dao.RedmineDAO;

import org.synyx.domain.BookEntry;
import org.synyx.domain.Redmine;

import java.lang.reflect.Type;

import java.util.List;


/**
 * @author  Aljona Murygina <murygina@synyx.de>
 */
@Controller
public class BookEntriesController {

    @Autowired
    private BookEntryDAO bookEntryDAO;

    @Autowired
    private RedmineDAO redmineDAO;

    @RequestMapping(method = RequestMethod.POST, value = "bookings")
    @ResponseBody
    public String saveBookEntry(@RequestBody String json) throws RedmineException {

        Gson gson = new Gson();
        Type type = new TypeToken<BookEntry>() {
            }.getType();
        BookEntry bookEntry = gson.fromJson(json, type);

        Redmine redmine = redmineDAO.findOne(bookEntry.getRedmineId());

        RedmineManager manager = new RedmineManager(redmine.getLink(), redmine.getApiKey());

        Issue issue = manager.getIssueById(bookEntry.getIssueId());

        String title = String.format("#%d %s", bookEntry.getIssueId(), issue.getSubject());

        bookEntry.setTitle(title);

        bookEntryDAO.save(bookEntry);

        return "Successfully saved entry: " + json;
    }


    @RequestMapping(method = RequestMethod.DELETE, value = "bookings/{id}")
    @ResponseBody
    public String deleteBookEntry(@PathVariable("id") Integer id) {

        bookEntryDAO.delete(id);

        return "Successfully deleted entry: " + id;
    }


    @RequestMapping(method = RequestMethod.GET, value = "bookings", produces = "application/json; charset=utf-8")
    @ResponseBody
    public String getBookEntries() {

        Gson gson = new Gson();
        Type type = new TypeToken<List<BookEntry>>() {
            }.getType();

        List<BookEntry> bookEntries = bookEntryDAO.findAll();

        return gson.toJson(bookEntries, type);
    }
}
