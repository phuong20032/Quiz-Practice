<%-- 
    Document   : coursedetail
    Created on : May 17, 2024, 2:54:26 PM
    Author     : ASUS
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/gui/header.jsp"></jsp:include>
    <!-- Content -->
    <div class="page-content bg-white">
        <!-- inner page banner -->
        <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner2.jpg);">
            <div class="container">
                <div class="page-banner-entry">
                    <h1 class="text-white">Lesson Detail</h1>
                </div>
            </div>
        </div>
        <!-- Breadcrumb row -->
        <div class="breadcrumb-row">
            <div class="container">
                <ul class="list-inline">
                    <li><a href="#">Home</a></li>
                    <li>Lesson Detail</li>
                </ul>
            </div>
        </div>
        <!-- Breadcrumb row END -->
    <c:if test="${not empty sessionScope.notification}">
        <div class="alert alert-success alert-dismissible fade show" role="alert" style="text-align: center">
            ${sessionScope.notification}
            <button type="button" class="btn-close" data-dismiss="alert" aria-label="Close">X</button>
        </div>
        <%
            // Clear the notification after displaying it
            session.removeAttribute("notification");
        %>
    </c:if>
    <c:if test="${not empty sessionScope.notificationErr}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert" style="text-align: center">
            ${sessionScope.notificationErr}
            <button type="button" class="btn-close" data-dismiss="alert" aria-label="Close">X</button>
        </div>
        <%
            // Clear the notification after displaying it
            session.removeAttribute("notificationErr");
        %>
    </c:if>

    <!-- inner page banner END -->
    <div class="content-block">
        <!-- About Us -->
        <div class="section-area section-sp1">
            <div class="container">
                <div class="row d-flex flex-row-reverse">


                    <div class="col-lg-12 col-md-8 col-sm-12">
                        <div class="courses-post">

                            <div class="ttr-post-info">
                                <div class="ttr-post-title ">
                                    <h2 class="post-title">${s.lesson_name}</h2>
                                </div>
                                <div class="ttr-post-text">
                                    <p>${s.description}</p>
                                </div>

                            </div>
                        </div>

                        <div class="" id="instructor">
                            <h4>Instructor</h4>
                            <div class="instructor-bx">
                                <div class="instructor-author">
                                    <img src="assets/images/testimonials/pic1.jpg" alt="">
                                </div>
                                <div class="instructor-info">
                                    <h6>${s.creator.userName}</h6>
                                    <span>Professor</span>
                                    <ul class="list-inline m-tb10">
                                        <li><a href="${s.creator.facebook}" class="btn sharp-sm facebook"><i class="fa fa-facebook"></i></a></li>
                                        <li><a href="${s.creator.twitter}" class="btn sharp-sm twitter"><i class="fa fa-twitter"></i></a></li>
                                        <li><a href="${s.creator.instagram}" class="btn sharp-sm google-plus"><i class="fa fa-google-plus"></i></a></li>
                                    </ul>
                                    <p class="m-b0">${details.description}</p>
                                </div>
                            </div>
                        </div>
                       	<div class="m-b30" id="lesson">
                            <h4>Quiz</h4>
                            <ul class="curriculum-list">
                                <li>
                                    <ul>
                                        <c:choose>
                                            <c:when test="${empty quiz}">
                                                <li>
                                                    <div class="curriculum-list-box">
                                                        <span style="color: red">This lesson has no quiz</span>
                                                    </div>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach items="${quiz}" var="q" varStatus="status">
                                                    <li>
                                                        <div class="curriculum-list-box">
                                                            <span>Quiz ${status.index + 1}.</span> ${q.quiz_name}
                                                        </div>
                                                        <a href="quiz-detail?id=${q.quiz_id}" class="btn btn-primary btn-sm">View quiz</a>
                                                    </li>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </ul>
                                </li>
                            </ul>
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
<jsp:include page="/gui/footer.jsp"></jsp:include>