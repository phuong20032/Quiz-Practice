<%-- 
    Document   : quiz-result
    Created on : May 17, 2024, 2:54:26 PM
    Author     : ASUS
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/gui/header.jsp"></jsp:include>
    <!-- Content -->
    <div class="page-content bg-white">
        <!-- inner page banner -->
        <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner2.jpg);">
            <div class="container">
                <div class="page-banner-entry">
                    <h1 class="text-white">Quiz Results</h1>
                </div>
            </div>
        </div>
        <div class="content-block">
            <!-- About Us -->
            <div class="section-area section-sp1">
                <div class="container">
                    <div class="row d-flex flex-row-reverse">
                        <div class="col-lg-12 col-md-8 col-sm-12">
                            <div class="courses-post">
                                <div class="ttr-post-info">
                                    <div class="ttr-post-title ">
                                        <h2 class="post-title" style="text-align: center">${quiz.quiz_name}</h2>
                                    <c:if test="${userDoneQuiz.score >= quiz.min_to_pass}">
                                        <div class="alert alert-success alert-dismissible fade show" role="alert"  style="text-align: center">
                                            <h4 style="font-weight: bold; color: green">Your score: ${userDoneQuiz.score}%
                                                <span> - ${userDoneQuiz.is_pass == 1  ? "Passed" : "Failed"}</span>
                                            </h4>
                                        </div>
                                    </c:if>
                                    <c:if test="${userDoneQuiz.score < quiz.min_to_pass}">
                                        <div class="alert alert-danger alert-dismissible fade show" role="alert"  style="text-align: center">
                                            <h4 style="font-weight: bold; color: red">Your score: ${userDoneQuiz.score}%
                                                <span> - ${userDoneQuiz.is_pass == 1  ? "Passed" : "Not Passed"}</span>
                                            </h4>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                        <div class="container">
                            <c:forEach items="${questionResults}" var="qr" varStatus="status">
                                <h4>Question ${status.index + 1}: ${qr.question.question_name}</h4>
                                <c:forEach items="${qr.answers}" var="a">
                                    <div>
                                        <input type="radio" name="answer${status.index}" id="${a.answer_id}" value="${a.answer_id}" disabled
                                               <c:if test="${a.answer_id == qr.userAnswer}">
                                                   checked
                                               </c:if>
                                               >
                                        <label for="${a.answer_id}" 
                                               <c:if test="${a.answer_id == qr.correctAnswer}">
                                                   style="color: green;"
                                               </c:if>
                                               <c:if test="${a.answer_id != qr.correctAnswer && a.answer_id == qr.userAnswer}">
                                                   style="color: red;"
                                               </c:if>
                                               >${a.answer_content}</label>
                                    </div>
                                </c:forEach>
                                <c:if test="${qr.userAnswer == 0}">
                                    <p style="color: orange;">You did not answer this question.</p>
                                </c:if>
                            </c:forEach>
                                    <c:if test="${sessionScope.quizCompleted}">

</c:if>
                        </div>
                    </div>
                                    <a href="${pageContext.request.contextPath}/quiz-detail?id=${quiz.quiz_id}" type="button" class="btn btn-sm" >Back</a>
                </div>
            </div>l
        </div>
    </div>
</div>
<!-- Content END-->
<!-- Footer ==== -->
<jsp:include page="/gui/footer.jsp"></jsp:include>


