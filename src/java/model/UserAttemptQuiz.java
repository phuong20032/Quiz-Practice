/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class UserAttemptQuiz {
    private User user;
    private Quiz quiz;
    private  int times;

    public UserAttemptQuiz(User user, Quiz quiz, int times) {
        this.user = user;
        this.quiz = quiz;
        this.times = times;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Quiz getQuiz() {
        return quiz;
    }

    public void setQuiz(Quiz quiz) {
        this.quiz = quiz;
    }

    public int getTimes() {
        return times;
    }

    public void setTimes(int times) {
        this.times = times;
    }

    public UserAttemptQuiz() {
    }

    @Override
    public String toString() {
        return "UserAttemptQuiz{" + "user=" + user + ", quiz=" + quiz + ", times=" + times + '}';
    }
    
    
}
