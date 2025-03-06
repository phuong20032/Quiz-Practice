<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="./gui/header.jsp"></jsp:include>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>

    <main class="ttr-wrapper">
        <div class="container-fluid">
            <!-- Breadcrumb, notification and other sections -->
            <div class="db-breadcrumb">
                <h4 class="breadcrumb-title">User Manage</h4>
                <ul class="db-breadcrumb-list">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fa fa-home"></i>Home</a></li>
                <li>User list</li>
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
        <form action="user-list" method="get">
            <div class="row">
                <div class="col-md-3">
                    <div class="form-group">
                        <div class="input-group" style="width: 80%">
                            <input type="text" class="form-control" name="search" placeholder="Enter name to search" value="${param.search}">
                        </div>
                    </div>
                </div>
                <div class="feature-filters clearfix center m-b40 col-md-4" style="text-align: right; margin-top: 9px">
                    <ul class="filters">
                        <li class="btn ${param.status == null || param.status == '' ? 'active' : ''}">
                            <a href="user-list?search=${param.search}&status=&role=${param.role}&page=1"><span>All</span></a>
                        </li>
                        <li class="btn ${param.status == '1' ? 'active' : ''}">
                            <a href="user-list?search=${param.search}&status=1&role=${param.role}&page=1"><span>Blocked</span></a>
                        </li>
                        <li class="btn ${param.status == '0' ? 'active' : ''}">
                            <a href="user-list?search=${param.search}&status=0&role=${param.role}&page=1"><span>Active</span></a>
                        </li>
                    </ul>
                </div>
                <div class="clearfix center m-b40 col-md-3" style="width: 120px">
                    <select class="form-control" id="roleSelect" name="role" onchange="location.href = '?search=${param.search}&status=${param.status}&role=' + this.value + '&page=1'">
                        <option value="">Choose role</option>
                        <option value="1" ${param.role == 1 ? 'selected' : ''}>Student</option>
                        <option value="2" ${param.role == 2 ? 'selected' : ''}>Teacher</option> 
                        <option value="3" ${param.role == 3 ? 'selected' : ''}>Manager</option>
                    </select>
                </div>
                <div class="clearfix center m-b40 col-md-2" style="width: 120px">
                    <select class="form-control" id="roleSelect" name="gender" onchange="location.href = '?search=${param.search}&status=${param.status}&role=${param.status}&gender=' + this.value + '&page=1'">
                        <option value="">All gender</option>
                        <option value="1" ${param.gender == 1 ? 'selected' : ''}>Male</option>
                        <option value="0" ${param.gender == 0 ? 'selected' : ''}>Female</option>
                    </select>
                </div>
            </div>

            <input type="hidden" name="status" value="${param.status}">
            <input type="hidden" name="role" value="${param.role}">
            <input type="hidden" name="gender" value="${param.gender}">
            <input type="hidden" name="page" value="1">
        </form>
        <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#add">Add user</button>

        <!-- user list Table -->
        <div class="row">
            <div class="col-12">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Full name</th>
                            <th>Gender</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="s" items="${user}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${s.fullName}</td>
                                <td>
                                    <c:if test="${s.gender == 1}">
                                        Male
                                    </c:if>
                                    <c:if test="${s.gender == 0}">
                                        Female
                                    </c:if>
                                </td>
                                <td>${s.email}</td>
                                <td>${s.phone}</td>
                                <td>${s.role.role_name}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${s.status == 1}"> <span style="color: red">Blocked</span></c:when>
                                        <c:otherwise><span style="color: green">Active</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="display: flex; gap: 5px"> 
                                    <form action="user-list" method="POST" onsubmit="return confirmAction('${s.status}')">
                                        <input type="hidden" name="id" value="${s.user_id}"> 
                                        <input type="hidden" name="action" value="change-status"> 
                                        <input type="hidden" name="status" value="${s.status}"> 
                                        <c:if test="${s.status == 0}">
                                            <button type="submit" class="btn btn-danger btn-sm">Block</button>
                                        </c:if>
                                        <c:if test="${s.status == 1}">
                                            <button type="submit" class="btn btn-danger btn-sm">Un-block</button>
                                        </c:if>
                                    </form>
                                        <a type="button" href="${pageContext.request.contextPath}/admin/user-detail?id=${s.user_id}" class="btn btn-info btn-sm">Detail</a>
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
                        <a class="btn btn-primary" href="?search=${param.search}&status=${param.status}&role=${param.role}&page=${currentPage - 1}">Previous</a>
                    </li>
                </c:if>
                <c:forEach var="pageNum" begin="1" end="${totalPages}">
                    <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                        <a class="btn btn-primary" href="?search=${param.search}&status=${param.status}&role=${param.role}&page=${pageNum}">${pageNum}</a>
                    </li>
                </c:forEach>
                <c:if test="${currentPage < totalPages}">
                    <li class="page-item">
                        <a class="btn btn-primary" href="?search=${param.search}&status=${param.status}&role=${param.role}&page=${currentPage + 1}">Next</a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>
</main>

<!-- Modal for adding new role -->
<div class="modal fade" style="margin-top: 100px" id="add" tabindex="-1" aria-labelledby="add" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="add">Add new User</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="addUserForm" action="${pageContext.request.contextPath}/admin/user-list" method="post" onsubmit="return validateForm()">
                    <div class="form-group">
                        <label for="full_name">Full name</label>
                        <input class="form-control" id="full_name" name="full_name" type="text" placeholder="Enter full name">
                        <span id="full_name_error" class="text-danger"></span>
                        <hr>
                        <label for="email">Email</label>
                        <input class="form-control" id="email" name="email" type="email" placeholder="Enter email">
                        <span id="email_error" class="text-danger"></span>
                        <hr>
                        <label for="phone">Phone</label>
                        <input class="form-control" id="phone" name="phone" type="text" placeholder="Enter phone number">
                        <span id="phone_error" class="text-danger"></span>
                        <hr>
                        <label for="role">Role</label>
                        <select class="form-control" id="role" name="role">
                            <option value="" disabled="" selected="">Choose role</option>
                            <c:forEach items="${roles}" var="r">
                                <option value="${r.role_id}">${r.role_name}</option>
                            </c:forEach>
                        </select>
                        <span id="role_error" class="text-danger"></span>
                        <hr>
                        <select class="form-control" id="gender" name="gender">
                            <option value="1">Male</option>
                            <option value="0">Female</option>
                        </select>
                        <span id="gender_error" class="text-danger"></span>
                        <hr>
                    </div>
                    <input type="hidden" value="add" name="action">
                    <button style="float: right" type="submit" class="btn btn-primary">Add</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function confirmAction(status) {
        if (status == 0) {
            return confirm("Are you sure you want to block this user?");
        } else if (status == 1) {
            return confirm("Are you sure you want to unblock this user?");
        }
    }

    function validateForm() {
        var isValid = true;

        var fullName = document.getElementById("full_name").value;
        var email = document.getElementById("email").value;
        var phone = document.getElementById("phone").value;
        var role = document.getElementById("role").value;
        var gender = document.getElementById("gender").value;

        // Full Name validation
        var fullNamePattern = /^[a-zA-Z0-9 ]+$/;
        if (fullName === "") {
            document.getElementById("full_name_error").innerText = "Full name is required.";
            isValid = false;
        } else if (!fullNamePattern.test(fullName)) {
            document.getElementById("full_name_error").innerText = "Full name can only contain letters, digits, and spaces.";
            isValid = false;
        } else {
            document.getElementById("full_name_error").innerText = "";
        }

        // Email validation
        var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (email === "") {
            document.getElementById("email_error").innerText = "Email is required.";
            isValid = false;
        } else if (!emailPattern.test(email)) {
            document.getElementById("email_error").innerText = "Invalid email format.";
            isValid = false;
        } else {
            document.getElementById("email_error").innerText = "";
        }

        // Phone number validation
        var phonePattern = /^0\d{9}$/;
        if (phone === "") {
            document.getElementById("phone_error").innerText = "Phone number is required.";
            isValid = false;
        } else if (!phonePattern.test(phone)) {
            document.getElementById("phone_error").innerText = "Phone number must be 10 digits long and start with 0.";
            isValid = false;
        } else {
            document.getElementById("phone_error").innerText = "";
        }

        // Role validation
        if (role === "") {
            document.getElementById("role_error").innerText = "Role is required.";
            isValid = false;
        } else {
            document.getElementById("role_error").innerText = "";
        }

        // Gender validation
        if (gender === "") {
            document.getElementById("gender_error").innerText = "Gender is required.";
            isValid = false;
        } else {
            document.getElementById("gender_error").innerText = "";
        }

        return isValid;
    }

</script>

<jsp:include page="./gui/footer.jsp"></jsp:include>
