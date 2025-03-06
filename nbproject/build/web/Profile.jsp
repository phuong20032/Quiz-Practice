<%-- 
    Document   : Profile
    Created on : May 14, 2024, 5:30:45 PM
    Author     : Admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/gui/header.jsp"></jsp:include>
            <!-- header END ==== -->
            <!-- Content -->
            <div class="page-content bg-white">
                <!-- inner page banner -->
                <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner1.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Profile</h1>
                        </div>
                    </div>
                </div>
                <!-- Breadcrumb row -->
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="home">Home</a></li>
                            <li>Profile</li>
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
                                                    <a class="nav-link active" data-toggle="tab" href="#courses"><i class="ti-book"></i>Subject</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link"  href="quiz-history"><i class="ti-bookmark-alt"></i>Quiz History </a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link" data-toggle="tab" href="#edit-profile"><i class="ti-pencil-alt"></i>Edit Profile</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link" data-toggle="tab" href="#change-password"><i class="ti-lock"></i>Change Password</a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-9 col-md-8 col-sm-12 m-b30">
                                    <div class="profile-content-bx">
                                        <div class="tab-content">
                                            <div class="tab-pane active" id="courses">
                                                <div class="profile-head">
                                                    <h3>My Subjects</h3>
                                                    <div class="feature-filters style1 ml-auto">
                                                        <ul class="filters" data-toggle="buttons">
                                                            <li data-filter="" class="btn active">
                                                                <input type="radio">
                                                                <a href="#"><span>All</span></a> 
                                                            </li>
                                                            <li data-filter="publish" class="btn">
                                                                <input type="radio">
                                                                <a href="#"><span>Publish</span></a> 
                                                            </li>
                                                            <li data-filter="pending" class="btn">
                                                                <input type="radio">
                                                                <a href="#"><span>Pending</span></a> 
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                                <div class="courses-filter">
                                                    <div class="clearfix">
                                                        <ul id="masonry" class="ttr-gallery-listing magnific-image row">
                                                            <c:forEach items="${requestScope.listSubject}" var="p">
                                                                <li class="action-card col-xl-4 col-lg-6 col-md-12 col-sm-6 publish">
                                                                    <div class="cours-bx">
                                                                        <div class="action-box">
                                                                            <img src="${p.getSubject_img()}" alt="">
                                                                            <a href="subjectdetail?pid=${p.subject_id}" class="btn">Read More</a>
                                                                        </div>
                                                                        <div class="info-bx text-center">
                                                                            <h5><a href="subjectdetail?pid=${p.subject_id}">${p.getSubject_name()}</a></h5>
                                                                            <span>${p.getSubject_title()}</span>
                                                                        </div>
                                                                        <div class="text-center">
                                                                            <div >
                                                                                <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#unJoin${p.subject_id}">
                                                                                    UNENROLLL
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </li>
                                                                <div class="modal fade" style="margin-top: 100px" id="unJoin${p.subject_id}" tabindex="-1" aria-labelledby="unJoin${p.subject_id}" aria-hidden="true">

                                                                    <div class="modal-dialog">
                                                                        <div class="modal-content">
                                                                            <div class="modal-header">
                                                                                <h5 class="modal-title" id="joinNow${p.subject_id}">Confirmation</h5>
                                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                                    <span aria-hidden="true">&times;</span>
                                                                                </button>
                                                                            </div>
                                                                            <form action="${pageContext.request.contextPath}/profile" method="post">
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
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="tab-pane" id="quiz-results">
                                                <div class="profile-head">
                                                    <h3>Quiz Results</h3>
                                                </div>
                                                <div class="courses-filter">
                                                    <div class="row">
                                                        <div class="col-md-12 col-lg-12">
                                                            <div style="max-height: 400px; overflow-y: auto;">
                                                                <table id="quiz-results" class="table table-striped">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>Quiz</th>
                                                                            <th>Score</th>
                                                                            <th>Is Pass</th>
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
                                                                                <td>
                                                                                    <a type="button" href="quiz-result?quiz_id=${u.quiz.quiz_id}"class="btn btn-sm">View</a>
                                                                                    <a type="button" href="quiz-handle?id=${u.quiz.quiz_id}"class="btn btn-sm">Re-Take</a>
                                                                                </td>
                                                                            </tr>
                                                                        </c:forEach>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="tab-pane" id="edit-profile">
                                                <div class="profile-head">
                                                    <h3>Edit Profile</h3>
                                                </div>
                                                <form class="edit-profile" method="POST" action="profile?email=${user.email}" id="editProfileForm">
                                                    <div class="">
                                                        <span class="help"></span>
                                                        <div class="form-group row">
                                                            <div class="col-12 col-sm-9 col-md-9 col-lg-10 ml-auto">
                                                                <h3>1. Personal Details</h3>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Email</label>
                                                            <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                                <input class="form-control" name="email" type="text" readonly value="${user.email}">
                                                                <span class="error-message text-danger" id="emailError"></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Username</label>
                                                            <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                                <input class="form-control" name="userName" type="text" value="${user.userName}" required>
                                                                <span class="error-message text-danger" id="userNameError"></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Full Name</label>
                                                            <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                                <input class="form-control" name="fullName" type="text" value="${user.fullName}" required>
                                                                <span class="error-message text-danger" id="fullNameError"></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">School</label>
                                                            <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                                <input class="form-control" name="school" type="text" value="${user.school}" required>
                                                                <span class="error-message text-danger" id="schoolError"></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Phone No.</label>
                                                            <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                                <input class="form-control" name="phone" type="text" value="${user.phone}" required>
                                                                <span class="error-message text-danger" id="phoneError"></span>
                                                            </div>
                                                        </div>
                                                        <div class="seperator"></div>
                                                        <div class="m-form__seperator m-form__seperator--dashed m-form__seperator--space-2x"></div>
                                                    </div>
                                                    <div class="">
                                                        <div class="">
                                                            <div class="row">
                                                                <div class="col-12 col-sm-3 col-md-3 col-lg-2">
                                                                </div>
                                                                <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                                    <button type="submit" class="btn">Save changes</button>
                                                                    <button type="reset" class="btn-secondry">Cancel</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <div class="tab-pane" id="change-password">
                                                <div class="profile-head">
                                                    <h3>Change Password</h3>
                                                </div>
                                                <form class="edit-profile" method="POST" action="changepassword">
                                                    <div class="">
                                                        <div class="form-group row">
                                                            <div class="col-12 col-sm-8 col-md-8 col-lg-9 ml-auto">
                                                                <h3>Password</h3>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label class="col-12 col-sm-4 col-md-4 col-lg-3 col-form-label">Current Password</label>
                                                            <div class="col-12 col-sm-8 col-md-8 col-lg-7">
                                                                <input class="form-control" name="oldPass" type="password" value="">
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label class="col-12 col-sm-4 col-md-4 col-lg-3 col-form-label">New Password</label>
                                                            <div class="col-12 col-sm-8 col-md-8 col-lg-7">
                                                                <input class="form-control" name="newPass" type="password" value="">
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label class="col-12 col-sm-4 col-md-4 col-lg-3 col-form-label">Re Type New Password</label>
                                                            <div class="col-12 col-sm-8 col-md-8 col-lg-7">
                                                                <input class="form-control" name="confirmPass" type="password" value="">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-12 col-sm-4 col-md-4 col-lg-3">
                                                        </div>
                                                        <c:if test="${requestScope.error_msg !=  null}" >
                                                            <p style="color: red">${requestScope.error_msg}</p>
                                                        </c:if>
                                                        <div class="col-12 col-sm-8 col-md-8 col-lg-7">
                                                            <button type="submit" class="btn">Save changes</button>
                                                            <button type="reset" class="btn-secondry">Cancel</button>
                                                        </div>
                                                    </div>

                                                </form>
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
            <footer>
                <div class="footer-top">
                    <div class="pt-exebar">
                        <div class="container">
                            <div class="d-flex align-items-stretch">
                                <div class="pt-logo mr-auto">
                                    <a href="index.jsp"><img src="assets/images/logo-white.png" alt=""/></a>
                                </div>
                                <div class="pt-social-link">
                                    <ul class="list-inline m-a0">
                                        <li><a href="#" class="btn-link"><i class="fa fa-facebook"></i></a></li>
                                        <li><a href="#" class="btn-link"><i class="fa fa-twitter"></i></a></li>
                                        <li><a href="#" class="btn-link"><i class="fa fa-linkedin"></i></a></li>
                                        <li><a href="#" class="btn-link"><i class="fa fa-google-plus"></i></a></li>
                                    </ul>
                                </div>
                                <div class="pt-btn-join">
                                    <a href="#" class="btn ">Join Now</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-4 col-md-12 col-sm-12 footer-col-4">
                                <div class="widget">
                                    <h5 class="footer-title">Sign Up For A Newsletter</h5>
                                    <p class="text-capitalize m-b20">Weekly Breaking news analysis and cutting edge advices on job searching.</p>
                                    <div class="subscribe-form m-b20">
                                        <form class="subscription-form" action="http://educhamp.themetrades.com/demo/assets/script/mailchamp.php" method="post">
                                            <div class="ajax-message"></div>
                                            <div class="input-group">
                                                <input name="email" required="required"  class="form-control" placeholder="Your Email Address" type="email">
                                                <span class="input-group-btn">
                                                    <button name="submit" value="Submit" type="submit" class="btn"><i class="fa fa-arrow-right"></i></button>
                                                </span> 
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-lg-5 col-md-7 col-sm-12">
                                <div class="row">
                                    <div class="col-4 col-lg-4 col-md-4 col-sm-4">
                                        <div class="widget footer_widget">
                                            <h5 class="footer-title">Company</h5>
                                            <ul>
                                                <li><a href="index.jsp">Home</a></li>
                                                <li><a href="about-1.jsp">About</a></li>
                                                <li><a href="faq-1.jsp">FAQs</a></li>
                                                <li><a href="contact-1.jsp">Contact</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="col-4 col-lg-4 col-md-4 col-sm-4">
                                        <div class="widget footer_widget">
                                            <h5 class="footer-title">Get In Touch</h5>
                                            <ul>
                                                <li><a href="http://educhamp.themetrades.com/admin/index.jsp">Dashboard</a></li>
                                                <li><a href="blog-classic-grid.jsp">Blog</a></li>
                                                <li><a href="portfolio.jsp">Portfolio</a></li>
                                                <li><a href="event.jsp">Event</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="col-4 col-lg-4 col-md-4 col-sm-4">
                                        <div class="widget footer_widget">
                                            <h5 class="footer-title">Subjects</h5>
                                            <ul>
                                                <li><a href="courses.jsp">Subjects</a></li>
                                                <li><a href="courses-details.jsp">Details</a></li>
                                                <li><a href="membership.jsp">Membership</a></li>
                                                <li><a href="profile.jsp">Profile</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-lg-3 col-md-5 col-sm-12 footer-col-4">
                                <div class="widget widget_gallery gallery-grid-4">
                                    <h5 class="footer-title">Our Gallery</h5>
                                    <ul class="magnific-image">
                                        <li><a href="assets/images/gallery/pic1.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic1.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic2.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic2.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic3.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic3.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic4.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic4.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic5.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic5.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic6.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic6.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic7.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic7.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic8.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic8.jpg" alt=""></a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="footer-bottom">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 text-center"> <a target="_blank" href="https://www.templateshub.net">Templates Hub</a></div>
                        </div>
                    </div>
                </div>
            </footer>
            <!-- Footer END ==== -->
            <button class="back-to-top fa fa-chevron-up" ></button>
        </div>
        <!-- External JavaScripts -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/vendors/bootstrap/js/popper.min.js"></script>
        <script src="assets/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>
        <script src="assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
        <script src="assets/vendors/magnific-popup/magnific-popup.js"></script>
        <script src="assets/vendors/counter/waypoints-min.js"></script>
        <script src="assets/vendors/counter/counterup.min.js"></script>
        <script src="assets/vendors/imagesloaded/imagesloaded.js"></script>
        <script src="assets/vendors/masonry/masonry.js"></script>
        <script src="assets/vendors/masonry/filter.js"></script>
        <script src="assets/vendors/owl-carousel/owl.carousel.js"></script>
        <script src="assets/js/functions.js"></script>
        <script src="assets/js/contact.js"></script>
        <script src='assets/vendors/switcher/switcher.js'></script>
    </body>
    <script>
        document.getElementById('editProfileForm').addEventListener('submit', function (event) {
            var isValid = true;

            var userName = document.getElementsByName('userName')[0].value.trim();
            var fullName = document.getElementsByName('fullName')[0].value.trim();
            var school = document.getElementsByName('school')[0].value.trim();
            var phone = document.getElementsByName('phone')[0].value.trim();
            var facebook = document.getElementsByName('facebook')[0].value.trim();
            var twitter = document.getElementsByName('twitter')[0].value.trim();
            var instagram = document.getElementsByName('instagram')[0].value.trim();

            document.getElementById('userNameError').textContent = '';
            document.getElementById('fullNameError').textContent = '';
            document.getElementById('schoolError').textContent = '';
            document.getElementById('phoneError').textContent = '';
            document.getElementById('facebookError').textContent = '';
            document.getElementById('twitterError').textContent = '';
            document.getElementById('instagramError').textContent = '';

            if (!userName) {
                document.getElementById('userNameError').textContent = 'Username is required.';
                isValid = false;
            }

            if (!fullName) {
                document.getElementById('fullNameError').textContent = 'Full name is required.';
                isValid = false;
            }

            if (!school) {
                document.getElementById('schoolError').textContent = 'School is required.';
                isValid = false;
            }

            var phonePattern = /^\d+$/;
            if (!phone) {
                document.getElementById('phoneError').textContent = 'Phone number is required.';
                isValid = false;
            } else if (!phonePattern.test(phone)) {
                document.getElementById('phoneError').textContent = 'Please enter a valid phone number.';
                isValid = false;
            }

            var urlPattern = /^(https?:\/\/)?([\da-z.-]+)\.([a-z.]{2,6})([/\w .-]*)*\/?$/;
            if (facebook && !urlPattern.test(facebook)) {
                document.getElementById('facebookError').textContent = 'Please enter a valid Facebook URL.';
                isValid = false;
            }

            if (twitter && !urlPattern.test(twitter)) {
                document.getElementById('twitterError').textContent = 'Please enter a valid Twitter URL.';
                isValid = false;
            }

            if (instagram && !urlPattern.test(instagram)) {
                document.getElementById('instagramError').textContent = 'Please enter a valid Instagram URL.';
                isValid = false;
            }

            if (!isValid) {
                event.preventDefault();
            }
        });
    </script>
</html>

