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
                <h4 class="breadcrumb-title">User Detail</h4>
                <ul class="db-breadcrumb-list">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fa fa-home"></i>Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/user-list">User List</a></li>
                    <li>User Detail</li>
                </ul>
            </div>
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
                        <h4>User Detail</h4>
                    </div>
                    <div class="widget-inner">

                        <!-- Form 1: Edit Subject Details -->
                        <form action="${pageContext.request.contextPath}/admin/user-detail" method="POST">
                        <div class="row">
                            <div class="form-group col-6">
                                <label class="col-form-label">Username</label>
                                <div>
                                    <input readonly="" class="form-control" type="text" value="${user.userName}">
                                    <input readonly="" class="form-control" name="id" type="hidden" value="${user.user_id}">
                                </div>
                            </div>
                            <div class="form-group col-6">
                                <label class="col-form-label">Email</label>
                                <div>
                                    <input readonly="" class="form-control" type="text" value="${user.email}">
                                </div>
                            </div>
                            <div class="form-group col-4">
                                <label class="col-form-label">Phone</label>
                                <div>
                                    <input readonly="" class="form-control" type="text" value="${user.phone}">
                                </div>
                            </div>
                            <div class="form-group col-4">
                                <label class="col-form-label">Full name</label>
                                <div>
                                    <input readonly="" class="form-control" type="text" value="${user.fullName}">
                                </div>
                            </div>
                            <div class="form-group col-4">
                                <label class="col-form-label">School</label>
                                <div>
                                    <input readonly="" class="form-control" type="text" value="${user.school}">
                                </div>
                            </div>
                            <div class="form-group col-4">
                                <label class="col-form-label">Role</label>
                                <div>
                                    <select class="form-control" id="role" name="role">
                                        <option value="" disabled="">Choose role</option>
                                        <c:forEach items="${roles}" var="r">
                                            <option value="${r.role_id}" ${user.role.role_id == r.role_id ? 'selected' : ''}>${r.role_name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group col-4">
                                <label class="col-form-label">Status</label>
                                <div>
                                    <select class="form-control" id="status" name="status">
                                        <option value="1" ${user.status == 1 ? 'selected' : ''}>Blocked</option>
                                        <option value="0" ${user.status == 0? 'selected' : ''}>Active</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group col-4">
                                <label class="col-form-label">Gender</label>
                                <div>
                                    <select disabled="" class="form-control" id="gender" name="genders">
                                        <option value="1" ${user.gender == 1 ? 'selected' : ''}>Male</option>
                                        <option value="0" ${user.gender == 0? 'selected' : ''}>Female</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group col-12">
                                <label class="col-form-label">Description</label>
                                <div>
                                    <textarea readonly="" class="form-control" type="text" >${user.description}</textarea>
                                </div>
                            </div>

                            <div class="col-1">
                                <button type="button" onclick="location.href = 'user-list'" class="btn btn-danger">Back</button>
                            </div>
                            <div class="col-11">
                                <button type="submit" class="btn btn-danger">Save change</button>
                            </div>
                        </div>
                       </form>
                    </div>
                </div>
            </div>         
        </div>
    </div>
</main>

<jsp:include page="./gui/footer.jsp"></jsp:include>
