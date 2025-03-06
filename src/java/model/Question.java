/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.List;

/**
 *
 * @author ADMIN
 */
public class Question {
    private int question_id;
    private String question_name;
    private int answer_count;
    private String quiz_name;
    private int status;
    private List<Answer> answers;
    public Question() {
    }

    public Question(int question_id, String question_name, int answer_count, String quiz_name, int status) {
        this.question_id = question_id;
        this.question_name = question_name;
        this.answer_count = answer_count;
        this.quiz_name = quiz_name;
        this.status = status;
    }

    @Override
    public String toString() {
        return "Question{" + "question_id=" + question_id + ", question_name=" + question_name + ", answer_count=" + answer_count + ", quiz_name=" + quiz_name + ", status=" + status + ", answers=" + answers + '}';
    }

    

    public int getQuestion_id() {
        return question_id;
    }

    public void setQuestion_id(int question_id) {
        this.question_id = question_id;
    }

    public String getQuestion_name() {
        return question_name;
    }

    public void setQuestion_name(String question_name) {
        this.question_name = question_name;
    }

    public int getAnswer_count() {
        return answer_count;
    }

    public void setAnswer_count(int answer_count) {
        this.answer_count = answer_count;
    }

    public String getQuiz_name() {
        return quiz_name;
    }

    public void setQuiz_name(String quiz_name) {
        this.quiz_name = quiz_name;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Question(int question_id, String question_name, int answer_count, String quiz_name, int status, List<Answer> answers) {
        this.question_id = question_id;
        this.question_name = question_name;
        this.answer_count = answer_count;
        this.quiz_name = quiz_name;
        this.status = status;
        this.answers = answers;
    }

    public List<Answer> getAnswers() {
        return answers;
    }

    public void setAnswers(List<Answer> answers) {
        this.answers = answers;
    }

    
    
}
