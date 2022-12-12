<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<my:adminPageTopNav></my:adminPageTopNav>
<div class="d-flex">
<my:adminPageLeftNav></my:adminPageLeftNav>
	<div class="container-md">
		<div class="row">
			<div class="col">
				<div class="mb-3">
					<h1>새 강의 등록</h1>
				</div>
				<form id="registerForm1" action="" method="post" enctype="multipart/form-data">
					<div class="mb-3">
						<label for="" class="form-label">학년</label>
						<select name="grade" class="form-select" aria-label="Default select example">
							<option value="1학년" selected="selected">1</option>
							<option value="2학년">2</option>
							<option value="3학년">3</option>
							<option value="4학년">4</option>
							<option value="5학년">5</option>
							<option value="전학년">전학년</option>
						</select>
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">학수번호</label>
						<select name="classNumber" class="form-select" aria-label="Default select example">
							<c:forEach items="${courseInfoList }" var="courseInfo">
								<option value="${courseInfo.classNumber }">${courseInfo.classNumber } : ${courseInfo.courseName }</option>
							</c:forEach>
						</select>
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">교강사</label>
						<select name="professorNumber" class="form-select" aria-label="Default select example">
							<c:forEach items="${professorList }" var="professor">
								<option value="${professor.professorNumber }">${professor.name } : ${professor.department.name } - ${professor.department.college.name } - ${professor.department.college.organization.name }</option>
							</c:forEach>
						</select>
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">수강정원</label>
						<input required="required" type="number" class="form-control" name="maxPersonnel" value="40">
					</div>
					
					<div id="courseScheduleId1" class="mb-3">
						<label for="" class="form-label">
							수업시간 <button onclick="AddCourseSchedule()" type="button" class="btn btn-primary"><i class="fa-solid fa-plus"></i></button>
						</label>
						<div class="d-flex">
							<select name="day" class="form-select" aria-label="Default select example">
								<option value="Monday">월</option>
								<option value="Tuesday">화</option>
								<option value="Wednesday">수</option>
								<option value="Thursday">목</option>
								<option value="Friday">금</option>
								<option value="Saturday">토</option>
								<option value="Sunday">일</option>
							</select>
							<select name="startTimeId" class="form-select" aria-label="Default select example">
								<c:forEach items="${courseTimeList }" var="courseTime">
									<option value="${courseTime.id }">${courseTime.time }</option>
								</c:forEach>
							</select>
							<select name="endTimeId" class="form-select" aria-label="Default select example">
								<c:forEach items="${courseTimeList }" var="courseTime">
									<option value="${courseTime.id }">${courseTime.time }</option>
								</c:forEach>
							</select>
							<button type="button" disabled="disabled" class="btn btn-light">
								<i class="fa-solid fa-xmark"></i>
							</button>
						</div>
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">강의실</label>
						<div class="d-flex">
							<select id="selectBuildingId1" name="building" class="form-select" aria-label="Default select example" >
								<c:forEach items="${buildingList }" var="building">
									<option value="${building.campus }:${building.id }">${building.campus } ${building.name }</option>
								</c:forEach>
							</select>
							<select id="selectRoomId1" name="room" class="form-select" aria-label="Default select example">
								<c:forEach items="${roomListByFirstBuilding }" var="room">
									<option value="${room.room }${room.classification }">${room.room }${room.classification }</option>
								</c:forEach>
							</select>
						</div>
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">관장학과</label>
						<select name="departmentId" class="form-select" aria-label="Default select example">
							<c:forEach items="${departmentList }" var="department">
								<option value="${department.id }">${department.name } - ${department.college.name } - ${department.college.organization.name }</option>
							</c:forEach>
						</select>
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">년도</label>
						<input required="required" type="number" class="form-control" name="year" value="2022">
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">학기</label>
						<select name="semester" class="form-select" aria-label="Default select example">
						  <option value="1학기">1학기</option>
						  <option value="여름학기">여름학기</option>
						  <option value="2학기">2학기</option>
						  <option value="겨울학기" selected>겨울학기</option>
						</select>
					</div>
					<input id="submitButton1" class="btn btn-primary" type="submit" value="등록">
				</form>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
const ctx = "${pageContext.request.contextPath}";

function AddCourseSchedule() {
	document.querySelector("#courseScheduleId1").insertAdjacentHTML("beforeend",`
			<div class="d-flex">
				<select name="day" class="form-select" aria-label="Default select example">
					<option value="Monday">월</option>
					<option value="Tuesday">화</option>
					<option value="Wednesday">수</option>
					<option value="Thursday">목</option>
					<option value="Friday">금</option>
					<option value="Saturday">토</option>
					<option value="Sunday">일</option>
				</select>
				<select name="startTimeId" class="form-select" aria-label="Default select example">
					<c:forEach items="${courseTimeList }" var="courseTime">
						<option value="${courseTime.id }">${courseTime.time }</option>
					</c:forEach>
				</select>
				<select name="endTimeId" class="form-select" aria-label="Default select example">
					<c:forEach items="${courseTimeList }" var="courseTime">
						<option value="${courseTime.id }">${courseTime.time }</option>
					</c:forEach>
				</select>
				<button onclick="DeleteCourseSchedule()" type="button" class="btn btn-light">
					<i class="fa-solid fa-xmark"></i>
				</button>
			</div>
			`);
}

function DeleteCourseSchedule() {

	/* this.wrap('<div></div>').remove(); */
}


// 강의실
const selectBuilding1 = document.querySelector("#selectBuildingId1");
selectBuilding1.addEventListener("change", function selectRoomByBuilding() {
	const selectRoomId1 = document.querySelector("#selectRoomId1"); 
	selectRoomId1.innerHTML = "";
	
	const building = document.querySelector("#selectBuildingId1").value
	const data = {building};
	fetch(`\${ctx}/course/getClassroom`, {
		method : "post",
		headers : {
			"Content-Type" : "application/json"
		},
		body : JSON.stringify(data)
	})
	.then(res => res.json())
	.then(list => {
		
		for(const item of list) {
			const room = `<option value="\${item.id }">\${item.room }\${item.classification }</option>`	
			selectRoomId1.insertAdjacentHTML("beforeend", room);
		}
	});
});




</script>
</body>
</html>