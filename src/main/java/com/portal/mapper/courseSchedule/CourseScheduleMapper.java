package com.portal.mapper.courseSchedule;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.portal.domain.course.CourseScheduleDto;
import com.portal.domain.course.CourseTimeDto;

@Mapper
public interface CourseScheduleMapper {

	int insertScheduleByClassCode(int classCode, String day, int startTimeId, int endTimeId);

	int deleteCourseScheduleByClassCode(int classCode);

	List<CourseScheduleDto> selectCourseScheduleByClassCode(int classCode);

	List<CourseScheduleDto> selectCourseScheduleByStudentSignUp(int studentNumber);

	List<CourseTimeDto> selectCourseTimeAll();

}
