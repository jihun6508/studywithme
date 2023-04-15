<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%!// 변수 선언
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String uid = "ADMIN";
	String pwd = "StudyWithMe4$";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String sql = "select * from TBL_USER";%>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	.modal {
		display: none; /* Hidden by default */
		position: fixed; /* Stay in place */
		z-index: 1; /* Sit on top */
		left: 0;
		top: 0;
		width: 100%; /* Full width */
		height: 100%; /* Full height */
		overflow: auto; /* Enable scroll if needed */
		background-color: rgb(0, 0, 0); /* Fallback color */
		background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
	}
	/* Modal Content/Box */
	.modal-content {
		background-color: #fefefe;
		margin: 15% auto; /* 15% from the top and centered */
		padding: 20px;
		border: 1px solid #888;
		width: 60%; /* Could be more or less, depending on screen size */
	}
	/* The Close Button */
	.close {
		color: #aaa;
		float: right;
		font-size: 28px;
		font-weight: bold;
	}
	
	.close:hover, .close:focus {
		color: black;
		text-decoration: none;
		cursor: pointer;
	}
	.img{
		height: 20px;
		weight: 20px;
	}
	.modal-top{
		margin: 0% auto; /* 15% from the top and centered */
		padding: 0px;
		text-align: center;
	}
</style>

</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
	<div class="container-fluid">
		
		<div class="collapse navbar-collapse" id="navbarColor01">
			<ul class="navbar-nav me-auto">
				<li class="nav-item"><a class="nav-link active" href="#">Home
						<span class="visually-hidden">(current)</span>
				</a></li>
				<li class="nav-item"><a class="nav-link" href="#">공지사항</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="#">스터디석</a></li>
				<li class="nav-item"><a class="nav-link" href="#">사물함</a></li>
				<li class="nav-item"><a class="nav-link" href="#">스터디룸</a></li>
				<li class="nav-item"><a class="nav-link" href="#">응원리뷰</a></li>
				<li class="nav-item"><a class="nav-link" href="#">마이페이지</a></li>
			</ul>
		</div>
	</div>
	</nav>

	<h1>스터디 위드 미</h1>
	
	<p><sec:authentication property="principal.username"/> 님 환영합니다.</p>
	
	<div>
		<h1 id="study-title">스터디카페 위치</h1>
		
		<div class="modal">
			<div class="modal-content">
				<div class="modal-top">
					<span class="close">&times;</span>
					<p>이용하실 스터디카페를 검색해 주세요.</p>
					<hr>
				</div>

				<div>
					<div class="row">
						<div id='searchForm'>
							<input type='text' id='keyword' name='keyword' />
							<input type='hidden' id='pageNum' name='pageNum' value='1' />
							<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>' />
							<button id="search-check-btn">Search</button>
						</div>

					</div>
					
					<!-- 스터디카체 리스트 출력-->
					<table id="study-table">
						<thead>
							<tr>
								<td>스터디카페</td>
								<td>주소</td>
							</tr>
						</thead>
					</table>

					<div class='pull-right'>
						<ul class="pagination">

							<c:if test="${pageMaker.prev}">
								<li class="paginate_button previous"><a
									href="${pageMaker.startPage -1}">Previous</a></li>
							</c:if>

							<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
								<li class="paginate_button  ${pageMaker.cri.pageNum == num ? "active":""} ">
									<a href="${num}">${num}</a>
								</li>
							</c:forEach>

							<c:if test="${pageMaker.next}">
								<li class="paginate_button next"><a
									href="${pageMaker.endPage +1 }">Next</a></li>
							</c:if>


						</ul>
					</div>
					
					<div id="page-numbers">
						<a id='page-1' href='#'>1</a>
						<a id='page-2' href='#'>2</a>
						<a id='page-3' href='#'>3</a>
						<a id='page-4' href='#'>4</a>
						<a id='page-5' href='#'>5</a>
					</div>
				</div>
				
<%-- 
				<form id='actionForm' action="/userMainPage" method='get'>
					<input type='hidden' id='pageNum' name='pageNum' value='${pageMaker.cri.pageNum}'>
					<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
					<input type='hidden' name='type' value='<c:out value="${ pageMaker.cri.type }"/>'>
					<input type='hidden' name='keyword' value='<c:out value="${ pageMaker.cri.keyword }"/>'>
				</form>
 --%>

				<form id='actionForm'>
					<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
					<input type='hidden' id='amount' name='amount' value='${pageMaker.cri.amount}'>
					<input type='hidden' name='type' value='<c:out value="${ pageMaker.cri.type }"/>'>
					<input type='hidden' name='keyword' value='<c:out value="${ pageMaker.cri.keyword }"/>'>
				</form>

			</div>
		</div>

		<button type="button" class="btn"><img class="img" src="/resources/image/search.jpg"></button>
	</div>
	
	<div>
		<button type="button"  onclick="location.href='/'">충전하기</button>

		<div class="modal">
			<div class="modal-content">
				<span class="close">&times;</span>
				<p>
					QR code
				</p>
			</div>
		</div>

		<button type="button" class="btn">QR 코드</button>
	</div>

	

	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script>
	$(document).ready(function(){
		var actionForm = $("#actionForm");

		$(".paginate_button a").on(
				"click",
				function(e) {

					e.preventDefault();

					console.log('click');

					actionForm.find("input[name='pageNum']")
							.val($(this).attr("href"));
					actionForm.submit();
				});
		
		search("", 1);
		getTotalCount("");
		addPageNumbersEvent();
	});
	
	const PAGE_SIZE = 10;
	
	
	
	
		// Modal을 가져옵니다.
		var modals = document.getElementsByClassName("modal");
		// Modal을 띄우는 클래스 이름을 가져옵니다.
		var btns = document.getElementsByClassName("btn");
		// Modal을 닫는 close 클래스를 가져옵니다.
		var spanes = document.getElementsByClassName("close");
		var funcs = [];

		// Modal을 띄우고 닫는 클릭 이벤트를 정의한 함수
		function Modal(num) {
			return function() {
				// 해당 클래스의 내용을 클릭하면 Modal을 띄웁니다.
				btns[num].onclick = function() {
					modals[num].style.display = "block";
					console.log(num);
				};

				// <span> 태그(X 버튼)를 클릭하면 Modal이 닫습니다.
				spanes[num].onclick = function() {
					modals[num].style.display = "none";
				};
			};
		}

		// 원하는 Modal 수만큼 Modal 함수를 호출해서 funcs 함수에 정의합니다.
		for (var i = 0; i < btns.length; i++) {
			funcs[i] = Modal(i);
		}

		// 원하는 Modal 수만큼 funcs 함수를 호출합니다.
		for (var j = 0; j < btns.length; j++) {
			funcs[j]();
		}

		// Modal 영역 밖을 클릭하면 Modal을 닫습니다.
		window.onclick = function(event) {
			if (event.target.className == "modal") {
				event.target.style.display = "none";
			}
		};
		
		// void search(keyword)
		const search = function(keyword, currentPage) {
			// Ajax 요청으로 스터디카페 리스트 출력
			$.ajax({
				type : "GET",
				url : "/getStudyCafeList",
				data : {
					keyword : keyword,
					currentPage : currentPage,
					perPage : PAGE_SIZE
				},
				success : function(response) {
					console.log(response);

					// 결과 화면에 뿌려준다
					$("#study-table").empty();
					
					for (const studyCafe of response) {
						console.log(studyCafe);
						$("#study-table").append("<tr><td><a href='#' >" + studyCafe.name + "</a></td><td>" + studyCafe.address + "</td></tr>");
						
					}
					
					addStudyCafeEvent();
					
					
					// study_table append tr 제거
					// 페이징 append tr 추가
					
				}
			});
		}
		
		const getTotalCount = function(keyword) {
			$.ajax({
				type: "GET",
				url: "/totalCount",
				data: {keyword: keyword},
				success: function(response) {
					
					/* if (response === 0) {
						return;
					}
					
					const pageNumber = response / PAGE_SIZE; // 0
					const remain = response % 5; // 0 1 2 3 4
					
					for (let i = 0; i <= remain; i++) {
						$("#page-numbers").append("<a href='#'>"+i+"</a>");
					} */
					
				}
			});
		}
		
		// $(this) 현재 클릭한 태그
		// $(this).html() => 'studyCafe.name'
		// $("#study-title").html(text) => study-title의 html text 대체
		const addStudyCafeEvent = function() {
			$("#study-table tr td a").click(function() {
				const text = $(this).html();
				$("#study-title").html(text);
				modals[0].style.display = "none";
				
			});			
		};
		
		

		// 스터디카페 검색
		
		$("#search-check-btn").click(function() {
			const keyword = $("#keyword").val();

			search(keyword, 1);
			getTotalCount(keyword);
		});
		
		// 페이징 처리
		const addPageNumbersEvent = function(){
			$("#page-numbers a").click(function(){
				const num = $(this).html();
				const keyword = $("#keyword").val();

				search(keyword, num);
			});
		};
	</script>

</body>
</html>
