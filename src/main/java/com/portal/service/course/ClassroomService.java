package com.portal.service.course;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.domain.classroom.BuildingDto;
import com.portal.domain.classroom.ClassroomDto;
import com.portal.domain.classroom.RoomDto;
import com.portal.mapper.classroom.ClassroomMapper;

@Service
@Transactional
public class ClassroomService {
	
	@Autowired
	private ClassroomMapper classroomMapper;

	public List<ClassroomDto> getClassroom() {
		
		return classroomMapper.selectClassroomAll();
	}

	public List<BuildingDto> getBuildingAll() {
		// TODO Auto-generated method stub
		return classroomMapper.selectBuildingAll();
	}

	public List<RoomDto> getClassroomByBuildingId(int buildingId, String campus) {
		// TODO Auto-generated method stub
		return classroomMapper.selectClassroomByBuildingId(buildingId, campus);
	}

	public BuildingDto getBuildingById(int buildingId, String campus) {
		// TODO Auto-generated method stub
		return classroomMapper.selectBuildingById(buildingId, campus);
	}



}
