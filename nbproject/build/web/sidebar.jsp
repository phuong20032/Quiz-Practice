<!-- sidebar.jsp -->
<div class="sidebar">
    <ul class="sidebar-menu">
        <li><a href="dashboard">Dashboard</a></li>
        <li><a href="courses">Subjects</a></li>
        <li><a href="students">Students</a></li>
        <li><a href="teachers">Teachers</a></li>
        <li><a href="settings">Settings</a></li>
    </ul>
</div>

<style>
.sidebar {
    width: 250px;
    position: fixed;
    top: 0;
    left: 0;
    height: 100%;
    background-color: #343a40;
    padding-top: 20px;
}

.sidebar-menu {
    list-style-type: none;
    padding: 0;
}

.sidebar-menu li {
    padding: 10px;
    text-align: center;
}

.sidebar-menu li a {
    color: white;
    display: block;
    text-decoration: none;
}

.sidebar-menu li a:hover {
    background-color: #495057;
}
</style>
