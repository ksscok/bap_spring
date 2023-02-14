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

	public void doWrite(long memberId, int payment_id, int p_point) {
		pointRepository.doWrite(memberId, payment_id, p_point);
	}

	public List<Point> getPointsByMemberId(long memberId) {
		return pointRepository.getPointsByMemberId(memberId);
	}
}
