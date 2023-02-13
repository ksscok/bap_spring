package com.KoreaIT.project.BAP.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.KoreaIT.project.BAP.vo.Point;

@Mapper
public interface PointRepository {
	
	@Insert("""
			INSERT into `point`
			SET regDate = NOW(),
			updateDate = NOW(),
			memberId = #{memberId},
			payment_id = #{payment_id},
			p_point = #{p_point}
			""")
	void doWrite(int memberId, int payment_id, int p_point);

	@Select("""
			SELECT po.*,
				c.name AS extra__compName,
				pa.balanceAmount AS extra__balanceAmount
				FROM `point` AS po
				LEFT JOIN payment AS pa
				ON po.payment_id = pa.id
				LEFT JOIN booking AS b
				ON pa.booking_id = b.id
				LEFT JOIN company AS c
				ON b.comp_id = c.id
				WHERE po.memberId = #{memberId}
				GROUP BY po.id
				ORDER BY po.id desc
			""")
	List<Point> getPointsByMemberId(int memberId);

}
