<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="./gui/header.jsp"></jsp:include>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>

    <main class="ttr-wrapper">
        <div class="container-fluid">
            <!-- Breadcrumb, notification and other sections -->
            <div class="db-breadcrumb">
                <h4 class="breadcrumb-title">Question List</h4>
                <ul class="db-breadcrumb-list">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fa fa-home"></i>Home</a></li>
                <li>Question List</li>
            </ul>
        </div>  
        <c:if test="${not empty sessionScope.notification}">
            <div class="alert alert-success alert-dismissible fade show" role="alert" style="text-align: center">
                ${sessionScope.notification}
                <button type="button" class="btn-danger" data-dismiss="alert" aria-label="Close">X</button>
            </div>
            <%
                session.removeAttribute("notification");
            %>
        </c:if>
        <c:if test="${not empty sessionScope.notificationErr}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert"  style="text-align: center">
                ${sessionScope.notificationErr}
                <button type="button" class="btn-danger" data-dismiss="alert" >X</button>
            </div>
            <%
                session.removeAttribute("notificationErr");
            %>
        </c:if>

        <!-- Form and Filter Section -->
        <form action="question-list" method="get">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <div class="input-group" style="width: 80%">
                            <input type="text" class="form-control" name="search" placeholder="Enter name to search" value="${param.search}">
                        </div>
                    </div>
                </div>
                <div class="feature-filters clearfix center m-b40 col-md-4" style="text-align: right; margin-top: 9px">
                    <ul class="filters">
                        <li class="btn ${param.status == null || param.status == '' ? 'active' : ''}">
                            <a href="question-list?search=${param.search}&status=&quiz=${param.quiz}&page=1"><span>All</span></a>
                        </li>
                        <li class="btn ${param.status == '1' ? 'active' : ''}">
                            <a href="question-list?search=${param.search}&status=1&quiz=${param.quiz}&page=1"><span>Published</span></a>
                        </li>
                        <li class="btn ${param.status == '0' ? 'active' : ''}">
                            <a href="question-list?search=${param.search}&status=0&quiz=${param.quiz}&page=1"><span>Un-publish</span></a>
                        </li>
                    </ul>
                </div>
                <div class="clearfix center m-b40 col-md-2" style="width: 120px">
                    <select class="form-control" id="quizSelect" name="quiz" onchange="location.href = '?search=${param.search}&status=${param.status}&quiz=' + this.value + '&page=1'">
                        <option value="">Choose quiz</option>
                        <c:forEach items="${listQuiz}" var="m">
                            <option value="${m.quiz_id}" ${param.quiz == m.quiz_id ? 'selected' : ''}>${m.quiz_name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <input type="hidden" name="status" value="${param.status}">
            <input type="hidden" name="quiz" value="${param.quiz}">
            <input type="hidden" name="page" value="1">
        </form>
        <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#add">Import Question</button>

        <!-- Question List Table -->
        <div class="row">
            <div class="col-12">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Name</th>
                            <th>Quiz</th>
                            <th>Total Answer</th>
                            <th>Status</th>
                            <th style="text-align: center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="s" items="${question}" varStatus="status">

                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${s.question_name}</td>
                                <c:if test="${s.quiz_name != null}">
                                    <td>${s.quiz_name}</td>
                                </c:if>
                                <c:if test="${s.quiz_name == null}">
                                    <td style="color: red">No Quiz</td>
                                </c:if>
                                <td>${s.answer_count}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${s.status == 1}"> <span style="color: green">Published</span></c:when>
                                        <c:otherwise><span style="color: red">Un-publish</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="display: inline-flex; gap: 5px;">
                                    <form id="statusForm_${s.question_id}" action="question-list" method="post">
                                        <input type="hidden" name="question_id" value="${s.question_id}">
                                        <input type="hidden" name="action" value="change-status">
                                        <input type="hidden" name="status" value="${s.status}">
                                        <button class="btn-${s.status == 1 ? 'danger' : 'success'}" type="submit" onclick="return confirmStatusChange(${s.question_id}, ${s.status})">${s.status == 1 ? 'Unpublish' : 'Publish'}</button>
                                    </form>
                                    <a style="display: inline-flex; gap: 5px;" type="button" href="question-detail?id=${s.question_id}"  class="btn-info">Detail</a>
                                    <c:if test="${s.quiz_name == null}">
                                        <form id="statusForm_${s.question_id}" action="question-list" method="post" onsubmit="return confirmDelete(${s.question_id})">
                                            <input type="hidden" name="question_id" value="${s.question_id}">
                                            <input type="hidden" name="action" value="delete">
                                            <button type="submit" class="btn btn-sm btn-primary"><i class="fa fa-trash"></i></button>
                                        </form>

                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Pagination -->
        <nav class="mt-3" aria-label="Page navigation example">
            <ul class="pagination justify-content-center">
                <c:if test="${currentPage > 1}">
                    <li class="page-item">
                        <a class="btn btn-primary" href="?search=${param.search}&status=${param.status}&quiz=${param.quiz}&page=${currentPage - 1}">Previous</a>
                    </li>
                </c:if>
                <c:forEach var="pageNum" begin="1" end="${totalPages}">
                    <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                        <a class="btn btn-primary" href="?search=${param.search}&status=${param.status}&quiz=${param.quiz}&page=${pageNum}">${pageNum}</a>
                    </li>
                </c:forEach>
                <c:if test="${currentPage < totalPages}">
                    <li class="page-item">
                        <a class="btn btn-primary" href="?search=${param.search}&status=${param.status}&quiz=${param.quiz}&page=${currentPage + 1}">Next</a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>
</main>

<!-- Modal for adding new lesson -->
<div class="modal fade" style="margin-top: 100px" id="add" tabindex="-1" aria-labelledby="add" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="add">Import Question</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <a href="../static/template/Book1.xlsx" class="btn btn-secondary mt-3" download>Download Template</a>

            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/admin/question-list" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                    <div class="form-group">
                        <input type="hidden" name="action" value="add">
                        <input type="file" name="file" required>
                    </div>
                    <button style="float: right" type="submit" class="btn btn-primary">Add</button>
                </form>
            </div>
        </div>
    </div>
</div>


<!-- Custom Scripts -->
<script>
    function confirmStatusChange(quizId, currentStatus) {
        var action = currentStatus == 1 ? 'unpublish' : 'publish';
        return confirm(`Are you sure you want to change status of this quesion?`);
    }
</script>
<script>
    function confirmDelete(questionId) {
        return confirm("Are you sure you want to delete this question?");
    }
</script>


<jsp:include page="./gui/footer.jsp"></jsp:include>
