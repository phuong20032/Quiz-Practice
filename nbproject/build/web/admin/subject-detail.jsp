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
                <h4 class="breadcrumb-title">Subject Detail</h4>
                <ul class="db-breadcrumb-list">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fa fa-home"></i>Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/subject-list">List Subject</a></li>
                    <li>Subject Detail</li>
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
                        <h4>Subject Detail</h4>
                    </div>
                    <div class="widget-inner">
                        <div class="form-group col-12">
                            <label class="col-form-label-lg">Lesson</label>  
                            <c:if test="${account.role.role_id == 3}" >
                                <button style="float: right" type="button" class="btn btn-warning" data-toggle="modal" data-target="#add">Add new lesson</button>
                            </c:if>
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
                                                        <c:if test="${account.role.role_id == 3}" >

                                                            <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#unJoin${l.lesson_id}"><li class="fa fa-trash"></li></button>
                                                                </c:if>
                                                    </li>

                                                    <!-- Form 2: Unenroll Confirmation Modal -->
                                                    <div class="modal fade" style="margin-top: 100px" id="unJoin${l.lesson_id}" tabindex="-1" aria-labelledby="unJoinLabel${l.lesson_id}" aria-hidden="true">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="unJoinLabel${l.lesson_id}">Confirmation</h5>
                                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                        <span aria-hidden="true">&times;</span>
                                                                    </button>
                                                                </div>
                                                                <form id="deleteForm" action="${pageContext.request.contextPath}/admin/subject-detail" method="post">
                                                                    <input type="hidden" name="lessonId" value="${l.lesson_id}">
                                                                    <input type="hidden" name="subjectId" value="${param.subjectId}">
                                                                    <input type="hidden" name="action" value="remove">
                                                                    <div class="modal-body">
                                                                        <p>Are you sure to remove ${l.lesson_name} from ${s.subject_name}?</p>
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
                        <c:if test="${account.role.role_id == 3}" >

                            <form class="edit-profile m-b30" action="${pageContext.request.contextPath}/admin/subject-detail" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                                <div class="row">
                                    <div class="form-group col-6">
                                        <label class="col-form-label">Major</label>
                                        <div>
                                            <select name="major_id" class="form-control">
                                                <c:forEach var="major" items="${listM}">
                                                    <option value="${major.major_id}" <c:if test="${major.major_id == s.major_id}">selected</c:if>>${major.major_name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group col-6">
                                        <label class="col-form-label">Subject Name</label>
                                        <div>
                                            <input class="form-control" name="subject_name" type="text" value="${s.subject_name}">
                                            <input class="form-control" name="id" type="hidden" value="${s.subject_id}">
                                            <input class="form-control" name="action" type="hidden" value="edit">
                                            <span id="subject_name_error" class="text-danger"></span>
                                        </div>
                                    </div>
                                    <div class="form-group col-6">
                                        <label class="col-form-label">Image</label>
                                        <div>
                                            <input class="form-control" name="image" type="file">
                                            <span id="image_error" class="text-danger"></span>
                                        </div>
                                    </div>
                                    <div class="form-group col-6">
                                        <label class="col-form-label">Current Image</label>
                                        <div>
                                            <img src="${pageContext.request.contextPath}/${s.subject_img}" alt="Subject Image" width="100">
                                        </div>
                                    </div>
                                    <div class="form-group col-6">
                                        <label class="col-form-label">Title</label>
                                        <div>
                                            <input class="form-control" type="text" name="title" value="${s.subject_title}">
                                            <span id="title_error" class="text-danger"></span>
                                        </div>
                                    </div>
                                    <div class="form-group col-6">
                                        <label class="col-form-label">Owner</label>
                                        <div>
                                            <select name="userId" class="form-control">
                                                <c:forEach var="u" items="${users}">
                                                    <option value="${u.user_id}" <c:if test="${u.user_id == s.owner.user_id}">selected</c:if>>${u.userName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group col-3">
<!--                                        <label class="col-form-label">Is Flag</label>
                                        <div class="d-flex align-items-center">
                                            <div class="form-check me-3">
                                                <input class="form-check-input" type="radio" name="flag" value="0" <c:if test="${s.featured_flag == 0}">checked</c:if>>
                                                    <label class="form-check-label">No</label>
                                                </div>
                                                <div class="form-check" style="margin-left: 10px">
                                                    <input class="form-check-input" type="radio" name="flag" value="1" <c:if test="${s.featured_flag == 1}">checked</c:if>>
                                                    <label class="form-check-label">Yes</label>
                                                </div>
                                                <span id="flag_error" class="text-danger ms-3"></span>
                                            </div>
                                        </div>-->
                                        <div class="form-group col-3">
                                            <label class="col-form-label">Status</label>
                                            <div class="d-flex align-items-center">
                                                <div class="form-check me-3">
                                                    <input class="form-check-input" type="radio" name="status" value="0" <c:if test="${s.status == 0}">checked</c:if>>
                                                    <label class="form-check-label">UnPublish</label>
                                                </div>
                                                <div class="form-check" style="margin-left: 10px">
                                                    <input class="form-check-input" type="radio" name="status" value="1" <c:if test="${s.status == 1}">checked</c:if>>
                                                    <label class="form-check-label">Publish</label>
                                                </div>
                                                <span id="status_error" class="text-danger ms-3"></span>
                                            </div>
                                        </div>
                                        <div class="form-group col-12">
                                            <label class="col-form-label">Subject content</label>
                                            <div>
                                                <textarea name="content" class="form-control">${s.subject_content}</textarea>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <button type="submit" class="btn btn-success">Save changes</button>
                                        <button type="button" onclick="location.href = 'subject-list'" class="btn btn-danger">Back</button>
                                    </div>
                                </div>
                            </form>
                        </c:if>
                        <c:if test="${account.role.role_id == 2}" >
                            <div class="row">
                                <div class="form-group col-6">
                                    <label class="col-form-label">Major</label>
                                    <div>
                                        <select disabled="" name="major_id" class="form-control">
                                            <c:forEach var="major" items="${listM}">
                                                <option value="${major.major_id}" <c:if test="${major.major_id == s.major_id}">selected</c:if>>${major.major_name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-6">
                                    <label class="col-form-label">Subject Name</label>
                                    <div>
                                        <input readonly="" class="form-control" name="subject_name" type="text" value="${s.subject_name}">
                                        <input class="form-control" name="id" type="hidden" value="${s.subject_id}">
                                        <input class="form-control" name="action" type="hidden" value="edit">
                                        <span id="subject_name_error" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="form-group col-6">
                                    <label class="col-form-label">Image</label>
                                    <div>
                                        <input  disabled=""class="form-control" name="image" type="file">
                                        <span id="image_error" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="form-group col-6">
                                    <label class="col-form-label">Current Image</label>
                                    <div>
                                        <img src="${pageContext.request.contextPath}/${s.subject_img}" alt="Subject Image" width="100">
                                    </div>
                                </div>
                                <div class="form-group col-6">
                                    <label class="col-form-label">Title</label>
                                    <div>
                                        <input class="form-control" readonly="" type="text" name="title" value="${s.subject_title}">
                                        <span id="title_error" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="form-group col-6">
                                    <label class="col-form-label">Owner</label>
                                    <div>
                                        <select disabled=""name="userId" class="form-control">
                                            <c:forEach var="u" items="${users}">
                                                <option value="${u.user_id}" <c:if test="${u.user_id == s.owner.user_id}">selected</c:if>>${u.userName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-3">
<!--                                    <label class="col-form-label">Is Flag</label>
                                    <div class="d-flex align-items-center">
                                        <div class="form-check me-3">
                                            <input class="form-check-input" disabled="" type="radio" name="flag" value="0" <c:if test="${s.featured_flag == 0}">checked</c:if>>
                                                <label class="form-check-label">No</label>
                                            </div>
                                            <div class="form-check" style="margin-left: 10px">
                                                <input class="form-check-input" disabled="" type="radio" name="flag" value="1" <c:if test="${s.featured_flag == 1}">checked</c:if>>
                                                <label class="form-check-label">Yes</label>
                                            </div>
                                            <span id="flag_error" class="text-danger ms-3"></span>
                                        </div>
                                    </div>-->
                                    <div class="form-group col-3">
                                        <label class="col-form-label">Status</label>
                                        <div class="d-flex align-items-center">
                                            <div class="form-check me-3">
                                                <input class="form-check-input" disabled="" type="radio" name="status" value="0" <c:if test="${s.status == 0}">checked</c:if>>
                                                <label class="form-check-label">UnPublish</label>
                                            </div>
                                            <div class="form-check" style="margin-left: 10px">
                                                <input class="form-check-input" disabled="" type="radio" name="status" value="1" <c:if test="${s.status == 1}">checked</c:if>>
                                                <label class="form-check-label">Publish</label>
                                            </div>
                                            <span id="status_error" class="text-danger ms-3"></span>
                                        </div>
                                    </div>
                                    <div class="form-group col-12">
                                        <label class="col-form-label">Subject content</label>
                                        <div>
                                            <textarea readonly=""name="content" class="form-control">${s.subject_content}</textarea>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <button type="button" onclick="location.href = 'subject-list'" class="btn btn-danger">Back</button>
                                </div>
                            </div>
                        </c:if>
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
                <h5 class="modal-title" id="addLabel">Add Lesson to ${s.subject_name}</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form   action="${pageContext.request.contextPath}/admin/subject-detail" method="post">
                <input type="hidden" name="subjectId" value="${param.subjectId}">
                <input type="hidden" name="action" value="add">
                <div class="modal-body">
                    <select id="lessonSelect" multiple name="lessonIds[]"> <!-- Use array notation to handle multiple selections -->
                        <option></option>
                        <c:forEach items="${listL}" var="l">
                            <option value="${l.lesson_id}">${l.lesson_name}</option>
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

        // Validate Title
        var title = document.getElementsByName('title')[0].value;
        var titlePattern = /^[a-zA-Z0-9 ]{1,50}$/;
        if (!titlePattern.test(title)) {
            document.getElementById('title_error').innerText = 'Title must be 1-50 characters long and contain only letters, numbers, and spaces.';
            isValid = false;
        }

        // Validate Image URL


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
