<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- CSS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<!-- CSS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.1.0/css/select2.min.css" rel="stylesheet">

<!-- JavaScript -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.1.0/js/select2.min.js"></script>

<jsp:include page="./gui/header.jsp"></jsp:include>
    <main class="ttr-wrapper">
        <div class="container-fluid">
            <div class="db-breadcrumb">
                <h4 class="breadcrumb-title">Quiz Detail</h4>
                <ul class="db-breadcrumb-list">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fa fa-home"></i>Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/quiz-list">Quiz List</a></li>
                    <li>Quiz Detail</li>
                </ul>
            </div>

            <!-- Notification Section -->
        <c:if test="${not empty sessionScope.notification}">
            <div class="alert alert-success alert-dismissible fade show" role="alert" style="text-align: center">
                ${sessionScope.notification}
                <button type="button" class="btn-sm delete" data-dismiss="alert">x</button>
            </div>
            <%
                session.removeAttribute("notification");
            %>
        </c:if>
        <c:if test="${not empty sessionScope.notificationErr}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert" style="text-align: center">
                ${sessionScope.notificationErr}
                <button type="button" class="btn-sm delete" data-dismiss="alert">x</button>
            </div>
            <%
                session.removeAttribute("notificationErr");
            %>
        </c:if>

        <div class="row">
            <div class="col-lg-12 m-b30">
                <div class="widget-box">
                    <div class="wc-title">
                        <h1>Quiz Detail</h1>
                    </div>
                    <div class="widget-inner">
                        <div class="form-group col-12">
                            <label class="col-form-label-lg">Questions</label>
                            <c:if test="${s.isQuizTaken == false}"> <button style="float: right" type="button" class="btn btn-warning" data-toggle="modal" data-target="#add">Import question</button> </c:if>
                                <ul class="curriculum-list">
                                    <li>
                                        <ul>
                                        <c:choose>
                                            <c:when test="${empty questions}">
                                                <li>
                                                    <div class="curriculum-list-box">
                                                        <span style="color: red">This quiz has no question</span>
                                                    </div>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach items="${questions}" var="l" varStatus="status">
                                                    <li>
                                                        <div class="curriculum-list-box">
                                                            <span>Question ${status.index + 1}.</span> <a href="question-detail?id=${l.question_id}">${l.question_name}</a>
                                                        </div>
                                                        <c:if test="${s.isQuizTaken == false}">
                                                            <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#unJoin${l.question_id}"><li class="fa fa-trash"></li></button>
                                                                </c:if>
                                                    </li>

                                                    <!-- Form 2: Unenroll Confirmation Modal -->
                                                    <div class="modal fade" style="margin-top: 100px" id="unJoin${l.question_id}" tabindex="-1" aria-labelledby="unJoinLabel${l.question_id}" aria-hidden="true">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="unJoinLabel${l.question_id}">Confirmation</h5>
                                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                        <span aria-hidden="true">&times;</span>
                                                                    </button>
                                                                </div>
                                                                <form id="deleteForm" action="${pageContext.request.contextPath}/admin/quiz-detail" method="post">
                                                                    <input type="hidden" name="questionId" value="${l.question_id}">
                                                                    <input type="hidden" name="quizId" value="${param.id}">
                                                                    <input type="hidden" name="action" value="remove">
                                                                    <div class="modal-body">
                                                                        <p>Are you sure to remove this question from <span style="color: green; font-weight: bold">${s.quiz_name}</span>?</p>
                                                                        <p style="color: red">This action cannot be undone</p>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                                                                        <button type="submit" class="btn btn-primary">Yes</button>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                        <!-- Form 1: Edit Subject Details -->
                        <form class="edit-profile m-b30" action="${pageContext.request.contextPath}/admin/quiz-detail" method="post" onsubmit="return validateForm()">
                            <div class="row">
                                <div class="form-group col-6">
                                    <label class="col-form-label">Quiz Name</label>
                                    <div>
                                        <input class="form-control" name="quiz_name" type="text" value="${s.quiz_name}">
                                        <input class="form-control" name="id" type="hidden" value="${s.quiz_id}">
                                        <input class="form-control" name="action" type="hidden" value="edit">
                                        <span id="quiz_name_error" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="form-group col-6">
                                    <label class="col-form-label">Time limit (min)</label>
                                    <div>
                                        <input class="form-control" name="count_down" type="number"  step="1" value="${s.count_down}">
                                        <span id="count_down_error" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="form-group col-4">
                                    <label class="col-form-label">Min to pass</label>
                                    <div>
                                        <input class="form-control" name="min_to_pass" type="number"  step="5" value="${s.min_to_pass}">
                                        <span id="min_to_pass_error" class="text-danger"></span>
                                    </div>
                                </div>
                            
                                <div class="form-group col-4">
                                    <label class="col-form-label">Time Attempt</label>
                                    <div>
                                        <input class="form-control" name="time_attemp" type="number"  step="1" value="${s.attemp_time}">
                                        <span id="time_attemp_error" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="form-group col-6">
                                    <label class="col-form-label">Update At</label>
                                    <div>
                                        <input readonly=""class="form-control"   value="${s.updated_at}">
                                    </div>
                                </div>
                                <div class="form-group col-6">
                                    <label class="col-form-label">Created By</label>
                                    <div>
                                        <input readonly=""class="form-control"   value="${s.creator.userName}">
                                    </div>
                                </div>


                                <div class="col-12">
                                    <c:if test="${s.isQuizTaken == false}">
                                        <button type="submit" class="btn btn-success">Save changes</button>
                                    </c:if>
                                    <button type="button" onclick="location.href = 'quiz-list'" class="btn btn-danger">Back</button>
                                </div>
                            </div>
                        </form>
                        <!-- End of Form 1 -->
                    </div>
                </div>
            </div>         
        </div>
    </div>
</main>
<div class="modal fade" style="margin-top: 100px" id="add" tabindex="-1" aria-labelledby="addLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addLabel">Add Questions to ${s.quiz_name}</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <a href="${pageContext.request.contextPath}/static/template/template.xlsx" class="btn btn-secondary mt-3" download>Download Template</a>

            <form action="${pageContext.request.contextPath}/admin/quiz-detail" method="post" enctype="multipart/form-data">
                <input type="hidden" name="quizId" value="${param.id}">
                <input type="hidden" name="action" value="importQuestions">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="file">Select Excel File:</label>
                        <input type="file" class="form-control" name="file" accept=".xlsx, .xls">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                    <button type="submit" class="btn btn-primary">Yes</button>
                </div>
            </form>
        </div>
    </div>
</div>
<jsp:include page="./gui/footer.jsp"></jsp:include>

<script>
    function validateForm() {
        var isValid = true;
        document.getElementById('quiz_name_error').innerText = '';
        document.getElementById('count_down_error').innerText = '';
        document.getElementById('min_to_pass_error').innerText = '';

        var quizName = document.getElementsByName('quiz_name')[0].value;
        var quizNamePattern = /^[a-zA-Z0-9 ]{1,20}$/;
        if (!quizNamePattern.test(quizName)) {
            document.getElementById('quiz_name_error').innerText = 'Quiz Name must be 1-20 characters long and contain only letters and numbers.';
            isValid = false;
        }

        var countDown = document.getElementsByName('count_down')[0].value;
        if (countDown <= 0) {
            document.getElementById('count_down_error').innerText = 'Time limit must be greater than 0.';
            isValid = false;
        }
        var min_to_pass = document.getElementsByName('min_to_pass')[0].value;
        if (min_to_pass <= 0) {
            document.getElementById('min_to_pass_error').innerText = 'Min to pass must be greater than 0.';
            isValid = false;
        }
        var time_attemp = document.getElementsByName('time_attemp')[0].value;
        if (time_attemp <= 0) {
            document.getElementById('time_attemp_error').innerText = 'Time attempt must be greater than 0.';
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
