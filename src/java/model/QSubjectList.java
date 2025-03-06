/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author ADMIN
 */
public class QSubjectList {

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
    private String major_name;

    public QSubjectList(int subject_id, String subject_name, int creator_id, Date created_at, Date updated_at, int status, String subject_img, int major_id, String subject_content, String subject_title, String major_name) {
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
        this.major_name = major_name;
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

    public String getMajor_name() {
        return major_name;
    }

    public void setMajor_name(String major_name) {
        this.major_name = major_name;
    }
    
}
