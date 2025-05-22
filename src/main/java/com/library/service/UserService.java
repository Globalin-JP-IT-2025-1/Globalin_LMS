package com.library.service;

import org.springframework.stereotype.Service;

import com.library.model.User;
import com.library.repository.UserRepository;

import java.util.List;

@Service
public class UserService {
    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }
    
    public User getUser(long id) {
        return userRepository.getUser(id);
    }

    public List<User> getUserList() {
        return userRepository.getUserList();
    }
    
    public void registerUser(User user) {
    	userRepository.registerUser(user);
    }
    
    public boolean checkUserInfo(String userid, String password) {
    	return userRepository.checkUserInfo(userid, password);
    }

}

