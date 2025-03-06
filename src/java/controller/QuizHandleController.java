package controller;

import dal.QuestionDAO;
import dal.QuizDAO;
import dal.UserAttempQuizDAO;
import dal.UserQuizDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Question;
import model.Quiz;
import model.User;

@WebServlet(name = "QuizHandleController", urlPatterns = {"/quiz-handle"})
public class QuizHandleController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        if (user != null) {
            int id = Integer.parseInt(request.getParameter("id"));
            UserAttempQuizDAO userAttempQuizDAO = new UserAttempQuizDAO();
            QuizDAO quizDAO = new QuizDAO();
            int maxAttempts = quizDAO.getTimeAttempt(id);
            boolean hasReachedMaxAttempts = userAttempQuizDAO.hasReachedMaxAttempts(user.getUser_id(), id, maxAttempts);
            if (hasReachedMaxAttempts) {
                session.setAttribute("notificationErr", "You have reached the maximum number of attempts for this quiz");
                response.sendRedirect("quiz-detail?id=" + id);
                return;
            }
            
            try {
                // Increment the user's attempt count or add a new record if it doesn't exist
                userAttempQuizDAO.incrementUserAttempt(user.getUser_id(), id);
            } catch (SQLException ex) {
                Logger.getLogger(QuizHandleController.class.getName()).log(Level.SEVERE, null, ex);
            }

            QuestionDAO questionDAO = new QuestionDAO();
            Quiz quiz = quizDAO.getById(id);
            List<Question> questions = questionDAO.getAllQuestionByQuiz(id);

            // Set the start time and duration in the session
            session.setAttribute("startTime", System.currentTimeMillis());
            session.setAttribute("duration", quiz.getCount_down() * 60); // Duration in min
            System.out.println(quiz.getCount_down());
            request.setAttribute("quiz", quiz);
            request.setAttribute("questions", questions);
            request.getRequestDispatcher("quiz-handle.jsp").forward(request, response);
        } else {
            response.sendRedirect("home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        int quizId = Integer.parseInt(request.getParameter("quiz_id"));
        QuizDAO quizDAO = new QuizDAO();
        UserAttempQuizDAO userAttempQuizDAO = new UserAttempQuizDAO();

        // Calculate the elapsed time
       // Calculate the elapsed time in minutes
        long startTime = (long) session.getAttribute("startTime");
        long currentTime = System.currentTimeMillis();
        float elapsedTimeInMinutes = (currentTime - startTime) / (1000.0f * 60.0f); // Elapsed time in minutes

        // Ensure elapsedTimeInMinutes is rounded to the nearest minute if required
        elapsedTimeInMinutes = Math.round(elapsedTimeInMinutes * 100.0f) / 100.0f;

        int duration = (int) session.getAttribute("duration");

        if (elapsedTimeInMinutes > duration) {
            // Time's up, auto-submit the quiz
            autoSubmitQuiz(request, response, user, quizId, elapsedTimeInMinutes);
            return;
        }

        // Regular form submission handling
        handleFormSubmission(request, response, user, quizId, elapsedTimeInMinutes);
    }

    private void autoSubmitQuiz(HttpServletRequest request, HttpServletResponse response, User user, int quizId, float elapsedTime) throws IOException {
        HttpSession session = request.getSession();
        QuestionDAO questionDAO = new QuestionDAO();
        UserQuizDAO userQuizDAO = new UserQuizDAO();
        List<Question> questions = questionDAO.getAllQuestionByQuiz(quizId);

        int correctAnswers = 0;
        for (Question question : questions) {
            try {
                // Handle the case where no answer is selected (auto-submit)
                userQuizDAO.storeUserAnswerNull(user.getUser_id(), quizId, question.getQuestion_id());
            } catch (SQLException ex) {
                Logger.getLogger(QuizHandleController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        // Calculate the score as a percentage
        int score = (correctAnswers * 100) / questions.size();
        int minToPass = new QuizDAO().getById(quizId).getMin_to_pass();
        boolean isPass = score >= minToPass;

        try {
            // Store the result in user_has_done_quiz table
            userQuizDAO.storeQuizResult(user.getUser_id(), quizId, score, isPass, elapsedTime);
        } catch (SQLException ex) {
            Logger.getLogger(QuizHandleController.class.getName()).log(Level.SEVERE, null, ex);
        }
        response.sendRedirect("quiz-result?quiz_id=" + quizId);
    }

    private void handleFormSubmission(HttpServletRequest request, HttpServletResponse response, User user, int quizId, float elapsedTime) throws IOException {
        HttpSession session = request.getSession();
        QuizDAO quizDAO = new QuizDAO();
        UserAttempQuizDAO userAttempQuizDAO = new UserAttempQuizDAO();
        QuestionDAO questionDAO = new QuestionDAO();
        UserQuizDAO userQuizDAO = new UserQuizDAO();

        int maxAttempts = quizDAO.getTimeAttempt(quizId);
        boolean hasReachedMaxAttempts = userAttempQuizDAO.hasReachedMaxAttempts(user.getUser_id(), quizId, maxAttempts + 1);

        if (user != null) {
            if (hasReachedMaxAttempts) {
                session.setAttribute("notificationErr", "You have reached the maximum number of attempts for this quiz");
                response.sendRedirect("quiz-detail?id=" + quizId);
                return;
            }

            List<Question> questions = questionDAO.getAllQuestionByQuiz(quizId);
            int correctAnswers = 0;
            for (int i = 0; i < questions.size(); i++) {
                String selectedAnswerIdStr = request.getParameter("answer" + i);
                if (selectedAnswerIdStr != null) {
                    try {
                        int selectedAnswerId = Integer.parseInt(selectedAnswerIdStr);
                        boolean isCorrect = userQuizDAO.isAnswerCorrect(selectedAnswerId);
                        if (isCorrect) {
                            correctAnswers++;
                        }
                        // Store the user's answer
                        userQuizDAO.storeUserAnswer(user.getUser_id(), quizId, questions.get(i).getQuestion_id(), selectedAnswerId);
                    } catch (SQLException ex) {
                        Logger.getLogger(QuizHandleController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                } else {
                    try {
                        // Handle the case where no answer is selected
                        userQuizDAO.storeUserAnswerNull(user.getUser_id(), quizId, questions.get(i).getQuestion_id());
                    } catch (SQLException ex) {
                        Logger.getLogger(QuizHandleController.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }

            // Calculate the score as a percentage
            int score = (correctAnswers * 100) / questions.size();
            int minToPass = quizDAO.getById(quizId).getMin_to_pass();
            boolean isPass = score >= minToPass;

            try {
                // Store the result in user_has_done_quiz table
                userQuizDAO.storeQuizResult(user.getUser_id(), quizId, score, isPass, elapsedTime);
            } catch (SQLException ex) {
                Logger.getLogger(QuizHandleController.class.getName()).log(Level.SEVERE, null, ex);
            }
            response.sendRedirect("quiz-result?quiz_id=" + quizId);
        } else {
            response.sendRedirect("home");
        }
    }
}
