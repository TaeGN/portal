package com.portal.mapper.classroom;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.portal.domain.classroom.BuildingDto;
import com.portal.domain.classroom.ClassroomDto;
import com.portal.domain.classroom.RoomDto;

@Mapper
public interface ClassroomMapper {

	List<ClassroomDto> selectClassroomAll();

	List<BuildingDto> selectBuildingAll();

	List<RoomDto> selectClassroomByBuildingId(int buildingId, String campus);

	BuildingDto selectBuildingById(int buildingId, String campus);

}
