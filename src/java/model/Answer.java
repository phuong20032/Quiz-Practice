/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class Answer {
    private int answer_id;
    private String answer_content;
    private boolean isCorrect;

    public Answer() {
    }

    @Override
    public String toString() {
        return "Answer{" + "answer_id=" + answer_id + ", answer_content=" + answer_content + ", isCorrect=" + isCorrect + '}';
    }

    public int getAnswer_id() {
        return answer_id;
    }

    public void setAnswer_id(int answer_id) {
        this.answer_id = answer_id;
    }

    public String getAnswer_content() {
        return answer_content;
    }

    public void setAnswer_content(String answer_content) {
        this.answer_content = answer_content;
    }

    public boolean isIsCorrect() {
        return isCorrect;
    }

    public void setIsCorrect(boolean isCorrect) {
        this.isCorrect = isCorrect;
    }

    public Answer(int answer_id, String answer_content, boolean isCorrect) {
        this.answer_id = answer_id;
        this.answer_content = answer_content;
        this.isCorrect = isCorrect;
    }

    public Answer(String answer_content, boolean isCorrect) {
        this.answer_content = answer_content;
        this.isCorrect = isCorrect;
    }

    
}
