package com.example.mydemo.dao;

import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.example.mydemo.model.User;

@Repository
public interface UserDAO extends MongoRepository<User, ObjectId>{
	
	User findById(String id);

}
