package org.synyx.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import org.springframework.stereotype.Repository;

import org.synyx.domain.BookEntry;

import java.util.List;


/**
 * @author  Aljona Murygina <murygina@synyx.de>
 */
@Repository
public interface BookEntryDAO extends JpaRepository<BookEntry, Integer> {

    @Query("SELECT x FROM BookEntry x WHERE WEEKOFYEAR(x.day) = ?1 AND YEAR(x.day) = YEAR(now())")
    List<BookEntry> getBookEntriesForWeekOfYear(int weekOfYear);
}
