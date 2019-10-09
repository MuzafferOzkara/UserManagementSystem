package com.example.mydemo;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.context.junit4.SpringRunner;

import com.example.mydemo.dao.UserDAO;
import com.example.mydemo.model.User;

@RunWith(SpringRunner.class)
@SpringBootTest
public class MydemoApplicationTests {

//	@Test
//	public void contextLoads() {
//	}
	
	@MockBean
	private UserDAO userDAO;
	
	@Test
	public void getUsersTest() {
		when(userDAO.findAll()).thenReturn(Stream.of(
				new User("11111","Emre","Emre","111111111"),
				new User("12331","Mert","Mert","221232333")).collect(Collectors.toList()));
		assertEquals(2,userDAO.findAll().size());
		System.out.println("Get users: "+userDAO.findAll());
		
	}

	
	@Test
	public void saveUserTest() {
		User user = new User("444AB","Emre","Emre","23452223");
		when(userDAO.save(user)).thenReturn(user);
		assertEquals(user,userDAO.save(user));
		System.out.println("Save user: "+userDAO.save(user));
	}
	
	@Test
	public void deleteUserTest() {
		User user = new User("444AB","Emre","Emre","23452223");
		userDAO.delete(user);
		verify(userDAO, times(1)).delete(user);
		System.out.println("Delete user");
	}
	
	
	

}
