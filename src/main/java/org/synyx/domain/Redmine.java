package org.synyx.domain;

import org.springframework.data.jpa.domain.AbstractPersistable;

import javax.persistence.Entity;


/**
 * @author  Aljona Murygina <murygina@synyx.de>
 */
@Entity
public class Redmine extends AbstractPersistable<Integer> {

    private String name;

    private String link;

    private String apiKey;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getApiKey() {
        return apiKey;
    }

    public void setApiKey(String apiKey) {
        this.apiKey = apiKey;
    }

    @Override
    public void setId(Integer id) {
        super.setId(id);
    }
}
