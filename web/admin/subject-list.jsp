<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="./gui/header.jsp"></jsp:include>
    <main class="ttr-wrapper">
        <div class="container-fluid">
            <div class="db-breadcrumb">
                <h4 class="breadcrumb-title">List Subject</h4>
                <ul class="db-breadcrumb-list">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fa fa-home"></i>Home</a></li>
                    <li>List Subject</li>
                </ul>
            </div>  
        <c:if test="${not empty sessionScope.notification}">
            <div class="alert alert-success alert-dismissible fade show" role="alert" style="text-align: center">
                ${sessionScope.notification}
                <button type="button" class="btn-danger" data-dismiss="alert" aria-label="Close">X</button>
            </div>
            <%
                // Clear the notification after displaying it
                session.removeAttribute("notification");
            %>
        </c:if>
        <c:if test="${not empty sessionScope.notificationErr}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert"  style="text-align: center">
                ${sessionScope.notificationErr}
                <button type="button" class="btn-danger" data-dismiss="alert" >X</button>
            </div>
            <%
                // Clear the notification after displaying it
                session.removeAttribute("notificationErr");
            %>
        </c:if>
        <form action="subject-list" method="get">
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
                            <a href="subject-list?search=${param.search}&status=&major=${param.major}&page=1"><span>All</span></a>
                        </li>
                        <li class="btn ${param.status == '1' ? 'active' : ''}">
                            <a href="subject-list?search=${param.search}&status=1&major=${param.major}&page=1"><span>Published</span></a>
                        </li>
                        <li class="btn ${param.status == '0' ? 'active' : ''}">
                            <a href="subject-list?search=${param.search}&status=0&major=${param.major}&page=1"><span>Un-publish</span></a>
                        </li>
                    </ul>
                </div>
                <div class="clearfix center m-b40 col-md-2" style="width: 120px">
                    <select class="form-control" name="major" onchange="location.href = '?search=${param.search}&status=${param.status}&major=' + this.value + '&page=1'">
                        <option value="">Choose Major</option>
                        <c:forEach items="${listM}" var="m">
                            <option value="${m.major_id}" ${param.major == m.major_id ? 'selected' : ''}>${m.major_name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <input type="hidden" name="status" value="${param.status}">
            <input type="hidden" name="major" value="${param.major}">
            <input type="hidden" name="page" value="1">
        </form>
        <c:if test="${account.role.role_id == 3}" >

            <a type="button" class="btn btn-warning" href="add-subject" hdata-target="#add">
                Add subject
            </a>
        </c:if>
        <div class="row">
            <div class="col-12">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Name</th>
                            <th>Major</th>
                            <th>Image</th>
                            <th>Title</th>
                            <th>Creator</th>
                            <th>Owner</th>
                            <th>Total lesson</th>
                            <th>Status</th>
<!--                            <th>Flag</th>-->
<!--khi nao dung thi uncmt-->
                            <th>Create At</th>
                            <th>Action</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="subject" items="${subjects}" varStatus="status">
                            <tr>

                                <td>${status.index + 1}</td>
                                <td>${subject.subject_name}</td>
                                <td>${subject.major.major_name}</td>
                                <td><img src="../${subject.subject_img}" alt="${subject.subject_name}" width="50"></td>
                                <td>${subject.subject_title}</td>
                                <td>${subject.creator_name}</td>
                                <td>${subject.owner.userName}</td>
                                <td>
                                    ${subject.total_lesson}    <a href="lesson-list?subject=${subject.subject_id}"><i class="ti-eye"></i></a>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${subject.status == 1}"> <span style="color: green">Published</span></c:when>
                                        <c:otherwise><span style="color: red">Un-publish</span></c:otherwise>
                                    </c:choose>
                                </td>
<!--                                <td>
                                    <c:choose>
                                        <c:when test="${subject.featured_flag == 1}"> <span style="color: green">Yes</span></c:when>
                                        <c:otherwise><span style="color: red">No</span></c:otherwise>
                                    </c:choose>
                                </td>-->
                                        <!--khi nao dung thi uncmt-->
                                <td>${subject.created_at}</td>
                                <td style="display: inline-flex; gap: 5px;">
                                    <c:if test="${account.role.role_id == 3}" >

                                        <form id="statusForm_${subject.subject_id}" action="subject-list" method="post">
                                            <input type="hidden" name="subjectId" value="${subject.subject_id}">
                                            <input type="hidden" name="action" value="change-status">
                                            <input type="hidden" name="status" value="${subject.status}">
                                            <button class="btn-${subject.status == 1 ? 'danger' : 'success'}" type="submit" onclick="return confirmStatusChange(${subject.subject_id}, ${subject.status})">${subject.status == 1 ? 'Unpublish' : 'Publish'}</button>
                                        </form>
                                    </c:if>
                                    <a type="button" href="subject-detail?subjectId=${subject.subject_id}"  class="btn-info">Details</a>
                                    
                                </td>

                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="modal fade" style="margin-top: 100px" id="add" tabindex="-1" aria-labelledby="add" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="add">Add new subject</h5>

                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>

                    </div>
                    <div class="modal-body">
                        <form action="${pageContext.request.contextPath}/admin/subject-list" method="post"onsubmit="return validateForm()">
                            <div class="form-group">
                                <label for="fullName">Select Major</label>
                                <select name="major_id" class="form-control">
                                    <c:forEach var="major" items="${listM}">
                                        <option value="${major.major_id}" <c:if test="${major.major_id == s.major_id}">selected</c:if>>${major.major_name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="email">Subject Name</label>
                                <input class="form-control" name="subject_name" type="text" placeholder="Enter subject name">
                                <input type="hidden" name="action" value="add">
                                <span id="subject_name_error" class="text-danger"></span>
                            </div>
                            <div class="form-group">
                                <label class="col-form-label">Image link</label>
                                <div>
                                    <input class="form-control" placeholder="Enter image link" name="image" type="text">
                                    <span id="image_error" class="text-danger"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-form-label">Title</label>
                                <div>
                                    <input class="form-control" type="text" name="title" placeholder="Enter subject title">
                                    <span id="title_error" class="text-danger"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-form-label">Subject content</label>
                                <div>
                                    <textarea name="content" class="form-control"></textarea>
                                </div>
                            </div>

                            <button type="submit" class="btn btn-primary">Register</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <nav class="mt-3" aria-label="Page navigation example">
            <ul class="pagination justify-content-center">
                <c:if test="${currentPage > 1}">
                    <li class="page-item">
                        <a class="btn btn-primary" href="?search=${param.search}&status=${param.status}&major=${param.major}&page=${currentPage - 1}">Previous</a>
                    </li>
                </c:if>

                <c:forEach var="pageNum" begin="1" end="${totalPages}">
                    <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                        <a class="btn btn-primary" href="?search=${param.search}&status=${param.status}&major=${param.major}&page=${pageNum}">${pageNum}</a>
                    </li>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <li class="page-item">
                        <a class="btn btn-primary" href="?search=${param.search}&status=${param.status}&major=${param.major}&page=${currentPage + 1}">Next</a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>
</main>
<script>
    function confirmStatusChange(subjectId, currentStatus) {
        var action;
        console.log(currentStatus);
        if (currentStatus == 1) {
            action = 'unpublish';
        } else {
            action = 'publish';
        }
        return confirm(`Are you sure you want to change status of this subject?`);
    }
</script>
<script>
    function validateForm() {
        var isValid = true;

        // Clear previous error messages
        document.getElementById('subject_name_error').innerText = '';
        document.getElementById('title_error').innerText = '';
        document.getElementById('image_error').innerText = '';

        // Validate Subject Name
        var subjectName = document.getElementsByName('subject_name')[0].value;
        var subjectNamePattern = /^[a-zA-Z0-9]{1,20}$/;
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
        var imageUrl = document.getElementsByName('image')[0].value;
        var urlPattern = /^(http|https):\/\/.+/;
        if (!urlPattern.test(imageUrl)) {
            document.getElementById('image_error').innerText = 'Image URL must start with http or https.';
            isValid = false;
        }

        return isValid;
    }
</script>

<jsp:include page="./gui/footer.jsp"></jsp:include>
