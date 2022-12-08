package com.portal.mapper.courseSchedule;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CourseScheduleMapper {

	int insertScheduleByClassCode(int classCode, String day, int startTimeId, int endTimeId);

}
