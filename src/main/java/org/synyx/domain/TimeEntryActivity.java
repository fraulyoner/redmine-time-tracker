package org.synyx.domain;

import org.springframework.data.jpa.domain.AbstractPersistable;

import javax.persistence.Entity;
import javax.persistence.ManyToOne;

/**
 * @author Aljona Murygina <murygina@synyx.de>
 */
@Entity
public class TimeEntryActivity extends AbstractPersistable<Integer> {

    private Integer activityId;

    private String name;

    @ManyToOne
    private Redmine redmine;

    public Integer getActivityId() {
        return activityId;
    }

    public void setActivityId(Integer activityId) {
        this.activityId = activityId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Redmine getRedmine() {
        return redmine;
    }

    public void setRedmine(Redmine redmine) {
        this.redmine = redmine;
    }
}
