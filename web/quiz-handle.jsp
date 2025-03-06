<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">

    <head>

        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="" />
        <meta name="author" content="" />
        <meta name="robots" content="" />

        <!-- DESCRIPTION -->
        <meta name="description" content="EduChamp : Education HTML Template" />

        <!-- OG -->
        <meta property="og:title" content="EduChamp : Education HTML Template" />
        <meta property="og:description" content="EduChamp : Education HTML Template" />
        <meta property="og:image" content="" />
        <meta name="format-detection" content="telephone=no">

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>EduChamp : Education HTML Template </title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--[if lt IE 9]>
        <script src="assets/js/html5shiv.min.js"></script>
        <script src="assets/js/respond.min.js"></script>
        <![endif]-->

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">

        <!-- Custom CSS for modal -->
        <style>
            /* The Modal (background) */
            .modal {
                display: none;
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgb(0,0,0);
                background-color: rgba(0,0,0,0.4);
                padding-top: 60px;
            }

            /* Modal Content */
            .modal-content {
                background-color: #fefefe;
                margin: 5% auto;
                padding: 20px;
                border: 1px solid #888;
                width: 80%;
                max-width: 500px;
            }

            /* The Close Button */
            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }
        </style>

    </head>

    <body id="bg">
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>
            <!-- Header Top ==== -->
            <header class="header rs-nav">
                <div class="top-bar">
                    <div class="container">
                        <div class="row d-flex justify-content-between">
                            <div class="topbar-left">
                            </div>
                            <div class="topbar-right">
                                <ul>
                                    <!-- Check if user don't login, page will show login and register -->
                                    <c:if test="${sessionScope.account == null}">
                                        <li><a href="login">Login</a></li>
                                        <li><a href="register">Register</a></li>
                                        </c:if>

                                    <!-- If user have login, show profile link and logout. -->
                                    <c:if test="${sessionScope.account != null}">
                                        <li><a href="profile">${sessionScope.account.getUserName()}</a></li>
                                        <li><a href="logout">Logout</a></li>
                                        </c:if>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="sticky-header navbar-expand-lg">
                    <div class="menu-bar clearfix">
                        <div class="container clearfix">
                            <!-- Header Logo ==== -->
                            <div class="menu-logo">
                                <a href="home" onclick="location.reload();"><img src="assets/images/logo.png" alt=""></a>
                            </div>
                            <!-- Mobile Nav Button ==== -->
                            <button class="navbar-toggler collapsed menuicon justify-content-end" type="button" data-toggle="collapse" data-target="#menuDropdown" aria-controls="menuDropdown" aria-expanded="false" aria-label="Toggle navigation">
                                <span></span>
                                <span></span>
                                <span></span>
                            </button>
                            <div class="menu-links navbar-collapse collapse justify-content-start" id="menuDropdown">
                                <div class="menu-logo">
                                    <a href="home"><img src="assets/images/logo.png" alt=""></a>
                                </div>
                                <ul class="nav navbar-nav">
                                    <li class="active"><a href="home" onclick="location.reload();">Home <i class="text"></i></a>
                                    </li>
                                    <li class="nav-dashboard"><a href="profile">Profile</a>
                                    </li>
                                    <li class="add-mega-menu"><a href="subjectlist">Subject</a>
                                    </li>

                                </ul>
                                <div class="nav-social-link">
                                    <a href="javascript:;"><i class="fa fa-facebook"></i></a>
                                    <a href="javascript:;"><i class="fa fa-google-plus"></i></a>
                                    <a href="javascript:;"><i class="fa fa-linkedin"></i></a>
                                </div>
                            </div>
                            <!-- Navigation Menu END ==== -->
                        </div>
                    </div>
                </div>
            </header>
            <!-- Header Top END ==== -->
            <!-- Content -->
            <div class="page-content bg-white">
                <!-- inner page banner -->
                <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner2.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Quiz Handle</h1>
                        </div>
                    </div>
                </div>
                <div class="content-block">
                    <!-- About Us -->
                    <div class="section-area section-sp1">
                        <div class="container">
                            <div class="row d-flex flex-row-reverse">
                                <div class="col-lg-12 col-md-8 col-sm-12">
                                    <div class="courses-post">
                                        <div class="ttr-post-info">
                                            <div class="ttr-post-title ">
                                                <h2 class="post-title">${quiz.quiz_name}</h2>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="container">
                                        <div id="timer">
                                            Time left: <span id="time">${sessionScope.remainingTime}</span> seconds
                                        </div>
                                        <form id="multipleChoiceForm" method="post" action="quiz-handle">
                                            <input type="hidden" name="quiz_id" value="${quiz.quiz_id}" />
                                            <c:forEach items="${questions}" var="q" varStatus="status">
                                                <h4>Question ${status.index + 1}: ${q.question_name}</h4>
                                                <c:forEach items="${q.answers}" var="a">
                                                    <div>
                                                        <input type="radio" name="answer${status.index}" id="${a.answer_id}" value="${a.answer_id}">
                                                        <label for="${a.answer_id}">${a.answer_content}</label>
                                                    </div>
                                                </c:forEach>
                                            </c:forEach>
                                            <button type="button" class="btn" onclick="validateForm()">Submit</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Simple Modal -->
            <div id="warningModal" class="modal">
                <div class="modal-content">
                    <span class="close" onclick="closeModal()">&times;</span>
                    <h5>Incomplete Quiz</h5>
                    <p>Some questions are not answered. Are you sure you want to submit?</p>

                    <button type="button" class="btn btn-primary" onclick="submitForm()">Submit Anyway</button>
                </div>
            </div>

            <!-- Content END-->
            <!-- Footer ==== -->
            <jsp:include page="/gui/footer.jsp"></jsp:include>
                 
                <script>
                    var formSubmitting = false;
                    var setFormSubmitting = function () {
                        formSubmitting = true;
                    };

                    function startTimer(duration, display) {
                        var timer = duration,
                                minutes, seconds;
                        const form = document.getElementById('multipleChoiceForm');

                        setInterval(function () {
                            minutes = parseInt(timer / 60, 10);
                            seconds = parseInt(timer % 60, 10);

                            minutes = minutes < 10 ? "0" + minutes : minutes;
                            seconds = seconds < 10 ? "0" + seconds : seconds;

                            display.textContent = minutes + ":" + seconds;

                            if (--timer < 0) {
                                clearInterval(duration);
                                setFormSubmitting();
                                form.submit(); // Automatically submit the form
                            }
                        }, 1000);
                    }

                    window.onload = function () {
                        var quizDuration = 60 * ${quiz.count_down},
                                display = document.querySelector('#time');
                        startTimer(quizDuration, display);

                        window.addEventListener('beforeunload', function (e) {
                            if (!formSubmitting) {
                                submitFormViaAjax();
                                var confirmationMessage = 'If you leave this page, the quiz will be automatically submitted.';
                                (e || window.event).returnValue = confirmationMessage; // Gecko + IE
                                return confirmationMessage; // Gecko + Webkit, Safari, Chrome etc.
                            }
                        });

                        document.getElementById('multipleChoiceForm').onsubmit = setFormSubmitting;
                    };

                    function validateForm() {
                        const form = document.getElementById('multipleChoiceForm');
                        const questions = ${questions.size()};
                        let someUnanswered = false;

                        for (let i = 0; i < questions; i++) {
                            const radios = document.getElementsByName('answer' + i);
                            let answered = false;
                            for (let j = 0; j < radios.length; j++) {
                                if (radios[j].checked) {
                                    answered = true;
                                    break;
                                }
                            }
                            if (!answered) {
                                someUnanswered = true;
                                break;
                            }
                        }

                        if (someUnanswered) {
                            document.getElementById('warningModal').style.display = "block";
                        } else {
                            setFormSubmitting();
                            form.submit();
                        }
                    }

                    function closeModal() {
                        document.getElementById('warningModal').style.display = "none";
                    }

                    function submitForm() {
                        const form = document.getElementById('multipleChoiceForm');
                        setFormSubmitting();
                        form.submit();
                    }

                    function submitFormViaAjax() {
                        const form = document.getElementById('multipleChoiceForm');
                        const formData = $(form).serialize();

                        $.ajax({
                            type: 'POST',
                            url: form.action,
                            data: formData,
                            success: function (response) {
                                setFormSubmitting();
                            },
                            error: function (error) {
                                console.error('Form submission failed:', error);
                            }
                        });
                    }

                    const pageAccessedByReload = (
                            (window.performance.navigation && window.performance.navigation.type === 1) ||
                            window.performance
                            .getEntriesByType('navigation')
                            .map((nav) => nav.type)
                            .includes('reload')
                            );

                    if (pageAccessedByReload === true) {
                        submitForm();
                    }
            </script>

        </div>
    </body>

</html>
