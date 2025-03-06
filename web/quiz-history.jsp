<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/gui/header.jsp"></jsp:include>
<div class="page-content bg-white">
    <!-- inner page banner -->
    <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner1.jpg);">
        <div class="container">
            <div class="page-banner-entry">
                <h1 class="text-white">Quiz History</h1>
            </div>
        </div>
    </div>
    <!-- Breadcrumb row -->
    <div class="breadcrumb-row">
        <div class="container">
            <ul class="list-inline">
                <li><a href="home">Home</a></li>
                <li><a href="profile">Profile</a></li>
                <li>Quiz History</li>
            </ul>
        </div>
    </div>
    <!-- Breadcrumb row END -->
    <!-- inner page banner END -->
    <div class="content-block">
        <!-- About Us -->
        <div class="section-area section-sp1">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 col-md-4 col-sm-12 m-b30">
                        <div class="profile-bx text-center">
                            <div class="user-profile-thumb">
                                <img src="assets/images/profile/pic1.jpg" alt=""/>
                            </div>
                            <div class="profile-info">
                                <h4>${user.userName}</h4>
                                <span>${user.email}</span>
                            </div>
                            <div class="profile-social">
                                <ul class="list-inline m-a0">
                                    <li><a href="${user.facebook}"><i class="fa fa-facebook"></i></a></li>
                                    <li><a href="${user.twitter}"><i class="fa fa-twitter"></i></a></li>
                                    <li><a href="${user.instagram}"><i class="fa fa-linkedin"></i></a></li>
                                </ul>
                            </div>
                            <div class="profile-tabnav">
                                <ul class="nav nav-tabs">
                                    <li class="nav-item">
                                        <a class="nav-link " href="profile"><i class="ti-book"></i>Profile</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link active" data-toggle="tab" href="#quiz-results"><i class="ti-bookmark-alt"></i>Quiz History </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-9 col-md-8 col-sm-12 m-b30">
                        <div class="profile-content-bx">
                            <div class="tab-content">
                                <div class="tab-pane active" id="quiz-results">
                                    <div class="profile-head">
                                        <h3>Quiz Results</h3>
                                    </div>
                                    <div class="courses-filter">
                                        <div class="row">
                                            <div class="col-md-12 col-lg-12">
                                                <form method="get" action="quiz-history" class="row">
                                                    <input type="hidden" name="page" value="${currentPage}" />
                                                    <div class="form-group col-md-4">
                                                        <label for="searchParam">Search:</label>
                                                        <input type="text" class="form-control" id="searchParam" name="searchParam" value="${searchParam}">
                                                    </div>
                                                   <div class="form-group col-md-4">
                                                        <label for="filter">Filter:</label>
                                                        <select class="form-control" id="filter" name="filter">
                                                            <option value="">All</option>
                                                            <option value="pass" <c:if test="${filter == 'pass'}">selected</c:if>>Pass</option>
                                                            <option value="notPass" <c:if test="${filter == 'notPass'}">selected</c:if>>Not Pass</option>
                                                        </select>
                                                    </div>
                                                   <div class="form-group col-md-4">
                                                        <label for="sortBy">Sort By:</label>
                                                        <select class="form-control" id="sortBy" name="sortBy">
                                                            <option value="">Default</option>
                                                            <option value="score" <c:if test="${sortBy == 'score'}">selected</c:if>>Score</option>
                                                            <option value="time_done" <c:if test="${sortBy == 'time_done'}">selected</c:if>>Time Done</option>
                                                        </select>
                                                    </div>
                                                        <button style="margin-left: 19px" type="submit" class="btn btn-primary">Filter</button>
                                                </form>
                                                <div style="max-height: 400px; overflow-y: auto;">
                                                    <table id="quiz-results" class="table table-striped">
                                                        <thead>
                                                            <tr>
                                                                <th>Quiz</th>
                                                                <th>Score</th>
                                                                <th>Is Pass</th>
                                                                <th>Time done</th>
                                                                <th style="text-align: center; width: 200px">Action</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="u" items="${userDoneQuiz}">
                                                                <tr>
                                                                    <td>${u.quiz.quiz_name}</td>
                                                                    <td>${u.score}</td>
                                                                    <c:if test="${u.is_pass == 1}">
                                                                        <td style="color: green">Yes</td>
                                                                    </c:if>
                                                                    <c:if test="${u.is_pass == 0}">
                                                                        <td style="color: red">No</td>
                                                                    </c:if>
                                                                    <td>${u.formattedTime}</td>
                                                                    <td>
                                                                        <a type="button" href="quiz-result?quiz_id=${u.quiz.quiz_id}" class="btn btn-sm">View</a>
                                                                        <a type="button" href="quiz-handle?id=${u.quiz.quiz_id}" class="btn btn-sm">Re-Take</a>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                                <nav aria-label="Page navigation">
                                                    <ul class="pagination">
                                                        <c:if test="${currentPage > 1}">
                                                            <li class="page-item">
                                                                <a class="page-link" href="?page=${currentPage - 1}&searchParam=${searchParam}&filter=${filter}&sortBy=${sortBy}" aria-label="Previous">
                                                                    <span aria-hidden="true">&laquo;</span>
                                                                    <span class="sr-only">Previous</span>
                                                                </a>
                                                            </li>
                                                        </c:if>
                                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                                            <li class="page-item <c:if test="${currentPage == i}">active</c:if>">
                                                                <a class="page-link" href="?page=${i}&searchParam=${searchParam}&filter=${filter}&sortBy=${sortBy}">${i}</a>
                                                            </li>
                                                        </c:forEach>
                                                        <c:if test="${currentPage < totalPages}">
                                                            <li class="page-item">
                                                                <a class="page-link" href="?page=${currentPage + 1}&searchParam=${searchParam}&filter=${filter}&sortBy=${sortBy}" aria-label="Next">
                                                                    <span aria-hidden="true">&raquo;</span>
                                                                    <span class="sr-only">Next</span>
                                                                </a>
                                                            </li>
                                                        </c:if>
                                                    </ul>
                                                </nav>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- contact area END -->
</div>
<!-- Content END-->
<!-- Footer ==== -->
<jsp:include page="gui/footer.jsp"></jsp:include>
