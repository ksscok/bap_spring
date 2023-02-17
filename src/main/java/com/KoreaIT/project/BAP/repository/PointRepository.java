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
			booking_id = #{payment_id},
			p_point = #{p_point},
			`status` = #{status}
			""")
	void doWrite(long memberId, int payment_id, int p_point, String status);

	@Select("""
			<script>
			SELECT * 
			FROM (
					SELECT po.*, 
						c.name AS extra__compName,
						pa.paidRealAmount AS extra__paidRealAmount,
						pa.lastTotalAmount AS extra__lastTotalAmount
						FROM `point` AS po
						LEFT JOIN booking AS b
						ON b.id = po.booking_id
						LEFT JOIN payment AS pa
						ON b.id = pa.booking_id
						LEFT JOIN company AS c
						ON b.comp_id = c.id
						WHERE po.memberId = #{memberId}
							<if test="searchKeywordTypeCode == 'allPoint'">
								AND po.p_point != 0
							</if>
							<if test="searchKeywordTypeCode == 'plusPoint'">
							<![CDATA[
								AND po.p_point > 0
							]]>
							</if>
							<if test="searchKeywordTypeCode == 'minusPoint'">
							<![CDATA[
								AND po.p_point < 0
							]]>
							</if>
							<if test="start_date != '' and end_date != ''">
							<![CDATA[
								AND DATE_FORMAT(po.regDate, '%Y-%m') >= #{start_date} AND  DATE_FORMAT(po.regDate, '%Y-%m') <= #{end_date}
							]]>
							</if>
						GROUP BY po.id
						) AS a
				INNER JOIN `point` AS p
				ON p.id = a.id
				ORDER BY p.id desc
				LIMIT #{limitStart}, #{itemsInAPage}
			</script>
			""")
	List<Point> getPointsByMemberId(long memberId, String start_date, String end_date, String searchKeywordTypeCode, int limitStart, int itemsInAPage);

	@Select("""
			<script>
			SELECT COUNT(*)
				FROM `point`
				WHERE memberId = #{memberId}
					<if test="searchKeywordTypeCode == 'allPoint'">
						AND p_point != 0
					</if>
					<if test="searchKeywordTypeCode == 'plusPoint'">
					<![CDATA[
						AND p_point > 0
					]]>
					</if>
					<if test="searchKeywordTypeCode == 'minusPoint'">
					<![CDATA[
						AND p_point < 0
					]]>
					</if>
					<if test="start_date != '' and end_date != ''">
					<![CDATA[
						AND DATE_FORMAT(regDate, '%Y-%m') >= #{start_date} AND  DATE_FORMAT(regDate, '%Y-%m') <= #{end_date}
					]]>
					</if>
			</script>
			""")
	int getPointsCount(long memberId, String start_date, String end_date, String searchKeywordTypeCode);
}
