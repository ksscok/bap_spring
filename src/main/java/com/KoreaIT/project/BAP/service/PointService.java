package com.KoreaIT.project.BAP.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.project.BAP.repository.PointRepository;
import com.KoreaIT.project.BAP.vo.Point;

@Service
public class PointService {
	
	public PointRepository pointRepository;
	
	@Autowired
	public PointService(PointRepository pointRepository) {
		this.pointRepository = pointRepository;
	}

	public void doWrite(int memberId, int payment_id, int p_point, String status) {
		pointRepository.doWrite(memberId, payment_id, p_point, status);
	}

	public List<Point> getPointsByMemberId(int memberId, String start_date, String end_date, String searchKeywordTypeCode, int itemsInAPage, int page) {
		
		int limitStart = (page - 1) * itemsInAPage;
		
		return pointRepository.getPointsByMemberId(memberId, start_date, end_date, searchKeywordTypeCode, limitStart, itemsInAPage);
	}

	public int getPointsCount(int memberId, String start_date, String end_date, String searchKeywordTypeCode) {
		return pointRepository.getPointsCount(memberId, start_date, end_date, searchKeywordTypeCode);
	}
}
