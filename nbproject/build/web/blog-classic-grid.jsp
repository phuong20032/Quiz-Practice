<%-- ////////
    Document   : blog-classic-grid
    Created on : May 14, 2024, 3:05:25 AM
    Author     : User
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/gui/header.jsp"></jsp:include>
    <!-- header END -->
    <!-- Inner Content Box ==== -->
    <div class="page-content bg-white">
        <!-- Page Heading Box ==== -->
        <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner1.jpg);">
            <div class="container">
                <div class="page-banner-entry">
                    <h1 class="text-white">Blog Classic</h1>
                </div>
            </div>
        </div>
        <div class="breadcrumb-row">
            <div class="container">
                <ul class="list-inline">
                    <li><a href="home">Home</a></li>
                    <li>Blog Classic</li>
                </ul>
            </div>
        </div>


        <!-- Page Heading Box END ==== -->
        <!-- Page Content Box ==== -->
    <c:if test="${sessionScope.account.getRole().getRole_id() == 2}">
        <div style="margin-left: 80px ; margin-top: 10px" class="col-lg-12">
            <button type="submit" class="btn button-md"><a href="createBlog.jsp">Create Blog</a></button>
        </div>
    </c:if>
    <!-- ****** create bloge just only teacher can view ********** -->


    <!-- ******  ********** -->
    <div class="content-block">
        <!-- Blog Grid ==== -->
        <div class="section-area section-sp1">
            <div class="container">
                <div class="ttr-blog-grid-3 row" id="masonry">
                    <!-- ------------------ *****  start display blog   ********                            -->

                    <c:forEach items="${requestScope.listBlog}" var="p">  
                        <div class="post action-card col-lg-4 col-md-6 col-sm-12 col-xs-12 m-b40">
                            <div class="recent-news">
                                <div class="action-box">
                                    <img src="${p.getBlog_img()}" alt="">
                                </div>
                                <div class="info-bx">
                                    <ul class="media-post">
                                        <li><a href="#"><i class="fa fa-calendar"></i>${p.getCreated_at()}</a></li>
                                        <li><a href="#"><i class="fa fa-user"></i>By ${p.getAuthor()}</a></li>
                                    </ul>
                                    <h5 class="post-title"><a href="blog-details.jsp">${p.getTitle()}</a></h5>
                                    <p>${p.getDescription()}</p>
                                    <div class="post-extra">
                                        <a href="blogdetail?id=${p.getBlog_id()}" class="btn-link">READ MORE</a>
                                        <a href="#" class="comments-bx"><i class="fa fa-comments-o"></i>20 Comment</a>&nbsp; &nbsp; &nbsp; &nbsp;
                                        <!--                  
                                                   ********************    start    update Blog ***************-->
                                        <!--                                                    <div class="widget_tag_cloud">
                                                                                                <div class="tagcloud"> 
                                                                                                    <a href="updateBlogServlet?blogId=${p.getBlog_id()}"> Update </a> 
                                                                                                </div>
                                                                                            </div>-->
                                        <!--                                                 *******end update blog********-->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <!-- ------------------ *****  End display blog   ********                            -->




                </div>


                <!-- **** Pagination *** ==== -->
                <div class="pagination-bx rounded-sm gray clearfix">
                    <ul class="pagination">
                        <c:forEach begin="1" end="${endPage}" var="i">
                            <li class="${index == i?"active":""}"><a href="blog?index=${i}">${i}</a></li>
                            </c:forEach>
                    </ul>
                </div>
                <!----*** Pagination END **** -->



            </div>
        </div>
        <!-- Blog Grid END ==== -->
    </div>
    <!-- Page Content Box END ==== -->
</div>
<!-- Page Content Box END ==== -->
<!-- Footer ==== -->
<jsp:include page="/gui/footer.jsp"></jsp:include>  