/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.Date;
public class Quiz {
    private int quiz_id;
    private String quiz_name;
    private Date created_at;
    private Date updated_at;
    private User creator;
    private int status;
    private int count_down;
    private String  lesson_name;
    private int  total_question;
    private boolean isQuizTaken;
    private int min_to_pass;
    private int pass_rate;
    
    private int attemp_time;
    public Quiz() {
    }

    public Quiz(int quiz_id, String quiz_name, Date created_at, Date updated_at, User creator, int status, int count_down) {
        this.quiz_id = quiz_id;
        this.quiz_name = quiz_name;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.creator = creator;
        this.status = status;
        this.count_down = count_down;
    }
    public Quiz(int quiz_id, String quiz_name, Date created_at, Date updated_at, User creator, int status, int count_down, int attemp_time) {
        this.quiz_id = quiz_id;
        this.quiz_name = quiz_name;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.creator = creator;
        this.status = status;
        this.count_down = count_down;
        this.attemp_time = attemp_time;
    }

    public boolean isIsQuizTaken() {
        return isQuizTaken;
    }

    public void setIsQuizTaken(boolean isQuizTaken) {
        this.isQuizTaken = isQuizTaken;
    }

    public String getLesson_name() {
        return lesson_name;
    }

    public int getTotal_question() {
        return total_question;
    }

    public void setTotal_question(int total_question) {
        this.total_question = total_question;
    }

    public void setLesson_name(String lesson_name) {
        this.lesson_name = lesson_name;
    }

    public int getQuiz_id() {
        return quiz_id;
    }

    public void setQuiz_id(int quiz_id) {
        this.quiz_id = quiz_id;
    }

    public String getQuiz_name() {
        return quiz_name;
    }

    public void setQuiz_name(String quiz_name) {
        this.quiz_name = quiz_name;
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

    public User getCreator() {
        return creator;
    }

    public void setCreator(User creator) {
        this.creator = creator;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getCount_down() {
        return count_down;
    }

    public void setCount_down(int count_down) {
        this.count_down = count_down;
    }

    public int getMin_to_pass() {
        return min_to_pass;
    }

    public void setMin_to_pass(int min_to_pass) {
        this.min_to_pass = min_to_pass;
    }

    public int getPass_rate() {
        return pass_rate;
    }

    public void setPass_rate(int pass_rate) {
        this.pass_rate = pass_rate;
    }

    public int getAttemp_time() {
        return attemp_time;
    }

    public void setAttemp_time(int attemp_time) {
        this.attemp_time = attemp_time;
    }

    @Override
    public String toString() {
        return "Quiz{" + "quiz_id=" + quiz_id + ", quiz_name=" + quiz_name + ", created_at=" + created_at + ", updated_at=" + updated_at + ", creator=" + creator + ", status=" + status + ", count_down=" + count_down + ", lesson_name=" + lesson_name + ", total_question=" + total_question + ", isQuizTaken=" + isQuizTaken + ", min_to_pass=" + min_to_pass + ", pass_rate=" + pass_rate + ", attemp_time=" + attemp_time + '}';
    }
}
