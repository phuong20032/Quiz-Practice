<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="./gui/header.jsp"></jsp:include>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>

    <main class="ttr-wrapper">
        <div class="container-fluid">
            <!-- Breadcrumb, notification and other sections -->
            <div class="db-breadcrumb">
                <h4 class="breadcrumb-title">Quiz list</h4>
                <ul class="db-breadcrumb-list">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fa fa-home"></i>Home</a></li>
                <li>Quiz list</li>
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
        <form action="quiz-list" method="get">
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
                            <a href="quiz-list?search=${param.search}&status=&lesson=${param.lesson}&page=1"><span>All</span></a>
                        </li>
                        <li class="btn ${param.status == '1' ? 'active' : ''}">
                            <a href="quiz-list?search=${param.search}&status=1&lesson=${param.lesson}&page=1"><span>Published</span></a>
                        </li>
                        <li class="btn ${param.status == '0' ? 'active' : ''}">
                            <a href="quiz-list?search=${param.search}&status=0&lesson=${param.lesson}&page=1"><span>Un-publish</span></a>
                        </li>
                    </ul>
                </div>
                <div class="clearfix center m-b40 col-md-2" style="width: 120px">
                    <select class="form-control" id="subjectSelect" name="lesson" onchange="location.href = '?search=${param.search}&status=${param.status}&lesson=' + this.value + '&page=1'">
                        <option value="">Choose Lesson</option>
                        <c:forEach items="${listS}" var="m">
                            <option value="${m.lesson_id}" ${param.lesson == m.lesson_id ? 'selected' : ''}>${m.lesson_name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <input type="hidden" name="status" value="${param.status}">
            <input type="hidden" name="lesson" value="${param.lesson}">
            <input type="hidden" name="page" value="1">
        </form>
        <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#add">Add quiz</button>

        <!-- Quiz list Table -->
        <div class="row">
            <div class="col-12">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Name</th>
                            <th>Lesson</th>
                            <th>Creator</th>
                            <th>Total Question</th>
                            <th>Time limit</th>
                            <th>Min Grade</th>
                            <th>Pass Rate</th>
                            <th>Time Attempt</th>

                            <th>Status</th>
                            <th style="text-align: center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="s" items="${quiz}" varStatus="status">

                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${s.quiz_name}</td>
                                <c:if test="${s.lesson_name != null}">
                                    <td>${s.lesson_name}</td>
                                </c:if>
                                <c:if test="${s.lesson_name == null}">
                                    <td style="color: red">No Lesson</td>
                                </c:if>
                                <td>${s.creator.userName}</td>
                                <td>${s.total_question}  <a href="question-list?quiz=${s.quiz_id}"><i class="ti-eye"></i></a></td>
                                <td>${s.count_down} min</td>
                                <td>> ${s.min_to_pass}% to pass</td>
                                <td>${s.pass_rate}%</td>
                                <td>${s.attemp_time}</td>

                                <td>
                                    <c:choose>
                                        <c:when test="${s.status == 1}"> <span style="color: green">Published</span></c:when>
                                        <c:otherwise><span style="color: red">Un-publish</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="display: inline-flex; gap: 5px;">
                                    <c:if test="${s.isQuizTaken == false}">
                                        <form id="statusForm_${s.quiz_id}" action="quiz-list" method="post">
                                            <input type="hidden" name="quiz_id" value="${s.quiz_id}">
                                            <input type="hidden" name="action" value="change-status">
                                            <input type="hidden" name="status" value="${s.status}">
                                            <button class="btn-${s.status == 1 ? 'danger' : 'success'}" type="submit" onclick="return confirmStatusChange(${s.quiz_id}, ${s.status})">${s.status == 1 ? 'Unpublish' : 'Publish'}</button>
                                        </form>
                                    </c:if>
                                    <a type="button" href="quiz-detail?id=${s.quiz_id}"  class="btn-info">Detail</a>
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
                        <a class="btn btn-primary" href="?search=${param.search}&status=${param.status}&subject=${param.subject}&page=${currentPage - 1}">Previous</a>
                    </li>
                </c:if>
                <c:forEach var="pageNum" begin="1" end="${totalPages}">
                    <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                        <a class="btn btn-primary" href="?search=${param.search}&status=${param.status}&subject=${param.subject}&page=${pageNum}">${pageNum}</a>
                    </li>
                </c:forEach>
                <c:if test="${currentPage < totalPages}">
                    <li class="page-item">
                        <a class="btn btn-primary" href="?search=${param.search}&status=${param.status}&subject=${param.subject}&page=${currentPage + 1}">Next</a>
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
                <h5 class="modal-title" id="add">Add new quiz</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/admin/quiz-list" method="post" onsubmit="return validateForm()">
                    <div class="form-group">
                        <label for="quiz_name">Quiz name</label>
                        <input class="form-control" name="quiz_name" type="text" placeholder="Enter quiz name">
                        <span id="quiz_name_error" class="text-danger"></span>
                        <hr>
                        <label for="count_down">Time limit (min)</label>
                        <input class="form-control" name="count_down" type="number" step="1" placeholder="Enter time limit">
                        <span id="count_down_error" class="text-danger"></span>
                        <br>
                        <label for="count_down">Min to pass (%)</label>
                        <input class="form-control" name="min_to_pass" type="number" step="5" placeholder="Enter min persen to pass quiz">
                        <label for="time_attemp">Time Attempt</label>
                        <input class="form-control" name="time_attempt" type="number" step="1" placeholder="Enter times to attempt quiz">
                        <input type="hidden" name="action" value="add">
                        <span id="min_to_pass_error" class="text-danger"></span>
                        <span id="time_attemp_error" class="text-danger"></span>
                    </div>
                    <button style="float: right" type="submit" class="btn btn-primary">Add</button>
                </form>
            </div>

        </div>
    </div>
</div>

<!-- Custom Scripts -->
<script>
    function confirmStatusChange(subjectId, currentStatus) {
        var action = currentStatus == 1 ? 'unpublish' : 'publish';
        return confirm(`Are you sure you want to change status of this subject?`);
    }

    function validateForm() {
        var isValid = true;
        document.getElementById('quiz_name_error').innerText = '';
        document.getElementById('count_down_error').innerText = '';
        document.getElementById('min_to_pass_error').innerText = '';
        document.getElementById('time_attemp_error').innerText = '';

        var quizName = document.getElementsByName('quiz_name')[0].value;
        var quizNamePattern = /^[a-zA-Z0-9\s]{1,20}$/;
        if (!quizNamePattern.test(quizName)) {
            document.getElementById('quiz_name_error').innerText = 'Quiz Name must be 1-20 characters long and contain only letters, numbers and spaces.';
            isValid = false;
        }

        var countDown = document.getElementsByName('count_down')[0].value;
        if (countDown <= 0) {
            document.getElementById('count_down_error').innerText = 'Time limit must be greater than 0.';
            isValid = false;
        }

        var minToPass = document.getElementsByName('min_to_pass')[0].value;
        if (minToPass <= 0) {
            document.getElementById('min_to_pass_error').innerText = 'Min to pass must be greater than 0.';
            isValid = false;
        }

        var timeAttempt = document.getElementsByName('time_attemp')[0].value;
        if (timeAttempt <= 0) {
            document.getElementById('time_attemp_error').innerText = 'Times attempt must be greater than 0.';
            isValid = false;
        }

        return isValid;
    }


    $(document).ready(function () {
        $('#subjectSelect').select2({
            placeholder: 'Choose Subject',
            allowClear: true
        });
    });
</script>

<jsp:include page="./gui/footer.jsp"></jsp:include>
