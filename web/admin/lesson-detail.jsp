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
                <h4 class="breadcrumb-title">Lesson Detail</h4>
                <ul class="db-breadcrumb-list">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fa fa-home"></i>Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/lesson-list"></i>List Lesson</a></li>
                    <li>Lesson Detail</li>
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
                        <h4>Lesson Detail</h4>
                    </div>
                    <div class="widget-inner">
                        <div class="form-group col-12">
                            <label class="col-form-label-lg">Quiz</label>  <button style="float: right" type="button" class="btn btn-warning" data-toggle="modal" data-target="#add">Add new Quiz</button>
                            <ul class="curriculum-list">
                                <li>
                                    <ul>
                                        <c:choose>
                                            <c:when test="${empty quiz}">
                                                <li>
                                                    <div class="curriculum-list-box">
                                                        <span style="color: red">This lesson has no Quiz</span>
                                                    </div>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach items="${quiz}" var="l" varStatus="status">
                                                    <li>
                                                        <div class="curriculum-list-box">
                                                            <span>Quiz ${status.index + 1}.</span> ${l.quiz_name}
                                                        </div>
                                                        <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#unJoin${l.quiz_id}"><li class="fa fa-trash"></li></button>
                                                    </li>

                                                    <!-- Form 2: Unenroll Confirmation Modal -->
                                                    <div class="modal fade" style="margin-top: 100px" id="unJoin${l.quiz_id}" tabindex="-1" aria-labelledby="unJoinLabel${l.quiz_id}" aria-hidden="true">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="unJoinLabel${l.quiz_id}">Confirmation</h5>
                                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                        <span aria-hidden="true">&times;</span>
                                                                    </button>
                                                                </div>
                                                                <form id="deleteForm" action="${pageContext.request.contextPath}/admin/lesson-detail" method="post">
                                                                    <input type="hidden" name="quizId" value="${l.quiz_id}">
                                                                    <input type="hidden" name="lessonId" value="${param.id}">
                                                                    <input type="hidden" name="action" value="remove">
                                                                    <div class="modal-body">
                                                                        <p>Are you sure to remove ${l.quiz_name} from ${s.lesson_name}?</p>
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
                        <!-- Form 1: Edit Lesson Details -->
                        <form class="edit-profile m-b30" action="${pageContext.request.contextPath}/admin/lesson-detail" method="post" onsubmit="return validateForm()">
                            <div class="row"> 
                                <div class="form-group col-6">
                                    <label class="col-form-label">Lesson Name</label>
                                    <div>
                                        <input class="form-control" name="name" type="text" value="${s.lesson_name}">
                                        <input class="form-control" name="id" type="hidden" value="${s.lesson_id}">
                                        <input class="form-control" name="action" type="hidden" value="edit">
                                        <span id="subject_name_error" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="form-group col-6">
                                    <label class="col-form-label">Creator</label>
                                    <div>
                                        <input class="form-control"  readonly="" type="text" value="${s.creator.userName}">

                                        <span id="subject_name_error" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="form-group col-6">
                                    <label class="col-form-label">Total Quiz</label>
                                    <div>
                                        <input class="form-control"  readonly="" type="text" value="${s.quiz_count}">

                                        <span id="subject_name_error" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="form-group col-6">
                                    <label class="col-form-label">Created At</label>
                                    <div>
                                        <input class="form-control"  readonly="" type="text" value="${s.createAt}">

                                        <span id="subject_name_error" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="form-group col-6">
                                    <label class="col-form-label">Lesson Description</label>
                                    <div>
                                        <textarea class="form-control" name="description" type="text" placeholder="Enter lesson description">${s.description}</textarea>
                                        <span id="description_error" class="text-danger"></span>
                                    </div>
                                </div>



                                <div class="col-12">
                                    <button type="submit" class="btn btn-success">Save changes</button>
                                    <button type="button" onclick="location.href = 'lesson-list'" class="btn btn-danger">Back</button>
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
                <h5 class="modal-title" id="addLabel">Add Quiz to ${s.lesson_name}</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form   action="${pageContext.request.contextPath}/admin/lesson-detail" method="post">
                <input type="hidden" name="lessonId" value="${param.id}">
                <input type="hidden" name="action" value="add">
                <div class="modal-body">
                    <select id="lessonSelect" multiple name="quizIds[]"> <!-- Use array notation to handle multiple selections -->
                        <option></option>
                        <c:forEach items="${listQ}" var="l">
                            <option value="${l.quiz_id}">${l.quiz_name}</option>
                        </c:forEach>
                    </select>

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

        // Clear previous error messages
        document.getElementById('subject_name_error').innerText = '';
        document.getElementById('title_error').innerText = '';
        document.getElementById('image_error').innerText = '';

        // Validate Subject Name
        var subjectName = document.getElementsByName('subject_name')[0].value;
        var subjectNamePattern = /^[a-zA-Z0-9 ]{1,20}$/;
        if (!subjectNamePattern.test(subjectName)) {
            document.getElementById('subject_name_error').innerText = 'Subject Name must be 1-20 characters long and contain only letters and numbers.';
            isValid = false;
        }
        document.getElementById('description_error').innerText = '';

        var description = document.getElementsByName('description')[0].value;

        if (description === null)) {
            document.getElementById('description_error').innerText = 'description  must be not null.';
            isValid = false;
        }


        // Validate Title
        var title = document.getElementsByName('title')[0].value;
        var titlePattern = /^[a-zA-Z0-9 ]{1,50}$/;
        if (!titlePattern.test(title)) {
            document.getElementById('title_error').innerText = 'Title must be 1-50 characters long and contain only letters, numbers, and spaces.';
            isValid = false;
        }

        // Validate Image URL
        var imageUrl = document.getElementsByName('image')[0].value;
        var urlPattern = /^(http|https):\/\/.+/;
        if (!urlPattern.test(imageUrl)) {
            document.getElementById('image_error').innerText = 'Image URL must start with http or https.';
            isValid = false;
        }

        return isValid;
    }

    $(document).ready(function () {
        $('#lessonSelect').select2({
            placeholder: 'Select lessons', // Placeholder text
            allowClear: true // Allow clearing selection
                    // Add more options as needed
        });
    });


</script>
