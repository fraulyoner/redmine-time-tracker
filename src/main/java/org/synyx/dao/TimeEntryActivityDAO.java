package org.synyx.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.synyx.domain.BookEntry;
import org.synyx.domain.Redmine;
import org.synyx.domain.TimeEntryActivity;

import java.util.List;

/**
 * @author Aljona Murygina <murygina@synyx.de>
 */
@Repository
public interface TimeEntryActivityDAO extends JpaRepository<TimeEntryActivity, Integer> {

    List<TimeEntryActivity> findByRedmine(Redmine redmine);

}
