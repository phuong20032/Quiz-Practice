/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author ADMIN
 */
public class User {

    private int user_id;
    private String userName;
    private String email;
    private String password;
    private String phone;
    private int gender;
    private String fullName;
    private String school;
    private String facebook;
    private String twitter;
    private String instagram;
    private String description;
    private Date create_at;
    private Role role;
    private int status;
    public User() {
    }

    // Constructor used for RegisterDao to check email:
    public User(String email) {
        this.email = email;
    }

    // Constructor used for check Login if user input invalid information:
    public User(String email, String password) {
        this.email = email;
        this.password = password;
    }

    public User(int user_id, String userName, String email, String password, String phone, int gender, String fullName, String school, String facebook, String twitter, String instagram, String description, Date create_at, Role role) {
        this.user_id = user_id;
        this.userName = userName;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.gender = gender;
        this.fullName = fullName;
        this.school = school;
        this.facebook = facebook;
        this.twitter = twitter;
        this.instagram = instagram;
        this.description = description;
        this.create_at = create_at;
        this.role = role;
    }
    public User(int user_id, String userName, String email, String password, String phone, int gender, String fullName, String school, String facebook, String twitter, String instagram, String description, Date create_at, Role role, int status) {
        this.user_id = user_id;
        this.userName = userName;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.gender = gender;
        this.fullName = fullName;
        this.school = school;
        this.facebook = facebook;
        this.twitter = twitter;
        this.instagram = instagram;
        this.description = description;
        this.create_at = create_at;
        this.role = role;
        this.status = status;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getSchool() {
        return school;
    }

    public void setSchool(String school) {
        this.school = school;
    }

    public String getFacebook() {
        return facebook;
    }

    public void setFacebook(String facebook) {
        this.facebook = facebook;
    }

    public String getTwitter() {
        return twitter;
    }

    public void setTwitter(String twitter) {
        this.twitter = twitter;
    }

    public String getInstagram() {
        return instagram;
    }

    public void setInstagram(String instagram) {
        this.instagram = instagram;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreate_at() {
        return create_at;
    }

    public void setCreate_at(Date create_at) {
        this.create_at = create_at;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "User{" + "user_id=" + user_id + ", userName=" + userName + ", email=" + email + ", password=" + password + ", phone=" + phone + ", gender=" + gender + ", fullName=" + fullName + ", school=" + school + ", facebook=" + facebook + ", twitter=" + twitter + ", instagram=" + instagram + ", description=" + description + ", create_at=" + create_at + ", role=" + role + ", status=" + status + '}';
    }

    
    
}
