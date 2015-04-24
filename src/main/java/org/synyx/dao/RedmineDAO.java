package org.synyx.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.synyx.domain.BookEntry;
import org.synyx.domain.Redmine;

/**
 * @author Aljona Murygina <murygina@synyx.de>
 */
@Repository
public interface RedmineDAO extends JpaRepository<Redmine, Integer> {
}
