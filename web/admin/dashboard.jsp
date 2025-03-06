<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="./gui/header.jsp"></jsp:include>

    <!-- Include DataTables CSS and JS -->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <!-- Include Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <main class="ttr-wrapper">
        <div class="container-fluid">
            <div class="db-breadcrumb">
                <h4 class="breadcrumb-title">Dashboard</h4>
                <ul class="db-breadcrumb-list">
                    <li><a href="dashboard"><i class="fa fa-home"></i>Home</a></li>
                    <li>Dashboard</li>
                </ul>
            </div>
            <form action="dashboard" method="get">

                <div class="row">
                    <div class="col-md-3">
                        <label for="startDate">Start Date:</label>
                        <input type="date" id="startDate" class="form-control-sm" name="startDate" value="${selectedStartDate}">
                </div>
                <div class="col-md-3">
                    <label for="endDate">End Date:</label>
                    <input type="date" id="endDate" class="form-control-sm" name="endDate" value="${selectedEndDate}">
                </div>
                <div class="col-md-4"  >
                    <button class="btn btn-sm" onclick="updateDateRange()">Show</button>
                    <p id="error-message" style="color: red; display: none;">Please select both start and end dates.</p>
                </div>
            </div>
        </form>
        <form action="dashboard" method="get" class="row">
            <div class="col-md-6"style="margin-bottom: 10px; margin-top: 10px">
                <label for="dateRange">Date Range:</label>
                <select id="dateRange" name="dateRange" onchange="updateDateRangeFields()">
                    <option value="custom" ${param.dateRange eq 'custom' ? 'selected' : ''}>Custom</option>
                    <option value="1week" ${param.dateRange eq '1week' ? 'selected' : ''}>1 Week Ago to Now</option>
                    <option value="1month" ${param.dateRange eq '1month' ? 'selected' : ''}>1 Month</option>
                    <option value="6months" ${param.dateRange eq '6months' ? 'selected' : ''}>6 Months</option>
                    <option value="1year" ${param.dateRange eq '1year' ? 'selected' : ''}>1 Year</option>
                    <option value="all" ${param.dateRange eq 'all' ? 'selected' : ''}>All</option>
                </select>
            </div>
            <div class="col-md-12" style="margin-bottom: 10px; margin-top: 10px">
                <button class="btn btn-sm" onclick="updateDateRange()">Show</button>
                <p id="error-message" style="color: red; display: none;">Please select both start and end dates.</p>
            </div>
        </form>
    </div>

    <div class="row">
        <div class="col-md-6 col-lg-4 col-xl-4 col-sm-6 col-12">
            <div class="widget-card widget-bg1">
                <div class="wc-item">
                    <h4 class="wc-title">New Subjects</h4>
                    <span class="wc-des">New subjects ${rangeDescription}</span>
                    <span class="wc-stats counter">${newSubjects}</span>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-4 col-xl-4 col-sm-6 col-12">
            <div class="widget-card widget-bg2">
                <div class="wc-item">
                    <h4 class="wc-title">All Subjects</h4>
                    <span class="wc-des">Total subjects</span>
                    <span class="wc-stats counter">${allSubjects}</span>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-4 col-xl-4 col-sm-6 col-12">
            <div class="widget-card widget-bg5">
                <div class="wc-item">
                    <h4 class="wc-title">All Quizzes</h4>
                    <span class="wc-des">Total Quizzes</span>
                    <span class="wc-stats counter">${allQuizzes}</span>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Pie Chart on the Left -->
        <div class="col-lg-4 col-sm-12">
            <h4>Subject Count Distribution</h4>
            <canvas id="subjectPieChart" style="max-width: 500px; max-height: 500px;"></canvas>
        </div>

        <!-- Table on the Right -->
        <div class="col-lg-8 col-sm-12">
            <h4 class="m-b-20">Subject Registration</h4>
            <table id="registrationTable" class="display">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Subject Name</th>
                        <th>User Name</th>
                        <th>Registration Date</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="registration" items="${registrations}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${registration.subject.subject_name}</td>
                            <td>${registration.user.userName}</td>
                            <td>${registration.start_date}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</div>
</main>

<script>
    function updateDateRange() {
        var year = document.getElementById('year').value;
        var week = document.getElementById('week').value;
        var errorMessage = document.getElementById('error-message');

        if (!year || !week) {
            errorMessage.style.display = 'block';
        } else {
            errorMessage.style.display = 'none';
            var url = 'dashboard?year=' + year + '&week=' + week;
            window.location.href = url;
        }
    }

    function updateWeekOptions() {
        var year = document.getElementById('year').value;
        window.location.href = 'dashboard?year=' + year;
    }

// Get data from server-side and convert to JavaScript arrays
    var subjectNames = JSON.parse('<c:out value="${subjectNamesJson}" escapeXml="false" />');
    var subjectCounts = JSON.parse('<c:out value="${subjectCountsJson}" escapeXml="false" />');

// Create radar chart
    var ctx = document.getElementById('subjectPieChart').getContext('2d');
    var subjectRadarChart = new Chart(ctx, {
        type: 'radar', // Changed to 'radar'
        data: {
            labels: subjectNames,
            datasets: [{
                    label: 'Subject Counts',
                    data: subjectCounts,
                    backgroundColor: 'rgba(255, 99, 132, 0.2)',
                    borderColor: 'rgba(255, 99, 132, 1)',
                    borderWidth: 1
                }]
        },
        options: {
            responsive: true,
            scales: {
                r: {
                    beginAtZero: true // Ensure the radial scale starts at zero
                }
            }
        }
    });

    var categorySubjectRegistrations = JSON.parse('<c:out value="${categorySubjectRegistrationsJson}" escapeXml="false" />');

// Create radar charts for each category
    var chartsContainer = document.getElementById('charts-container');
    for (var category in categorySubjectRegistrations) {
        var chartContainer = document.createElement('div');
        chartContainer.classList.add('col-md-6');
        chartContainer.innerHTML = '<h5>' + category + '</h5><canvas id="chart-' + category + '"></canvas>';
        chartsContainer.appendChild(chartContainer);

        var ctx = document.getElementById('chart-' + category).getContext('2d');
        var data = categorySubjectRegistrations[category];
        var labels = Object.keys(data);
        var counts = Object.values(data);

        new Chart(ctx, {
            type: 'radar', // Changed to 'radar'
            data: {
                labels: labels,
                datasets: [{
                        label: category,
                        data: counts,
                        backgroundColor: 'rgba(54, 162, 235, 0.2)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 1
                    }]
            },
            options: {
                responsive: true,
                scales: {
                    r: {
                        beginAtZero: true // Ensure the radial scale starts at zero
                    }
                }
            }
        });
    }
</script>
<script>
    function updateDateRangeFields() {
        const dateRange = document.getElementById('dateRange').value;
        const startDateField = document.getElementById('startDate');
        const endDateField = document.getElementById('endDate');
        const today = new Date();
        let startDate, endDate;

        switch (dateRange) {
            case '1week':
                startDate = new Date();
                startDate.setDate(today.getDate() - 7);
                endDate = today;
                break;
            case '1month':
                startDate = new Date();
                startDate.setMonth(today.getMonth() - 1);
                endDate = today;
                break;
            case '6months':
                startDate = new Date();
                startDate.setMonth(today.getMonth() - 6);
                endDate = today;
                break;
            case '1year':
                startDate = new Date();
                startDate.setFullYear(today.getFullYear() - 1);
                endDate = today;
                break;
            case 'all':
                startDate = new Date('2000-01-01');
                endDate = new Date('2050-01-01');
                break;
            default:
                startDate = null;
                endDate = null;
        }

        if (startDate && endDate) {
            startDateField.value = startDate.toISOString().split('T')[0];
            endDateField.value = endDate.toISOString().split('T')[0];
        }
    }
</script>
<jsp:include page="./gui/footer.jsp"></jsp:include>
