
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/gui/header.jsp"></jsp:include>
    <!-- Content -->
    <div class="page-content bg-white">
        <!-- inner page banner -->
        <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner3.jpg);">
            <div class="container">
                <div class="page-banner-entry">
                    <h1 class="text-white">Subject - List</h1>
                </div>
            </div>
        </div>
        <!-- Breadcrumb row -->
        <div class="breadcrumb-row">
            <div class="container">
                <ul class="list-inline">
                    <li><a href="home">Home</a></li>
                    <li>Subject List</li>
                </ul>
            </div>
        </div>
    <c:if test="${not empty sessionScope.notification}">
        <div class="alert alert-success alert-dismissible fade show" role="alert" style="text-align: center">
            ${sessionScope.notification}
            <button type="button" class="btn-danger" data-dismiss="alert" aria-label="Close">X</button>
        </div>
        <%
            // Clear the notification after displaying it
            session.removeAttribute("notification");
        %>
    </c:if>
    <c:if test="${not empty sessionScope.notificationErr}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert"  style="text-align: center">
            ${sessionScope.notificationErr}
            <button type="button" class="btn-danger" data-dismiss="alert" >X</button>
        </div>
        <%
            // Clear the notification after displaying it
            session.removeAttribute("notificationErr");
        %>
    </c:if>
    <!-- Breadcrumb row END -->
    <!-- inner page banner END -->
    <div class="content-block">
        <!-- About Us -->
        <div class="section-area section-sp1">
            <div class="container">
                <div class="row">
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
                                <h5 class="widget-title style-1">All Subject</h5>
                                <ul>
                                    <li class="active"><a href="subjectlist?search=${param.search}">All</a></li>
                                        <c:forEach var="major" items="${listM}">
                                        <li  class="active"><a href="subjectlist?search=${param.search}&major=${major.major_id}">  ${major.major_name}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>

                            <div class="widget recent-posts-entry widget-courses">
                                <h5 class="widget-title style-1">Recent Subject</h5>
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
                        <div class="row">
                            <c:forEach items="${requestScope.subjects}" var="p">
                                <div class="col-md-6 col-lg-4 col-sm-6 m-b30">
                                    <div class="cours-bx">
                                        <div class="action-box">
                                            <img style="max-height: 169px" src="${p.getSubject_img()}" alt="">
                                            <a href="subjectdetail?pid=${p.subject_id}" class="btn">Read More</a>
                                        </div>
                                        <div class="info-bx text-center">
                                            <h5><a href="#">${p.getSubject_name()}</a></h5>
                                            <span>${p.getSubject_title()}</span>
                                        </div>
                                        <div class="cours-more-info">
                                            <div class="review">
                                                <span>//////</span>
                                            </div>
                                            <!-- *********** Show Join Now or Unenroll based on user status ************* -->
                                            <div class="pt-btn-join">
                                                <c:choose>
                                                    <c:when test="${sessionScope.account == null}">
                                                        <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#join${p.subject_id}">
                                                            JOIN NOW
                                                        </button>
                                                    </c:when>
                                                    <c:when test="${sessionScope.account != null && !enrollmentStatusMap[p.subject_id]}">
                                                        <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#joinNow${p.subject_id}">
                                                            JOIN NOW
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#unJoin${p.subject_id}">
                                                            UNENROLL
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>


                                            </div>
                                            <!-- *********** Show Join Now or Unenroll based on user status ************* -->
                                        </div>
                                    </div>
                                </div>
                                <!-- *********** Modal Structure ************* -->
                                <div class="modal fade" style="margin-top: 100px" id="join${p.subject_id}" tabindex="-1" aria-labelledby="join${p.subject_id}" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="join${p.subject_id}">Register for ${p.getSubject_name()}</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <form id="registrationForm" action="${pageContext.request.contextPath}/subject-register" method="post" onsubmit="return validateForm()">
                                                    <div class="form-group">
                                                        <label for="fullName">Full Name</label>
                                                        <input type="text" class="form-control" id="fullName" name="fullName">
                                                        <span id="fullNameError" class="text-danger"></span>
                                                        <input type="hidden" class="form-control"  name="action" value="join">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="email">Email</label>
                                                        <input type="email" class="form-control" id="email" name="email">
                                                        <span id="emailError" class="text-danger"></span>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="mobile">Mobile</label>
                                                        <input type="text" class="form-control" id="mobile" name="phone">
                                                        <span id="mobileError" class="text-danger"></span>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="gender">Gender</label>
                                                        <select class="form-control" id="gender" name="gender" required>
                                                            <option value="1">Male</option>
                                                            <option value="0">Female</option>
                                                        </select>
                                                        <span id="genderError" class="text-danger"></span>
                                                    </div>
                                                    <input type="hidden" name="subjectId" value="${p.subject_id}">
                                                    <button type="submit" class="btn btn-primary">Register</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- *********** Modal Structure ************* -->
                                <div class="modal fade" style="margin-top: 100px" id="joinNow${p.subject_id}" tabindex="-1" aria-labelledby="joinNow${p.subject_id}" aria-hidden="true">

                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="joinNow${p.subject_id}">Confirmation</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <form action="${pageContext.request.contextPath}/subject-register" method="post">
                                                <div class="modal-body">
                                                    <p>Are you sure to enroll this subject ?</p>
                                                </div>
                                                <input type="hidden" name="subjectId" value="${p.subject_id}">
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
                                <div class="modal fade" style="margin-top: 100px" id="unJoin${p.subject_id}" tabindex="-1" aria-labelledby="unJoin${p.subject_id}" aria-hidden="true">

                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="joinNow${p.subject_id}">Confirmation</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <form action="${pageContext.request.contextPath}/subject-register" method="post">
                                                <input type="hidden" name="subjectId" value="${p.subject_id}">
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
                            </c:forEach>
                            <div class="col-lg-12 m-b20">
                                <div class="pagination-bx rounded-sm gray clearfix">
                                    <ul class="pagination justify-content-center">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="btn btn-primary" href="?search=${param.search}&major=${param.major}&page=${currentPage - 1}">Previous</a>
                                            </li>
                                        </c:if>

                                        <c:forEach var="pageNum" begin="1" end="${totalPages}">
                                            <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                                                <a class="btn btn-primary" href="?search=${param.search}&major=${param.major}&page=${pageNum}">${pageNum}</a>
                                            </li>
                                        </c:forEach>

                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="btn btn-primary" href="?search=${param.search}&major=${param.major}&page=${currentPage + 1}">Next</a>
                                            </li>
                                        </c:if>
                                    </ul>
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
<jsp:include page="/gui/footer.jsp"></jsp:include>