package org.synyx.web;

import org.joda.time.DateTime;
import org.joda.time.DateTimeConstants;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.synyx.dao.BookEntryDAO;

import org.synyx.domain.BookEntry;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;


/**
 * @author  Aljona Murygina <murygina@synyx.de>
 */
@Controller
public class WeeksController {

    @Autowired
    private BookEntryDAO bookEntryDAO;

    @RequestMapping(method = RequestMethod.GET, value = "weeks")
    public String getBookEntries(Model model) {

        SortedMap<Integer, Map<Integer, Double>> calendarWeekStatistics = new TreeMap<Integer, Map<Integer, Double>>();
        int weekOfWeekyear = DateTime.now().getWeekOfWeekyear();

        for (int i = weekOfWeekyear; i > weekOfWeekyear - 5; i--) {
            List<BookEntry> entries = bookEntryDAO.getBookEntriesForWeekOfYear(i);

            Map<Integer, Double> weekDurations = new HashMap<Integer, Double>();

            // init
            for (int dayOfWeek = DateTimeConstants.MONDAY; dayOfWeek < DateTimeConstants.SATURDAY; dayOfWeek++) {
                weekDurations.put(dayOfWeek, 0.0);
            }

            // fill
            for (BookEntry entry : entries) {
                int dayOfWeek = entry.getDate().getDayOfWeek();
                Double duration = weekDurations.get(dayOfWeek);
                Double newDuration = duration + entry.getDuration();
                weekDurations.put(dayOfWeek, newDuration);
            }

            calendarWeekStatistics.put(i, weekDurations);
        }

        model.addAttribute("statistics", calendarWeekStatistics);

        return "weeks";
    }
}
