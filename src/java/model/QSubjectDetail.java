/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;


/**
 *
 * @author ADMIN
 */
public class QSubjectDetail {
    private int subject_id;
    private String userName;
    private String email;
    private String phone;
    private int gender;
    private String fullName;
    private String facebook;
    private String twitter;
    private String instagram;
    private String description;
    private String subject_name;
    private String subject_img;
    private String subject_content;
    private String subject_title;

    public QSubjectDetail() {
    }

    public QSubjectDetail(int subject_id, String userName, String email, String phone, int gender, String fullName, String facebook, String twitter, String instagram, String description, String subject_name, String subject_img, String subject_content, String subject_title) {
        this.subject_id = subject_id;
        this.userName = userName;
        this.email = email;
        this.phone = phone;
        this.gender = gender;
        this.fullName = fullName;
        this.facebook = facebook;
        this.twitter = twitter;
        this.instagram = instagram;
        this.description = description;
        this.subject_name = subject_name;
        this.subject_img = subject_img;
        this.subject_content = subject_content;
        this.subject_title = subject_title;
    }

    public int getSubject_id() {
        return subject_id;
    }

    public void setSubject_id(int subject_id) {
        this.subject_id = subject_id;
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

    public String getSubject_name() {
        return subject_name;
    }

    public void setSubject_name(String subject_name) {
        this.subject_name = subject_name;
    }

    public String getSubject_img() {
        return subject_img;
    }

    public void setSubject_img(String subject_img) {
        this.subject_img = subject_img;
    }

    public String getSubject_content() {
        return subject_content;
    }

    public void setSubject_content(String subject_content) {
        this.subject_content = subject_content;
    }

    public String getSubject_title() {
        return subject_title;
    }

    public void setSubject_title(String subject_title) {
        this.subject_title = subject_title;
    }
    
   

}
