package org.synyx.domain;

import org.joda.time.DateTime;

import org.springframework.data.jpa.domain.AbstractPersistable;

import javax.persistence.Entity;


/**
 * @author  Aljona Murygina <murygina@synyx.de>
 */
@Entity
public class Favorite extends AbstractPersistable<Integer> {

    private Integer redmineId;

    private Integer issueId;

    private String title;

    private String start;

    private String end;

    private double duration;

    private String comment;

    private boolean allDay;

    public String getTitle() {

        return title;
    }


    public void setTitle(String title) {

        this.title = title;
    }


    public String getStart() {

        return start;
    }


    public void setStart(String start) {

        this.start = start;
    }


    public String getEnd() {

        return end;
    }


    public void setEnd(String end) {

        this.end = end;
    }


    public double getDuration() {

        return duration;
    }


    public void setDuration(double duration) {

        this.duration = duration;
    }


    public boolean isAllDay() {

        return allDay;
    }


    public void setAllDay(boolean allDay) {

        this.allDay = allDay;
    }


    public String getComment() {

        return comment;
    }


    public void setComment(String comment) {

        this.comment = comment;
    }


    public Integer getRedmineId() {

        return redmineId;
    }


    public void setRedmineId(Integer redmineId) {

        this.redmineId = redmineId;
    }


    public Integer getIssueId() {

        return issueId;
    }


    public void setIssueId(Integer issueId) {

        this.issueId = issueId;
    }


    @Override
    protected void setId(Integer id) {

        super.setId(id);
    }


    public BookEntry generateBookEntry(String day) {

        BookEntry bookEntry = new BookEntry();

        bookEntry.setRedmineId(this.redmineId);
        bookEntry.setIssueId(this.issueId);
        bookEntry.setTitle(this.title);
        bookEntry.setDay(day);

        String[] startArray = this.start.split(":");
        String[] endArray = this.end.split(":");

        DateTime startTime = DateTime.parse(day).withTime(Integer.parseInt(startArray[0]),
                Integer.parseInt(startArray[1]), 0, 0);
        DateTime endTime = DateTime.parse(day).withTime(Integer.parseInt(endArray[0]), Integer.parseInt(endArray[1]), 0,
                0);

        String start = startTime.toString();
        String end = endTime.toString();

        bookEntry.setStart(start);
        bookEntry.setEnd(end);

        bookEntry.setDuration(this.duration);
        bookEntry.setComment(this.comment);
        bookEntry.setAllDay(this.allDay);

        return bookEntry;
    }
}
