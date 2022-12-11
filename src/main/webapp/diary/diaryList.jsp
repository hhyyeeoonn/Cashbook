<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	//Controller : session, request
	if(session.getAttribute("loginMember") == null) { // 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	Member loginMember = (Member)session.getAttribute("loginMember");
		System.out.println(loginMember);

	
	// request 년 + 월
	int year = 0; 
	int month = 0;
		
	if ((request.getParameter("year") == null) || (request.getParameter("month")) == null) {
		Calendar today = Calendar.getInstance(); // 오늘날짜
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH); // 우리가 생각하는 달보다 1 작다
	} else {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		// month -> -1, month -> 12일 경우
		if (month == -1) {
			month = 11;
			year -= 1;	
		}
		if(month == 12) {
			month = 0;
			year += 1;
		}
	}

	// 출력하고자 하는 연도와 달과 그 달 1일의 요일 (일=1, 월=2, 화=3,...,토=7)
	Calendar targetDate = Calendar.getInstance();
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	// firstDay는 1일의 요일
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK);
	// beginBlank 개수는 firstDat-1
	
	
	// 마지막 날짜
	int lastDate = targetDate.getActualMaximum(Calendar.DATE);	
	
	// 달력 출력 테이블의 시작 공백셀(td)과 마지막 공백섹(td)의 개수
	int beginBlank = firstDay - 1;
	int endBlank = 0; // 7로 나누어 떨어진다 /beginBlank + lastDate + endBlank = 7
	if((beginBlank + lastDate) % 7 != 0) {
		endBlank = 7 - ((beginBlank + lastDate) % 7);
	}
	
	// 전체 td의 개수 : 7로 나누어 떨어져야 한다
	int totalTd = beginBlank + lastDate + endBlank; 
	
	
	// Model 호출 
	DiaryDao diaryDao = new DiaryDao();
	ArrayList<HashMap<String, Object>> list = diaryDao.selectDiaryListByMonth(loginMember.getMemberId(), year, month+1);
%>


<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>diaryList</title>

    <!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/Resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/Resources/css/sb-admin-2.min.css" rel="stylesheet">

	<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>


</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="<%=request.getContextPath()%>/cash/cashNoticeList.jsp">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-laugh-wink"></i>
                </div>
                <div class="sidebar-brand-text mx-3">My Calendar</div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <%
            	if(loginMember.getMemberLevel() == 1) {
            %>
            
            	<!-- Nav Item - Dashboard -->
          			<li class="nav-item active">
                		<a class="nav-link" href="<%=request.getContextPath()%>/admin/adminMain.jsp">
                    	<i class="fas fa-thumbtack"></i>
                    	<span>admin Main</span></a>
            		</li>
        	<%
            	}
        	%>    
            
            
            <!-- Nav Item - Dashboard -->
            <li class="nav-item active">
                <a class="nav-link" href="<%=request.getContextPath()%>/cash/cashNoticeList.jsp">
                    <i class="fas fa-thumbtack"></i>
                    <span>Main</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                My List
            </div>

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
                    aria-expanded="true" aria-controls="collapseTwo">
                    <i class="far fa-calendar-alt"></i>
                    <span>Calendar</span>
                </a>
                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">CashBook</h6>
                        <a class="collapse-item" href="<%=request.getContextPath()%>/cash/cashList.jsp">Cash Calendar</a>
                        <h6 class="collapse-header">Diary</h6>
                        <a class="collapse-item" href="<%=request.getContextPath()%>/diary/diaryList.jsp">Diary Calendar</a>
                    </div>
                </div>
            </li>

           

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                Member Service
            </div>

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages"
                    aria-expanded="true" aria-controls="collapsePages">
                    <i class="fas fa-user-alt"></i>
                    <span>고객지원</span>
                </a>
                <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <a class="collapse-item" href="<%=request.getContextPath()%>/cash/cashNoticeList2.jsp">공지사항</a>
                        <a class="collapse-item" href="<%=request.getContextPath()%>/help/helpList.jsp">QnA</a>
                    </div>
                </div>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>

            <!-- Sidebar Message -->
            <div class="sidebar-card d-none d-lg-flex">
                <img class="sidebar-card-illustration mb-2" src="<%=request.getContextPath()%>/Resources/img/undraw_rocket.svg" alt="...">
                <p class="text-center mb-2"><strong>SB Admin Pro</strong> is packed with premium features, components, and more!</p>
                <a class="btn btn-success btn-sm" href="https://startbootstrap.com/theme/sb-admin-pro">Upgrade to Pro!</a>
            </div>

        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
			<div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>

                    <!-- Topbar Search -->
                    <form
                        class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                        <div class="input-group">
                            <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..."
                                aria-label="Search" aria-describedby="basic-addon2">
                            <div class="input-group-append">
                                <button class="btn btn-primary" type="button">
                                    <i class="fas fa-search fa-sm"></i>
                                </button>
                            </div>
                        </div>
                    </form>

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">

                        <!-- Nav Item - Search Dropdown (Visible Only XS) -->
                        <li class="nav-item dropdown no-arrow d-sm-none">
                            <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-search fa-fw"></i>
                            </a>
                            <!-- Dropdown - Messages -->
                            <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
                                aria-labelledby="searchDropdown">
                                <form class="form-inline mr-auto w-100 navbar-search">
                                    <div class="input-group">
                                        <input type="text" class="form-control bg-light border-0 small"
                                            placeholder="Search for..." aria-label="Search"
                                            aria-describedby="basic-addon2">
                                        <div class="input-group-append">
                                            <button class="btn btn-primary" type="button">
                                                <i class="fas fa-search fa-sm"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </li>

                        <!-- Nav Item - Alerts -->
                        <li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-bell fa-fw"></i>
                                <!-- Counter - Alerts -->
                                <span class="badge badge-danger badge-counter">3+</span>
                            </a>
                            <!-- Dropdown - Alerts -->
                            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="alertsDropdown">
                                <h6 class="dropdown-header">
                                    Alerts Center
                                </h6>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-primary">
                                            <i class="fas fa-file-alt text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">December 12, 2019</div>
                                        <span class="font-weight-bold">A new monthly report is ready to download!</span>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-success">
                                            <i class="fas fa-donate text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">December 7, 2019</div>
                                        $290.29 has been deposited into your account!
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-warning">
                                            <i class="fas fa-exclamation-triangle text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">December 2, 2019</div>
                                        Spending Alert: We've noticed unusually high spending for your account.
                                    </div>
                                </a>
                                <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
                            </div>
                        </li>

                        <!-- Nav Item - Messages -->
                        <li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-envelope fa-fw"></i>
                                <!-- Counter - Messages -->
                                <span class="badge badge-danger badge-counter">7</span>
                            </a>
                            <!-- Dropdown - Messages -->
                            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="messagesDropdown">
                                <h6 class="dropdown-header">
                                    Message Center
                                </h6>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="<%=request.getContextPath()%>/Resources/img/undraw_profile_1.svg"
                                            alt="...">
                                        <div class="status-indicator bg-success"></div>
                                    </div>
                                    <div class="font-weight-bold">
                                        <div class="text-truncate">Hi there! I am wondering if you can help me with a
                                            problem I've been having.</div>
                                        <div class="small text-gray-500">Emily Fowler · 58m</div>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="<%=request.getContextPath()%>/Resources/img/undraw_profile_2.svg"
                                            alt="...">
                                        <div class="status-indicator"></div>
                                    </div>
                                    <div>
                                        <div class="text-truncate">I have the photos that you ordered last month, how
                                            would you like them sent to you?</div>
                                        <div class="small text-gray-500">Jae Chun · 1d</div>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="img/undraw_profile_3.svg"
                                            alt="...">
                                        <div class="status-indicator bg-warning"></div>
                                    </div>
                                    <div>
                                        <div class="text-truncate">Last month's report looks great, I am very happy with
                                            the progress so far, keep up the good work!</div>
                                        <div class="small text-gray-500">Morgan Alvarez · 2d</div>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="https://source.unsplash.com/Mv9hjnEUHR4/60x60"
                                            alt="...">
                                        <div class="status-indicator bg-success"></div>
                                    </div>
                                    <div>
                                        <div class="text-truncate">Am I a good boy? The reason I ask is because someone
                                            told me that people say this to all dogs, even if they aren't good...</div>
                                        <div class="small text-gray-500">Chicken the Dog · 2w</div>
                                    </div>
                                </a>
                                <a class="dropdown-item text-center small text-gray-500" href="#">Read More Messages</a>
                            </div>
                        </li>

                        <div class="topbar-divider d-none d-sm-block"></div>

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small"><%=loginMember.getMemberName()%></span>
                                <img class="img-profile rounded-circle"
                                    src="<%=request.getContextPath()%>/Resources/img/undraw_profile.svg">
                            </a>
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="<%=request.getContextPath()%>/myInfo.jsp">
                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                    회원정보
                                </a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    로그아웃
                                </a>
                            </div>
                        </li>

                    </ul>

                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
				<div class="container-fluid">                   

                    <!-- Content Row -->
                    <div class="row">
                        <div class="col-lg-11 mb-4" style = "margin:0 auto;">


							 <!-- Project Card Example -->
                          	<div class = "container center-block">
	                            <div class="card shadow mb-4">
	                        		<div class="card-header py-3">
	                           			<h6 class="m-0 font-weight-bold text-primary">Cash Calendar</h6>
	                       			</div>
	                        		<div class="card-body">
	                                 	
	                                 	
	                                 	<!-- 달력 -->
										<div>	
											<h6 class="m-0 text-center font-weight-bold text-primary"> <%=year%>년 <%=month + 1%>월</h6>
										</div>
										<div>
											<span class = "float-left">
												<a href="<%=request.getContextPath()%>/diary/diaryList.jsp?year=<%=year%>&month=<%=month-1%>">
													<i class='fas fa-angle-left' style='font-size:24px'></i>
												</a>
											</span>
											<span class = "float-right">											
												<a href="<%=request.getContextPath()%>/diary/diaryList.jsp?year=<%=year%>&month=<%=month+1%>">
													<i class='fas fa-angle-right' style='font-size:24px'></i>
												</a>
											</span>						
										</div>
										<div>
											<table class="table table-bordered">
												<tr>
													<th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th>
												</tr>
												<tr>
												<%
													for (int i=1; i<totalTd; i++) {
												%>
														<td>
												<%
															int date = i-beginBlank;
															if(date > 0 && date <= lastDate) {
												%>
																<div><%=date%></div>
																<br>
												<%
																	int diary = 0;
																	for(HashMap<String, Object> m : list) { 
																		int diaryNo = (Integer)(m.get("diaryNo"));
																		String diaryDate=(String)(m.get("diaryDate"));
																		if(Integer.parseInt(diaryDate.substring(8)) == date) {
																			if(diaryNo != 0) {
																				diary = 1;
																			}
												
																		}
																	}
																	if(diary == 1){
												%>
																		<div>
																			<a href="<%=request.getContextPath()%>/diary/diaryDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>">
																				<i class='fas fa-book' style='font-size:20px'></i>	
																			</a>
																		</div>
												<% 
																	} else {
												%>
																		<div>
																			<a href = "<%=request.getContextPath()%>/diary/insertDiary.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>">
																				<i class='fas fa-pencil-alt' style='font-size:20px'></i>
																			</a>
																		</div>
												<%						
																	}
																}
												%>
															</td>
												<% 
															if(i % 7 == 0 && i != totalTd) {
												%>
																</tr><tr> <!-- td 7개 만들고 테이블 줄바꿈 -->
												<%
															}
														}
												%>
															</tr>
											</table>
										</div> <!-- 달력 끝 -->
								
									</div>
								</div>
                            </div>
						</div>
					</div>
				</div>
                <!-- /.container-fluid -->
	
			</div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; My Calendar 2022</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Logout</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">My Calendar에서 할 일이 끝나셨나요?</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">아니오</button>
                    <a class="btn btn-primary" href="<%=request.getContextPath()%>/logout.jsp">네</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="<%=request.getContextPath()%>/Resources/vendor/jquery/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/Resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="<%=request.getContextPath()%>/Resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="<%=request.getContextPath()%>/Resources/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="<%=request.getContextPath()%>/Resources/vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="<%=request.getContextPath()%>/Resources/js/demo/chart-area-demo.js"></script>
    <script src="<%=request.getContextPath()%>/Resources/js/demo/chart-pie-demo.js"></script>

</body>

</html>