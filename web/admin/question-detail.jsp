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
                <h4 class="breadcrumb-title">Question Detail</h4>
                <ul class="db-breadcrumb-list">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fa fa-home"></i>Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/question-list"></i>Question List</li>
                    <li>Question Detail</li>
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
                        <h4>Question Detail</h4>
                    </div>
                    <div class="widget-inner">
                        <div class="form-group col-12">
                            <label class="col-form-label-lg">Answer</label>  
                            <ul class="curriculum-list">
                                <li>
                                    <ul>
                                        <c:choose>
                                            <c:when test="${empty answers}">
                                                <li>
                                                    <div class="curriculum-list-box">
                                                        <span style="color: red">This Question has no Answer</span>
                                                    </div>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <form action="${pageContext.request.contextPath}/admin/question-detail" method="post">
                                                    <table>
                                                        <thead>
                                                            <tr>
                                                                <th>No</th>
                                                                <th>Content</th>
                                                                <th>Is Correct</th>
                                                                <th>Action</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach items="${answers}" var="l" varStatus="status">
                                                                <tr id="answerRow${l.answer_id}">
                                                                    <td>Answer ${status.index + 1}</td>
                                                                    <td>${l.answer_content}</td>
                                                                    <td>
                                                                        <input type="radio" name="correctAnswerId" value="${l.answer_id}" <c:if test="${l.isCorrect}">checked</c:if> />
                                                                        </td>
                                                                        <td>
                                                                            <button type="button" class="btn btn-warning" onclick="deleteAnswer(${question.question_id}, ${l.answer_id})">
                                                                            <i class="fa fa-trash"></i>
                                                                        </button>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                    <button type="submit" class="btn btn-primary">Update Correct Answer</button>
                                                    <input type="hidden" name="questionId" value="${question.question_id}">
                                                    <input type="hidden" name="action" value="updateCorrectAnswer">
                                                </form>
                                            </c:otherwise>
                                        </c:choose>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                       
                        <form class="edit-profile m-b30" action="${pageContext.request.contextPath}/admin/question-detail" method="post" onsubmit="return validateForm()">
                            <div class="row"> 
                                <div class="form-group col-6">
                                    <label class="col-form-label">Question Detail</label>
                                    <div>
                                        <input class="form-control" name="name" type="text" value="${question.question_name}">
                                        <input class="form-control" name="id" type="hidden" value="${question.question_id}">
                                        <input class="form-control" name="action" type="hidden" value="edit">
                                        <span id="subject_name_error" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <button type="submit" class="btn btn-success">Save changes</button>
                                    <button type="button" onclick="location.href = 'question-list'" class="btn btn-danger">Back</button>
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

<jsp:include page="./gui/footer.jsp"></jsp:include>

    <script>
        function validateForm() {
            var isValid = true;

            // Clear previous error messages
            document.getElementById('subject_name_error').innerText = '';
            // Validate Subject Name
            var subjectName = document.getElementsByName('name')[0].value;
            var subjectNamePattern = /^[a-zA-Z0-9 ]{1,50}$/;
            if (!subjectNamePattern.test(subjectName)) {
                document.getElementById('subject_name_error').innerText = 'Question detail  must be 1-50 characters long and contain only letters and numbers.';
                isValid = false;
            }

            return isValid;
        }

        function deleteAnswer(questionId, answerId) {
            if (confirm('Are you sure you want to delete this answer?')) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/question-detail',
                    type: 'POST',
                    data: {
                        questionId: questionId,
                        answerId: answerId,
                        action: 'delete'
                    },
                    success: function (response) {
                        if (response === 'success') {
                            $('#answerRow' + answerId).remove();
                            alert('Answer deleted successfully.');
                        } else {
                            alert('Failed to delete the answer.');
                        }
                    },
                    error: function () {
                        alert('Error while deleting the answer.');
                    }
                });
            }
        }
</script>
