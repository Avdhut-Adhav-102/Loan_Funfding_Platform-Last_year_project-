<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
<%@ page import="Com.educhain.util.DBConnection.*" %>
<%-- <%@page import="Dao.user"%> --%>
<%@page import="java.sql.ResultSet"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/logo.png">
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Block Chain</title>
	<link rel="favicon" href="assets1/images/favicon.png">
	<link rel="stylesheet" media="screen" href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,700">
	<link rel="stylesheet" href="assets1/css/bootstrap.min.css">
	<link rel="stylesheet" href="assets1/css/font-awesome.min.css">
	<link rel="stylesheet" href="assets1/css/bootstrap-theme.css" media="screen">
	<link rel="stylesheet" type="text/css" href="assets1/css/da-slider.css" />
	<link rel="stylesheet" href="assets1/css/style.css">
	<script src="assets1/js/html5shiv.js"></script>
	<script src="assets1/js/respond.min.js"></script>
<style>
table,th,td {
	border: 0px solid black;
	border-collapse: collapse;
}

th,td {
	padding: 10px;
}
tr:nth-child(2n) {
	background-color: #FFEBCD;
}
th {
	padding-left: 13px;
	padding-right: 13px;
}
td {
	padding-top: 2px;
	padding-bottom: 2px;
	padding-left: 3px;
	padding-right: 3px;
	padding: 2px;
	font-size: 15px;
}
.pt-5, .py-5 {
  	padding-top: 1rem !important;
  }
.pb-5, .py-5 {
  	padding-bottom: 0rem !important;
  }
 .container, .container-sm, .container-md, .container-lg, .container-xl {
  max-width: 840px;
}
img {
    max-width: 180%;
}
</style>
</head>
<body>

	<div class="navbar navbar-inverse" style="background-color: black;">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse"><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button>
				<a class="navbar-brand" href="Index.jsp">
				<h4>Block Chain</h4>
				</a>	
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav pull-right mainNav">
					<%-- <jsp:include page="O_menu.jsp"></jsp:include> --%>                                          
                </ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</div>
	<!-- /.navbar -->

	<!-- Header -->
	<header id="headO1">
		<div class="container">
			<div class="banner-content">
				
			</div>
		</div>
	</header>
	
	<div id="courses">
		
	</div>
	<!-- container -->
	<section class="container">
		<div class="heading">
			<!-- Heading -->
			<b><h2>Ongoing Campaigns</h2></b>
		</div>
		<div class="row">
			<!-- <div class="col-md-4">
				<img src="./images/login.jpg" alt="" class="img-responsive">
			</div> -->
			<div class="col-md-8">
				<div >
		<div >
		<div class="panel panel-primary">
		
		<div class="panel-body">
		<!-- <div style="margin-left: 20px;margin-right: 20px"> -->
		 <!--New Design -->		
	<div class="container-fluid py-5">
        <div class="container py-5">
            <div class="row" style="background-color: #15d7b4; border-radius: 25px;">
                <div class="col-lg-5 mb-2 mb-lg-2" style="min-height: 250px;">
                    <div class="position-relative h-70">
                        <%-- <p style="text-align: left;"><%=srno%>.</p> --%>
						<p style="text-align: left;"><h1><b>Help Provide Needs For The Elderly</b></h1></p>
						<p style="text-align: left;"><b> -Build a Permanent Shelter Home for the Homeless</b></p>
                    	<p style="text-align: left;"><b>Raised:- Rs.133/- </b></p>
						<p style="text-align: left;"><b>Goal:- Rs.82/- </b></p>
						<!-- <p style="text-align: left;"><b>College Departments:- </b></p>
						<p style="text-align: left;"><b>Course:- </b></p> -->
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="section-title position-relative mb-4">
                        <p style="text-align: left;"><br><img src="images/img01.png" alt="Girl in a jacket" width="750" height="220"></p>
						<p style="text-align: left;"><b>College WebSite:- </b><a href="Payment.jsp" target="_blank">Click Here</a></p>
                    </div>
                    </div>
                    </div>
                </div>
            </div>
            
            <div class="container-fluid py-5">
        <div class="container py-5">
            <div class="row" style="background-color: #15d7b4; border-radius: 25px;">
                <div class="col-lg-5 mb-2 mb-lg-2" style="min-height: 250px;">
                    <div class="position-relative h-70">
                        <%-- <p style="text-align: left;"><%=srno%>.</p> --%>
						<p style="text-align: left;"><h1><b>Help Save Elephants in India</b></h1></p>
						<p style="text-align: left;"><b> -Wildlife: Save it to cherish or leave it to perish.</b></p>
                    	<p style="text-align: left;"><b>Raised:- Rs.3346/- </b></p>
						<p style="text-align: left;"><b>Goal:- Rs.12000/- </b></p>
						<!-- <p style="text-align: left;"><b>College Departments:- </b></p>
						<p style="text-align: left;"><b>Course:- </b></p> -->
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="section-title position-relative mb-4">
                        <p style="text-align: left;"><br><img src="images/img02.png" alt="Girl in a jacket" width="750" height="220"></p>
						<p style="text-align: left;"><b>College WebSite:- </b><a href="Payment.jsp" target="_blank">Click Here</a></p>
                    </div>
                    </div>
                    </div>
                </div>
            </div>
            
            <div class="container-fluid py-5">
        <div class="container py-5">
            <div class="row" style="background-color: #15d7b4; border-radius: 25px;">
                <div class="col-lg-5 mb-2 mb-lg-2" style="min-height: 250px;">
                    <div class="position-relative h-70">
                        <%-- <p style="text-align: left;"><%=srno%>.</p> --%>
						<p style="text-align: left;"><h1><b>Donate Food for Poor Patients</b></h1></p>
						<p style="text-align: left;"><b> -Your small contribution will support us to feed poor patients outside hospitals.</b></p>
                    	<p style="text-align: left;"><b>Raised:- Rs.4391/- </b></p>
						<p style="text-align: left;"><b>Goal:- Rs.8000/- </b></p>
						<!-- <p style="text-align: left;"><b>College Departments:- </b></p>
						<p style="text-align: left;"><b>Course:- </b></p> -->
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="section-title position-relative mb-4">
                        <p style="text-align: left;"><br><img src="images/img03.png" alt="Girl in a jacket" width="750" height="220"></p>
						<p style="text-align: left;"><b>College WebSite:- </b><a href="Payment.jsp" target="_blank">Click Here</a></p>
                    </div>
                    </div>
                    </div>
                </div>
            </div>
            
		</div>
	</div>
	</div>
	</div>
	<br><br><br><br><br><br>
</div>
</div>
		<div class="container"></div>
	</section>
	
	<!-- JavaScript libs are placed at the end of the document so the pages load faster -->
	<script src="assets1/js/modernizr-latest.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
	<script src="assets1/js/jquery.cslider.js"></script>
	<script src="assets1/js/custom.js"></script>
</body>
</html>

