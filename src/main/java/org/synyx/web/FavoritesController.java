package org.synyx.web;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import com.taskadapter.redmineapi.RedmineException;
import com.taskadapter.redmineapi.RedmineManager;
import com.taskadapter.redmineapi.bean.Issue;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import org.synyx.dao.BookEntryDAO;
import org.synyx.dao.FavoriteDAO;
import org.synyx.dao.RedmineDAO;

import org.synyx.domain.BookEntry;
import org.synyx.domain.Favorite;
import org.synyx.domain.Redmine;

import java.lang.reflect.Type;

import java.util.List;


/**
 * @author  Aljona Murygina <murygina@synyx.de>
 */
@Controller
public class FavoritesController {

    @Autowired
    private FavoriteDAO favoriteDAO;

    @Autowired
    private RedmineDAO redmineDAO;

    @Autowired
    private BookEntryDAO bookEntryDAO;

    @RequestMapping(method = RequestMethod.GET, value = "favorites", produces = "application/json; charset=utf-8")
    @ResponseBody
    public String getFavorites() {

        Gson gson = new Gson();
        Type type = new TypeToken<List<Favorite>>() {
            }.getType();

        List<Favorite> favorites = favoriteDAO.findAll();

        return gson.toJson(favorites, type);
    }


    @RequestMapping(method = RequestMethod.POST, value = "favorites")
    @ResponseBody
    public String saveFavorite(@RequestBody String json) throws RedmineException {

        Gson gson = new Gson();
        Type type = new TypeToken<Favorite>() {
            }.getType();
        Favorite favorite = gson.fromJson(json, type);

        Redmine redmine = redmineDAO.findOne(favorite.getRedmineId());

        RedmineManager manager = new RedmineManager(redmine.getLink(), redmine.getApiKey());

        Issue issue = manager.getIssueById(favorite.getIssueId());

        String title = String.format("%s - #%d %s", issue.getProject().getName(), favorite.getIssueId(),
                issue.getSubject());

        favorite.setTitle(title);

        favoriteDAO.save(favorite);

        return "Successfully saved favorite: " + json;
    }


    @RequestMapping(method = RequestMethod.POST, value = "favorites/book")
    @ResponseBody
    public String bookFavorite(@RequestBody String json) {

        Gson gson = new Gson();
        Type type = new TypeToken<BookFavoriteRequest>() {
            }.getType();
        BookFavoriteRequest bookFavoriteRequest = gson.fromJson(json, type);

        Favorite favorite = favoriteDAO.findOne(bookFavoriteRequest.getFavoriteId());

        BookEntry bookEntry = favorite.generateBookEntry(bookFavoriteRequest.getDay(), bookFavoriteRequest.getColor());

        bookEntryDAO.save(bookEntry);

        return "Successfully booked favorite with id " + bookFavoriteRequest.getFavoriteId();
    }


    @RequestMapping(method = RequestMethod.DELETE, value = "favorites/{id}")
    @ResponseBody
    public String removeFavorite(@PathVariable("id") Integer id) {

        favoriteDAO.delete(id);

        return "Successfully deleted favorite with id: " + String.valueOf(id);
    }

    private class BookFavoriteRequest {

        private Integer favoriteId;
        private String day;
        private String color;

        private Integer getFavoriteId() {

            return favoriteId;
        }


        private void setFavoriteId(Integer favoriteId) {

            this.favoriteId = favoriteId;
        }


        private String getDay() {

            return day;
        }


        private void setDay(String day) {

            this.day = day;
        }


        private String getColor() {

            return color;
        }


        private void setColor(String color) {

            this.color = color;
        }
    }
}
