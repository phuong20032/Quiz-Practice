
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/gui/header.jsp"></jsp:include>

    <style>
        .info-bx {
            text-align: center;
        }
        .info-bx h5 {
            margin: 0;
            padding: 0;
        }
        .info-bx h5 a {
            text-decoration: none;
            color: inherit;
        }
        .info-bx span {
            display: block;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 100%; /* Adjust this width as needed */
        }
    </style>
    <div class="page-content bg-white">
        <!-- Main Slider -->
        <div class="section-area section-sp1 ovpr-dark bg-fix online-cours" style="background-image:url(assets/images/background/bg1.jpg);">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 text-center text-white">
                        <h2>Online Subjectss To Learn</h2>
                        <h5>Own Your Feature Learning New Lessons</h5>
                        <form class="cours-search" action="subjectlist" method="get">
                            <div class="input-group">
                                <input value="${txtS}" name="txt" type="text" class="form-control" placeholder="What do you want to learn today?" >
                            <div class="input-group-append">
                                <button class="btn" type="submit" >Search</button> 
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="mw800 m-auto">
                <div class="row">
                    <div class="col-md-4 col-sm-6">
                        <div class="cours-search-bx m-b30">
                            <div class="icon-box">
                                <h3><i class="ti-user"></i><span class="counter">5</span>M</h3>
                            </div>
                            <span class="cours-search-text">Over 5 million student</span>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-6">
                        <div class="cours-search-bx m-b30">
                            <div class="icon-box">
                                <h3><i class="ti-book"></i><span class="counter">30</span>K</h3>
                            </div>
                            <span class="cours-search-text">30,000 Subjects.</span>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-12">
                        <div class="cours-search-bx m-b30">
                            <div class="icon-box">
                                <h3><i class="ti-layout-list-post"></i><span class="counter">20</span>K</h3>
                            </div>
                            <span class="cours-search-text">Learn Anything Online.</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Main Slider -->
    <div class="content-block">
        <!-- Popular Courses -->
        <div class="section-area section-sp2 popular-courses-bx">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 heading-bx left">
                        <h2 class="title-head">Popular <span>Subjects</span></h2>
                        <p>It is a long established fact that a reader will be distracted by the readable content of a page</p>
                    </div>
                </div>
                <div class="row">
                    <div class="courses-carousel owl-carousel owl-btn-1 col-12 p-lr0">
                        <c:forEach items="${ListS}" var="s">
                            <div class="item">
                                <div class="cours-bx">
                                    <div class="action-box">
                                        <img src="${s.subject_img}" alt="">
                                        <a href="subjectdetail?pid=${s.subject_id}" class="btn">Read More</a>
                                    </div>
                                    <div class="info-bx text-center">
                                        <h5><a href="subjectdetail?pid=${s.subject_id}">${s.subject_name}</a></h5>
                                        <span>${s.major_name}</span>
                                    </div>

                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <!-- Popular Courses END -->

        <!-- New Courses -->
<!--        <div class="section-area section-sp2 popular-courses-bx">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 heading-bx left">
                        <h2 class="title-head">New <span>Post</span></h2>
                        <p>It is a long established fact that a reader will be distracted by the readable content of a page</p>
                    </div>
                </div>
                <div class="row">
                    <div class="courses-carousel owl-carousel owl-btn-1 col-12 p-lr0">
                        <c:forEach items="${top5Blog}" var="b">
                            <div class="item">
                                <div class="cours-bx">
                                    <div class="action-box">
                                        <img src="${b.blog_img}" alt="">
                                        <a href="blogdetail?id=${b.blog_id}" class="btn">Read More</a>
                                    </div>

                                    <div class="info-bx text-center">
                                        <h5><a href="subjectdetail?pid=${sn.subject_id}">${sn.subject_name}</a></h5>
                                        <span>${b.title}</span>
                                    </div>
                                    <div class="infor-bx text-center">
                                        <div class="text-center">
                                            <span>Author: ${b.author}</span>
                                        </div>
                                         
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>-->
    </div>
    <!-- New Courses END -->

    <div class="section-area section-sp2 bg-fix ovbl-dark join-bx text-center" style="background-image:url(assets/images/background/bg1.jpg);">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="join-content-bx text-white">
                        <h2>Learn a new skill online on <br> your time</h2>
                        <h4><span class="counter">57,000</span> Online Subjects</h4>
                        <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.</p>
                        <a href="#" class="btn button-md">Join Now</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Form END -->
    <div class="section-area section-sp1">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 m-b30">
                    <h2 class="title-head ">Learn a new skill online<br> <span class="text-primary"> on your time</span></h2>
                    <h4><span class="counter">57,000</span> Online Subjects</h4>
                    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type.</p>
                    <a href="#" class="btn button-md">Join Now</a>
                </div>
                <div class="col-lg-6">
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 m-b30">
                            <div class="feature-container">
                                <div class="feature-md text-white m-b20">
                                    <a href="#" class="icon-cell"><img src="assets/images/icon/icon1.png" alt=""></a> 
                                </div>
                                <div class="icon-content">
                                    <h5 class="ttr-tilte">Our Philosophy</h5>
                                    <p>Lorem ipsum dolor sit amet, consectetuer adipiscing.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 m-b30">
                            <div class="feature-container">
                                <div class="feature-md text-white m-b20">
                                    <a href="#" class="icon-cell"><img src="assets/images/icon/icon2.png" alt=""></a> 
                                </div>
                                <div class="icon-content">
                                    <h5 class="ttr-tilte">Kingster's Principle</h5>
                                    <p>Lorem ipsum dolor sit amet, consectetuer adipiscing.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 m-b30">
                            <div class="feature-container">
                                <div class="feature-md text-white m-b20">
                                    <a href="#" class="icon-cell"><img src="assets/images/icon/icon3.png" alt=""></a> 
                                </div>
                                <div class="icon-content">
                                    <h5 class="ttr-tilte">Key Of Success</h5>
                                    <p>Lorem ipsum dolor sit amet, consectetuer adipiscing.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 m-b30">
                            <div class="feature-container">
                                <div class="feature-md text-white m-b20">
                                    <a href="#" class="icon-cell"><img src="assets/images/icon/icon4.png" alt=""></a> 
                                </div>
                                <div class="icon-content">
                                    <h5 class="ttr-tilte">Our Philosophy</h5>
                                    <p>Lorem ipsum dolor sit amet, consectetuer adipiscing.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Testimonials -->
    <div class="section-area section-sp1 bg-fix ovbl-dark text-white" style="background-image:url(assets/images/background/bg1.jpg);">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-6 col-sm-6 col-6 m-b30">
                    <div class="counter-style-1">
                        <div class="text-white">
                            <span class="counter">3000</span><span>+</span>
                        </div>
                        <span class="counter-text">Completed Projects</span>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6 col-6 m-b30">
                    <div class="counter-style-1">
                        <div class="text-white">
                            <span class="counter">2500</span><span>+</span>
                        </div>
                        <span class="counter-text">Happy Clients</span>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6 col-6 m-b30">
                    <div class="counter-style-1">
                        <div class="text-white">
                            <span class="counter">1500</span><span>+</span>
                        </div>
                        <span class="counter-text">Questions Answered</span>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6 col-6 m-b30">
                    <div class="counter-style-1">
                        <div class="text-white">
                            <span class="counter">1000</span><span>+</span>
                        </div>
                        <span class="counter-text">Ordered Coffee's</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Testimonials END -->
    <!-- Testimonials ==== -->
    <div class="section-area section-sp2">
        <div class="container">
            <div class="row">
                <div class="col-md-12 heading-bx left">
                    <h2 class="title-head text-uppercase">what people <span>say</span></h2>
                    <p>It is a long established fact that a reader will be distracted by the readable content of a page</p>
                </div>
            </div>
            <div class="testimonial-carousel owl-carousel owl-btn-1 col-12 p-lr0">
                <c:forEach items="${ListU}" var="u">
                    <div class="item">
                        <div class="testimonial-bx">
                            <div class="testimonial-thumb">
                                <img src="assets/images/testimonials/pic1.jpg" alt="">
                            </div>
                            <div class="testimonial-info">
                                <h5 class="name">${u.fullName}</h5>
                                <p>${u.userName}</p>
                            </div>
                            <div class="testimonial-content">
                                <p>${u.description}</p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <!-- Testimonials END ==== -->
</div>
<!-- contact area END -->
</div>
<!-- Content END-->
<!-- Footer ==== -->
<jsp:include page="/gui/footer.jsp"></jsp:include>