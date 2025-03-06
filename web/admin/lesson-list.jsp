<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="./gui/header.jsp"></jsp:include>


<main class="ttr-wrapper">
    <div class="container-fluid">
        <!-- Breadcrumb, notification and other sections -->
        <div class="db-breadcrumb">
            <h4 class="breadcrumb-title">List Lesson</h4>
            <ul class="db-breadcrumb-list">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fa fa-home"></i>Home</a></li>
                <c:if test="${not empty param.subject}">
                    <li><a href="${pageContext.request.contextPath}/admin/subject-list">${subject.subject_name}</a></li>
                </c:if>
                <li> List Lesson </li>
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
            <div class="alert alert-danger alert-dismissible fade show" role="alert" style="text-align: center">
                ${sessionScope.notificationErr}
                <button type="button" class="btn-danger" data-dismiss="alert">X</button>
            </div>
            <%
                session.removeAttribute("notificationErr");
            %>
        </c:if>

        <!-- Form and Filter Section -->
        <form action="lesson-list" method="get">
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
                            <a href="lesson-list?search=${param.search}&status=&subject=${param.subject}&page=1"><span>All</span></a>
                        </li>
                        <li class="btn ${param.status == '1' ? 'active' : ''}">
                            <a href="lesson-list?search=${param.search}&status=1&subject=${param.subject}&page=1"><span>Published</span></a>
                        </li>
                        <li class="btn ${param.status == '0' ? 'active' : ''}">
                            <a href="lesson-list?search=${param.search}&status=0&subject=${param.subject}&page=1"><span>Un-publish</span></a>
                        </li>
                    </ul>
                </div>
                <div class="clearfix center m-b40 col-md-2" style="width: 120px">
                    <select class="form-control" id="subjectSelect" name="subject" onchange="location.href = '?search=${param.search}&status=${param.status}&subject=' + this.value + '&page=1'">
                        <option value="">Choose Subject</option>
                        <c:forEach items="${listS}" var="m">
                            <option value="${m.subject_id}" ${param.subject == m.subject_id ? 'selected' : ''}>${m.subject_name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <input type="hidden" name="status" value="${param.status}">
            <input type="hidden" name="subject" value="${param.subject}">
            <input type="hidden" name="page" value="1">
        </form>
        <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#add">Add lesson</button>

        <!-- Lesson List Table -->
        <div class="row">
            <div class="col-12">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Subject</th>
                            <th>Creator</th>
                            <th>Total quiz</th>
                            <th>Create at</th>
                            <th>Update at</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="s" items="${lesson}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${s.lesson_name}</td>
                                <td>${s.description}</td>
                                <c:if test="${s.subject_name != null}">
                                    <td>${s.subject_name}</td>
                                </c:if>
                                <c:if test="${s.subject_name == null}">
                                    <td style="color: red">No subject</td>
                                </c:if>
                                <td>${s.creator.userName}</td>
                                <td>
                                    ${s.quiz_count} <a href="quiz-list?lesson=${s.lesson_id}"><i class="ti-eye"></i></a>
                                </td>
                                <td>${s.createAt}</td>
                                <td>${s.updaetAt}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${s.status == 1}"> <span style="color: green">Published</span></c:when>
                                        <c:otherwise><span style="color: red">Un-publish</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="display: inline-flex; gap: 5px;">
                                    <form id="statusForm_${s.lesson_id}" action="lesson-list" method="post">
                                        <input type="hidden" name="lesson_id" value="${s.lesson_id}">
                                        <input type="hidden" name="action" value="change-status">
                                        <input type="hidden" name="status" value="${s.status}">
                                        <button class="btn-${s.status == 1 ? 'danger' : 'success'}" type="submit" onclick="return confirmStatusChange(${s.lesson_id}, ${s.status})">${s.status == 1 ? 'Unpublish' : 'Publish'}</button>
                                    </form>
                                    <a type="button" href="lesson-detail?id=${s.lesson_id}" class="btn-info">Details</a>
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
                    <h5 class="modal-title" id="add">Add new lesson</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/admin/lesson-list"" method="post" onsubmit="return validateForm()">
                        <div class="form-group">
                            <label for="lesson_name">Lesson Name</label>
                            <input class="form-control" id="lesson_name" name="lesson_name" type="text" placeholder="Enter lesson name">
                            <span id="lesson_name_error" class="text-danger"></span>
                            <label for="description">Description</label>
                            <textarea class="form-control" id="description" name="description" placeholder="Enter lesson description"></textarea>
                            <span id="description_error" class="text-danger"></span>
                            <input type="hidden" name="action" value="add">
                        </div>
                        <button style="float: right" type="submit" class="btn btn-primary">Add</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Custom Scripts -->
    <script>
        function validateForm() {
            var isValid = true;

            var lessonName = document.getElementById('lesson_name').value;
            var lessonNamePattern = /^[a-zA-Z0-9\s]{1,20}$/;
            if (!lessonNamePattern.test(lessonName)) {
                document.getElementById('lesson_name_error').innerText = 'Lesson Name must be 1-20 characters long and contain only letters, numbers, and spaces.';
                isValid = false;
            } else {
                document.getElementById('lesson_name_error').innerText = '';
            }

            var description = document.getElementById('description').value;
            if (description.trim() === '') {
                document.getElementById('description_error').innerText = 'Description must not be empty.';
                isValid = false;
            } else {
                document.getElementById('description_error').innerText = '';
            }

            console.log('Validation Result:', isValid);
            return isValid;
        }

        $(document).ready(function () {
            $('#subjectSelect').select2({
                placeholder: 'Choose Subject',
                allowClear: true
            });
        });
    </script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<jsp:include page="./gui/footer.jsp"></jsp:include>