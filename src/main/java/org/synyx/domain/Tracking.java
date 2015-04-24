package org.synyx.domain;

import java.util.List;


/**
 * @author  Aljona Murygina <murygina@synyx.de>
 */
public class Tracking {

    private List<Integer> ids;
    private String comment;
    private String color;
    private float duration;

    public List<Integer> getIds() {

        return ids;
    }


    public void setIds(List<Integer> ids) {

        this.ids = ids;
    }


    public String getComment() {

        return comment;
    }


    public void setComment(String comment) {

        this.comment = comment;
    }


    public String getColor() {

        return color;
    }


    public void setColor(String color) {

        this.color = color;
    }


    public float getDuration() {

        return duration;
    }


    public void setDuration(float duration) {

        this.duration = duration;
    }
}
