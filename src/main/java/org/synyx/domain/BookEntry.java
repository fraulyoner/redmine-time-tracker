package org.synyx.domain;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;

import org.springframework.data.jpa.domain.AbstractPersistable;

import javax.persistence.Entity;


/**
 * @author  Aljona Murygina <murygina@synyx.de>
 */
@Entity
public class BookEntry extends AbstractPersistable<Integer> {

    private Integer redmineId;

    private Integer issueId;

    private String title;

    private String day;

    private String start;

    private String end;

    private double duration;

    private String comment;

    private boolean allDay;

    private boolean tracked = false;

    public String getTitle() {

        return title;
    }


    public void setTitle(String title) {

        this.title = title;
    }


    public String getDay() {

        return day;
    }


    public void setDay(String date) {

        this.day = date;
    }


    public DateTime getDate() {

        DateTime dateTime = DateTimeFormat.forPattern("yyyy-MM-dd").parseDateTime(getDay());

        return dateTime;
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


    public boolean isTracked() {

        return tracked;
    }


    public void setTracked(boolean tracked) {

        this.tracked = tracked;
    }


    @Override
    protected void setId(Integer id) {

        super.setId(id);
    }
}
