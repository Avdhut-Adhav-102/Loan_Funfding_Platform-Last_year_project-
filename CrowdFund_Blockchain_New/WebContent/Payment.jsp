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
					<li><a href="Index.jsp">Home</a></li>
					<li><a href="Signin.jsp">Charity</a></li>
					<li><a href="owner_signin.jsp">Donor</a></li>
					<li><a href="admin_signin.jsp">Government</a></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</div>
	<!-- /.navbar -->
<%
String no=request.getParameter("no");
if(no==null)
{}
else if(no.equals("1"))
{
	%>
	<script type="text/javascript">
			
	
			alert("Please Register First");	
			</script>	
		<%	
}
%>
	<!-- Header -->
	<header id="headO">
		<div class="container">
			
		</div>
	</header>
	<!-- /Header -->


	<div id="courses">
		
	</div>
	<!-- container -->
	<section class="container">
		<div >
			<!-- Heading -->
			<h3>Donate Your Amount</h3>
		</div>
		<div class="row">
			<div class="col-md-4">
				<img src="./images/donate.png" alt="" class="img-responsive">
			</div>
			<div class="col-md-8">
				<form action="#" method="post" >
		        <div align="left">  
		            <input type="text" class="form-control" placeholder="Enter Amount" name="amount" required>
		        </div>
		        <br/>
		        <div class="form-group" align="left">
		            <input type="text" class="form-control" placeholder="Enter Doner Name" name="dname" required>
		        </div>
		        <div class="form-group" align="left">
		            <input type="text" class="form-control" placeholder="Enter UPI ID" name="uno" required>
		        </div>
		       
		        <div align="left">
		        <button type="submit" class="btn btn-success">Donate</button>
		         <button type="reset" class="btn btn-primary">Reset</button><br>
		        </div>
		        <div align="right">
		        <br/> </div>
         
		        <div align="left">
		        Back to Home Page: &nbsp;<a href="Campaigns.jsp"><button type="button" class="btn btn-link">Back</button></a>        
		        </div>
    		</form>

			</div>
		</div>
	</section>
	

	<!-- JavaScript libs are placed at the end of the document so the pages load faster -->
	<script src="assets1/js/modernizr-latest.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
	<script src="assets1/js/jquery.cslider.js"></script>
	<script src="assets1/js/custom.js"></script>
</body>
</html>


