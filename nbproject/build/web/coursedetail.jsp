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
                    <h1 class="text-white">Subjects Details</h1>
                </div>
            </div>
        </div>
        <!-- Breadcrumb row -->
        <div class="breadcrumb-row">
            <div class="container">
                <ul class="list-inline">
                    <li><a href="home">Home</a></li>
                    <li><a href="subjectlist">Subject List</a></li>
                    <li>Subjects Details</li>
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
                    <div class="col-lg-3 col-md-4 col-sm-12 m-b30">
                        <form action="subjectlist" method="get">
                            <div class="widget courses-search-bx placeani">
                                <div class="form-group">
                                    <div class="input-group">
                                        <form action="subjectlist" method="get">
                                            <input type="text" class="form-control" name="search" placeholder="Enter name to search" value="${param.search}">
                                            <button style="margin-top: 3px" class="btn btn-sm" type="submit" >Search</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="widget widget_archive">
                                <h5 class="widget-title style-1">All Subjects</h5>
                                <ul>
                                    <li class="active"><a href="subjectlist?search=${param.search}">All</a></li>
                                        <c:forEach var="major" items="${listM}">
                                        <li  class="active"><a href="subjectlist?search=${param.search}&major=${major.major_id}">  ${major.major_name}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <div class="widget">
                                <a href="home"><img src="assets/images/adv/adv.jpg" alt=""/></a>
                            </div>
                            <div class="widget recent-posts-entry widget-courses">
                                <h5 class="widget-title style-1">Recent Subjects</h5>
                                <div class="widget-post-bx">
                                    <c:forEach items="${recentSubject}" var="s">
                                        <div class="widget-post clearfix">
                                            <div class="ttr-post-media"> 
                                                <a href="subjectdetail?pid=${s.subject_id}">
                                                    <img src="${s.subject_img}" width="200" height="143" alt=""> 
                                                </a>
                                            </div>
                                            <div class="ttr-post-info">
                                                <div class="ttr-post-header">
                                                    <h6 class="post-title"><a href="subjectdetail?pid=${s.subject_id}">${s.subject_name}</a></h6>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>

                                </div>
                            </div>
                        </form>
                    </div>

                    <div class="col-lg-9 col-md-8 col-sm-12">
                        <div class="courses-post">
                            <div class="ttr-post-media media-effect">
                                <a href="#"><img style="max-width: 500px" src="${details.subject_img}" alt=""></a>
                            </div>
                            <div class="ttr-post-info">
                                <div class="ttr-post-title ">
                                    <h2 class="post-title">${details.subject_title}</h2>
                                </div>
                                <div class="ttr-post-text">
                                    <p>${details.subject_content}</p>
                                </div>

                            </div>
                        </div>
                        <div>

                            <c:choose>
                                <c:when test="${sessionScope.account == null}">
                                    <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#join">
                                        JOIN NOW
                                    </button>
                                </c:when>
                                <c:when test="${sessionScope.account != null && !isEnrolled}">
                                    <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#joinNow">
                                        JOIN NOW
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#unJoin">
                                        UNENROLL
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <br>
                        <div class="" id="instructor">
                            <h4>Instructor</h4>
                            <div class="instructor-bx">
                                <div class="instructor-author">
                                    <img src="assets/images/testimonials/pic1.jpg" alt="">
                                </div>
                                <div class="instructor-info">
                                    <h6>${details.userName}</h6>
                                    <span>Professor</span>
                                    <ul class="list-inline m-tb10">
                                        <li><a href="${details.facebook}" class="btn sharp-sm facebook"><i class="fa fa-facebook"></i></a></li>
                                        <li><a href="${details.twitter}" class="btn sharp-sm twitter"><i class="fa fa-twitter"></i></a></li>
                                        <li><a href="${details.instagram}" class="btn sharp-sm google-plus"><i class="fa fa-google-plus"></i></a></li>
                                    </ul>
                                    <p class="m-b0">${details.description}</p>
                                </div>
                            </div>
                        </div>
                       	<div class="m-b30" id="lesson">
                            <h4>Lesson</h4>
                            <ul class="curriculum-list">
                                <li>
                                    <ul>
                                        <c:choose>
                                            <c:when test="${empty lesson}">
                                                <li>
                                                    <div class="curriculum-list-box">
                                                        <span style="color: red">This subject has no lessons</span>
                                                    </div>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach items="${lesson}" var="l" varStatus="status">
                                                    <li>
                                                        <div class="curriculum-list-box">
                                                            <span>Lesson ${status.index + 1}.</span> ${l.lesson_name}
                                                        </div>
                                                        <c:choose>
                                                            <c:when test="${sessionScope.account == null}">
                                                                <span style="color: red">Enroll to view</span>
                                                            </c:when>
                                                            <c:when test="${sessionScope.account != null && !isEnrolled}">
                                                                <span style="color: red">Enroll to view</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <a href="lesson-detail?id=${l.lesson_id}" class="btn btn-primary btn-sm">View</a>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </li>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </ul>
                                </li>
                            </ul>
                        </div>

<!--                        <div class="" id="reviews">
                            <h4>Reviews</h4>

                            <div class="review-bx">
                                <div class="all-review">
                                    <h2 class="rating-type">3</h2>
                                    <ul class="cours-star">
                                        <li class="active"><i class="fa fa-star"></i></li>
                                        <li class="active"><i class="fa fa-star"></i></li>
                                        <li class="active"><i class="fa fa-star"></i></li>
                                        <li><i class="fa fa-star"></i></li>
                                        <li><i class="fa fa-star"></i></li>
                                    </ul>
                                    <span>3 Rating</span>
                                </div>
                                <div class="review-bar">
                                    <div class="bar-bx">
                                        <div class="side">
                                            <div>5 star</div>
                                        </div>
                                        <div class="middle">
                                            <div class="bar-container">
                                                <div class="bar-5" style="width:90%;"></div>
                                            </div>
                                        </div>
                                        <div class="side right">
                                            <div>150</div>
                                        </div>
                                    </div>
                                    <div class="bar-bx">
                                        <div class="side">
                                            <div>4 star</div>
                                        </div>
                                        <div class="middle">
                                            <div class="bar-container">
                                                <div class="bar-5" style="width:70%;"></div>
                                            </div>
                                        </div>
                                        <div class="side right">
                                            <div>140</div>
                                        </div>
                                    </div>
                                    <div class="bar-bx">
                                        <div class="side">
                                            <div>3 star</div>
                                        </div>
                                        <div class="middle">
                                            <div class="bar-container">
                                                <div class="bar-5" style="width:50%;"></div>
                                            </div>
                                        </div>
                                        <div class="side right">
                                            <div>120</div>
                                        </div>
                                    </div>
                                    <div class="bar-bx">
                                        <div class="side">
                                            <div>2 star</div>
                                        </div>
                                        <div class="middle">
                                            <div class="bar-container">
                                                <div class="bar-5" style="width:40%;"></div>
                                            </div>
                                        </div>
                                        <div class="side right">
                                            <div>110</div>
                                        </div>
                                    </div>
                                    <div class="bar-bx">
                                        <div class="side">
                                            <div>1 star</div>
                                        </div>
                                        <div class="middle">
                                            <div class="bar-container">
                                                <div class="bar-5" style="width:20%;"></div>
                                            </div>
                                        </div>
                                        <div class="side right">
                                            <div>80</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>-->


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
                                        <p>Are you sure to enroll this subject ?</p>
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
                                        <p>Are you sure to un-enroll this subject ?</p>
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