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


                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="courses-post">

                            <div class="ttr-post-info">
                                <div class="ttr-post-title ">
                                    <h2 class="post-title">${s.lesson_name}</h2>
                                </div>
                            </div>
                        </div>
                        <div class="teacher-bx">
                            <div class="teacher-info">
                                <div class="teacher-thumb">
                                    <img src="assets/images/testimonials/pic1.jpg" alt=""/>
                                </div>
                                <div class="teacher-name">
                                    <h5>${s.creator.userName}</h5>
                                    <span>Author</span>
                                </div >
                                <div style="margin-left: 30px"class="teacher-name">
                                    <h5>${s.createAt}</h5>
                                    <span>Created</span>
                                </div>
                            </div>
                        </div>
                        <br> 
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
                                                <c:forEach items="${quiz}" var="l" varStatus="status">
                                                    <li>
                                                        <div class="curriculum-list-box">
                                                            <span>Quiz ${status.index + 1}.</span> ${l.quiz_name}
                                                        </div>
                                                        <button class="btn btn-primary btn-sm">Do quiz</button>
                                                    </li>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="modal fade" style="margin-top: 100px" id="join" tabindex="-1" aria-labelledby="join" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="join${details.subject_id}">Register for ${details.getSubject_name()}</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form action="${pageContext.request.contextPath}/subjectdetail" method="post">
                                        <div class="form-group">
                                            <label for="fullName">Full Name</label>
                                            <input type="text" class="form-control" id="fullName" name="fullName">
                                            <input type="hidden" class="form-control"  name="action" value="join">
                                        </div>
                                        <div class="form-group">
                                            <label for="email">Email</label>
                                            <input type="email" class="form-control" id="email" name="email">
                                        </div>
                                        <div class="form-group">
                                            <label for="mobile">Mobile</label>
                                            <input type="text" class="form-control" id="mobile" name="phone">
                                        </div>
                                        <div class="form-group">
                                            <label for="gender">Gender</label>
                                            <select class="form-control" id="gender" name="gender" required>
                                                <option value="1">Male</option>
                                                <option value="0">Female</option>
                                            </select>
                                        </div>
                                        <input type="hidden" name="subjectId" value="${details.subject_id}">
                                        <button type="submit" class="btn btn-primary">Register</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- *********** Modal Structure ************* -->
                    <div class="modal fade" style="margin-top: 100px" id="joinNow" tabindex="-1" aria-labelledby="joinNow" aria-hidden="true">

                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="joinNow">Confirmation</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <form action="${pageContext.request.contextPath}/subjectdetail" method="post">
                                    <div class="modal-body">
                                        <p>Are you sure to errol this course ?</p>
                                    </div>
                                    <input type="hidden" name="subjectId" value="${details.subject_id}">
                                    <input type="hidden" name="action" value="errol-now">
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-danger" data-dismiss="modal" aria-label="Close">
                                            No
                                        </button>
                                        <button type="submit" class="btn btn-primary">
                                            Yes
                                        </button>
                                    </div>
                                </form>

                            </div>
                        </div>
                    </div>
                    <div class="modal fade" style="margin-top: 100px" id="unJoin" tabindex="-1" aria-labelledby="unJoin" aria-hidden="true">

                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="joinNow${details.subject_id}">Confirmation</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <form action="${pageContext.request.contextPath}/subjectdetail" method="post">
                                    <input type="hidden" name="subjectId" value="${details.subject_id}">
                                    <input type="hidden" name="action" value="un-errol">
                                    <div class="modal-body">
                                        <p>Are you sure to un-errol this course ?</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-danger" data-dismiss="modal" aria-label="Close">
                                            No
                                        </button>
                                        <button class="btn btn-primary">
                                            Yes
                                        </button>
                                    </div>
                                </form>
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
<jsp:include page="/gui/footer.jsp"></jsp:include>