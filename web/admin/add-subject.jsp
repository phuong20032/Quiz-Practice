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
                <h4 class="breadcrumb-title">Add Subject</h4>
                <ul class="db-breadcrumb-list">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fa fa-home"></i>Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/subject-list">List Subject</a></li>
                    <li>Add Subject</li>
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
                        <h4>Add subject</h4>
                    </div>
                    <div class="widget-inner">

                        <!-- Form 1: Edit Subject Details -->
                        <form class="edit-profile m-b30" action="${pageContext.request.contextPath}/admin/add-subject" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                            <div class="row">
                                <div class="form-group col-6">
                                    <label class="col-form-label">Major</label>
                                    <div>
                                        <select name="major_id" class="form-control">
                                            <c:forEach var="major" items="${major}">
                                                <option value="${major.major_id}">${major.major_name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-6">
                                    <label class="col-form-label">Assign to</label>
                                    <div>
                                        <select name="userId" class="form-control">
                                            <c:forEach var="u" items="${users}">
                                                <option value="${u.user_id}">${u.userName}</option>
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
                                    <label class="col-form-label">Title</label>
                                    <div>
                                        <input class="form-control" type="text" name="title" value="${s.subject_title}">
                                        <span id="title_error" class="text-danger"></span>
                                    </div>
                                </div>
<!--                                <div class="form-group col-3">
                                    <label class="col-form-label">Is Flag</label>
                                    <div class="d-flex align-items-center">
                                        <div class="form-check me-3">
                                            <input class="form-check-input" checked="" type="radio" name="flag" value="0">
                                            <label class="form-check-label">No</label>
                                        </div>
                                        <div class="form-check" style="margin-left: 10px">
                                            <input class="form-check-input" type="radio" name="flag" value="1">
                                            <label class="form-check-label">Yes</label>
                                        </div>
                                        <span id="title_error" class="text-danger ms-3"></span>
                                    </div>
                                </div>-->
                                <div class="form-group col-3">
                                    <label class="col-form-label">Status</label>
                                    <div class="d-flex align-items-center">
                                        <div class="form-check me-3">
                                            <input class="form-check-input" type="radio" name="status" value="0">
                                            <label class="form-check-label">UnPublish</label>
                                        </div>
                                        <div class="form-check" style="margin-left: 10px">
                                            <input class="form-check-input" checked="" type="radio" name="status" value="1">
                                            <label class="form-check-label">Publish</label>
                                        </div>
                                        <span id="title_error" class="text-danger ms-3"></span>
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

        // Validate Image
        var imageInput = document.getElementsByName('image')[0];
        var imagePath = imageInput.value;
        var allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i;
        if (!allowedExtensions.exec(imagePath)) {
            document.getElementById('image_error').innerText = 'Please upload a valid image file (jpg, jpeg, png, gif).';
            isValid = false;
        }

        return isValid;
    }

    $(document).ready(function () {
        $('#lessonSelect').select2({
            placeholder: 'Select lessons', // Placeholder text
            allowClear: true // Allow clearing selection
        });
    });
</script>
