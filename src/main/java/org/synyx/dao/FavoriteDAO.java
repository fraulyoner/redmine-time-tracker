package org.synyx.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.synyx.domain.BookEntry;
import org.synyx.domain.Favorite;

import java.util.List;

/**
 * @author Aljona Murygina <murygina@synyx.de>
 */
@Repository
public interface FavoriteDAO extends JpaRepository<Favorite, Integer> {

}
