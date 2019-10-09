package com.example.mydemo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.mydemo.dao.UserDAO;
import com.example.mydemo.model.User;

@RestController
@RequestMapping
public class UserController {
	
	@Autowired
	private UserDAO userDAO;	

	
	@RequestMapping(value="/list", method=RequestMethod.POST)
    public @ResponseBody Map<String,Object> getAll(User user){
        Map<String,Object> map = new HashMap<String,Object>();
     
            List<User> list = userDAO.findAll();
             
            if (list != null){
                map.put("status","200");
                map.put("message","Data found");
                map.put("data", list);
            }else{
                map.put("status","404");
                map.put("message","Data not found");
                 
            }
         
        return map;
    }
	

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public User getPetById(@PathVariable("id") String id) {
	  return userDAO.findById(id);
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.PUT)
	public void modifyPetById(@PathVariable("id") String id, @Valid @RequestBody User user) {
	  user.setId(id);
	  userDAO.save(user);
	}
	
	
	
	@RequestMapping(value = "save", method = RequestMethod.POST )
	public User createPet(@Valid User user) {
	  
	  userDAO.save(user);
	  return user;
	}
	

	@RequestMapping(value = "updateUser", method = RequestMethod.POST )
	public User upUser(@Valid User user) {
	  user.setId(user.getId());
	  userDAO.save(user);
	  
	  return user;
	}
	
	  @RequestMapping(value = "delete/{id}", method = RequestMethod.DELETE)
	  public @ResponseBody void deletePet(@Valid @PathVariable String id) {	    
	    userDAO.delete(userDAO.findById(id));
	    
	  }
	  
	  
	  
	  @RequestMapping(value = "/" , method = RequestMethod.GET)
	    public ModelAndView index(ModelMap map) {
		  ModelAndView view=new ModelAndView("hello");
	        map.put("hello", userDAO.findAll());
	        
	        return view;
	    }
	  
		@RequestMapping(value = "deleteuser", method = RequestMethod.DELETE )
		public User deleteUser(@Valid User user) {
		  
		  userDAO.delete(user);
		  return user;
		}
	  

}
