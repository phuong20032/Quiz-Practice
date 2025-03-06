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
public class Subject {

    private int subject_id;
    private String subject_name;
    private int creator_id;
    private Date created_at;
    private Date updated_at;
    private int status;
    private String subject_img;
    private int major_id;
    private String subject_content;
    private String subject_title;
    private Major major;
    private int total_lesson;
    private String creator_name;
    
    private User owner;
    private int featured_flag;
    
    public Subject() {
    }

    
    
    public Subject(int subject_id, String subject_name, int creator_id, Date created_at, Date updated_at, int status, String subject_img, int major_id, String subject_content, String subject_title, Major major) {
        this.subject_id = subject_id;
        this.subject_name = subject_name;
        this.creator_id = creator_id;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.status = status;
        this.subject_img = subject_img;
        this.major_id = major_id;
        this.subject_content = subject_content;
        this.subject_title = subject_title;
        this.major = major;
    }

    public Subject(int subject_id, String subject_name, int creator_id, Date created_at, Date updated_at, int status, String subject_img, int major_id, String subject_content, String subject_title, Major major, int total_lesson, String creator_name, User owner, int featured_flag) {
        this.subject_id = subject_id;
        this.subject_name = subject_name;
        this.creator_id = creator_id;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.status = status;
        this.subject_img = subject_img;
        this.major_id = major_id;
        this.subject_content = subject_content;
        this.subject_title = subject_title;
        this.major = major;
        this.total_lesson = total_lesson;
        this.creator_name = creator_name;
        this.owner = owner;
        this.featured_flag = featured_flag;
    }

    
    public Subject(int subject_id, String subject_name, int creator_id, Date created_at, Date updated_at, int status, String subject_img, int major_id, String subject_content, String subject_title) {
        this.subject_id = subject_id;
        this.subject_name = subject_name;
        this.creator_id = creator_id;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.status = status;
        this.subject_img = subject_img;
        this.major_id = major_id;
        this.subject_content = subject_content;
        this.subject_title = subject_title;
    }

    public Subject(String subject_name, int creator_id, Date created_at, Date updated_at, int status, String subject_img, int major_id, String subject_content, String subject_title,  User owner, int featured_flag) {
        this.subject_name = subject_name;
        this.creator_id = creator_id;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.status = status;
        this.subject_img = subject_img;
        this.major_id = major_id;
        this.subject_content = subject_content;
        this.subject_title = subject_title;
        this.owner = owner;
        this.featured_flag = featured_flag;
    }
    public Subject(int subjecr_id, String subject_name, int creator_id, Date created_at, Date updated_at, int status, String subject_img, int major_id, String subject_content, String subject_title,  User owner, int featured_flag) {
        this.subject_id = subjecr_id;
        this.subject_name = subject_name;
        this.creator_id = creator_id;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.status = status;
        this.subject_img = subject_img;
        this.major_id = major_id;
        this.subject_content = subject_content;
        this.subject_title = subject_title;
        this.owner = owner;
        this.featured_flag = featured_flag;
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

    public int getSubject_id() {
        return subject_id;
    }

    public void setSubject_id(int subject_id) {
        this.subject_id = subject_id;
    }

    public String getSubject_name() {
        return subject_name;
    }

    public void setSubject_name(String subject_name) {
        this.subject_name = subject_name;
    }

    public int getCreator_id() {
        return creator_id;
    }

    public void setCreator_id(int creator_id) {
        this.creator_id = creator_id;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

    public Date getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(Date updated_at) {
        this.updated_at = updated_at;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getSubject_img() {
        return subject_img;
    }

    public void setSubject_img(String subject_img) {
        this.subject_img = subject_img;
    }

    public int getMajor_id() {
        return major_id;
    }

    public void setMajor_id(int major_id) {
        this.major_id = major_id;
    }

    public Major getMajor() {
        return major;
    }

    public void setMajor(Major major) {
        this.major = major;
    }

    public String getCreator_name() {
        return creator_name;
    }

    public void setCreator_name(String creator_name) {
        this.creator_name = creator_name;
    }

    @Override
    public String toString() {
        return "Subject{" + "subject_id=" + subject_id + ", subject_name=" + subject_name + ", creator_id=" + creator_id + ", created_at=" + created_at + ", updated_at=" + updated_at + ", status=" + status + ", subject_img=" + subject_img + ", major_id=" + major_id + ", subject_content=" + subject_content + ", subject_title=" + subject_title + ", major=" + major + '}';
    }

    public int getTotal_lesson() {
        return total_lesson;
    }

    public void setTotal_lesson(int total_lesson) {
        this.total_lesson = total_lesson;
    }

    public User getOwner() {
        return owner;
    }

    public void setOwner(User owner) {
        this.owner = owner;
    }

    public int getFeatured_flag() {
        return featured_flag;
    }

    public void setFeatured_flag(int featured_flag) {
        this.featured_flag = featured_flag;
    }

    public Subject(int subject_id, String subject_name, int creator_id, Date created_at, Date updated_at, int status, String subject_img, int major_id, String subject_content, String subject_title, Major major, int total_lesson, String creator_name) {
        this.subject_id = subject_id;
        this.subject_name = subject_name;
        this.creator_id = creator_id;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.status = status;
        this.subject_img = subject_img;
        this.major_id = major_id;
        this.subject_content = subject_content;
        this.subject_title = subject_title;
        this.major = major;
        this.total_lesson = total_lesson;
        this.creator_name = creator_name;
    }
    
}
