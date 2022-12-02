package com.portal.domain.classroom;

import lombok.Data;

@Data
public class ClassroomDto {
	private int buildingId;
	private String campus;
	private int roomId;
	private BuildingDto building;
	private RoomDto room;
}
