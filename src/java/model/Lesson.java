/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

public class Lesson {

    private int lesson_id;
    private String lesson_name;
    private User creator;
    private Date createAt;
    private Date updaetAt;
    private int status;
    private String subject_name;
    private int quiz_count;
    private String description;
    public Lesson() {
    }

    public int getLesson_id() {
        return lesson_id;
    }

    public void setLesson_id(int lesson_id) {
        this.lesson_id = lesson_id;
    }

    public String getLesson_name() {
        return lesson_name;
    }

    public void setLesson_name(String lesson_name) {
        this.lesson_name = lesson_name;
    }

    public User getCreator() {
        return creator;
    }

    public void setCreator(User creator) {
        this.creator = creator;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }

    public Date getUpdaetAt() {
        return updaetAt;
    }

    public void setUpdaetAt(Date updaetAt) {
        this.updaetAt = updaetAt;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getSubject_name() {
        return subject_name;
    }

    public void setSubject_name(String subject_name) {
        this.subject_name = subject_name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Lesson(int lesson_id, String lesson_name, User creator, Date createAt, Date updaetAt, int status, String subject_name, int quiz_count, String description) {
        this.lesson_id = lesson_id;
        this.lesson_name = lesson_name;
        this.creator = creator;
        this.createAt = createAt;
        this.updaetAt = updaetAt;
        this.status = status;
        this.subject_name = subject_name;
        this.quiz_count = quiz_count;
        this.description = description;
    }

    public int getQuiz_count() {
        return quiz_count;
    }

    public void setQuiz_count(int quiz_count) {
        this.quiz_count = quiz_count;
    }

    @Override
    public String toString() {
        return "Lesson{" + "lesson_id=" + lesson_id + ", lesson_name=" + lesson_name + ", creator=" + creator + ", createAt=" + createAt + ", updaetAt=" + updaetAt + ", status=" + status + ", subject_name=" + subject_name + ", quiz_count=" + quiz_count + ", description=" + description + '}';
    }

   

    
}
