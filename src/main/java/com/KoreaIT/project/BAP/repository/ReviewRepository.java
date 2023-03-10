package com.KoreaIT.project.BAP.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.KoreaIT.project.BAP.vo.Review;

@Mapper
public interface ReviewRepository {

	@Select("""
			SELECT r.*,
				m.name AS extra__writerName
				FROM review AS r
				LEFT JOIN `member` AS m
				ON r.memberId = m.id
				WHERE r.comp_id = #{comp_id}
			""")
	List<Review> getReviewsByComp_id(int comp_id);

	@Select("""
			SELECT *
				FROM review
				WHERE booking_id = #{booking_id}
			""")
	Review getReviewByBooking_id(int booking_id);

	@Insert("""
			INSERT INTO review
				SET regDate = NOW(),
				updateDate = NOW(),
				memberId = #{memberId},
				comp_id = #{comp_id},
				booking_id = #{booking_id},
				rating = #{rating},
				body = #{body}
			""")
	void doWrite(int memberId, int comp_id, int booking_id, int rating, String body);

	@Select("""
			SELECT r.*,
				m.name AS extra__writerName
				FROM review AS r
				LEFT JOIN `member` AS m
				ON r.memberId = m.id
				WHERE r.id = #{id}
			""")
	Review getReviewById(int id);

	@Update("""
			UPDATE review
				SET updateDate = NOW(), 
				rating = #{rating},
				body = #{body}
				WHERE id = #{id}
			""")
	void doModify(int id, int rating, String body);

	@Select("""
			SELECT r.*, m.name AS extra__writerName
				FROM review AS r
				LEFT JOIN `member` AS m
				ON r.memberId = m.id
				WHERE r.comp_id = #{comp_id}
				ORDER BY r.id desc
			""")
	List<Review> getForPrintReviews(int comp_id);

	@Delete("""
			DELETE FROM review 
				WHERE id = #{id}
			""")
	void doDelete(int id);

	@Select("""
			<script>
			SELECT r.*,
				m.name AS extra__writerName,
				c.name AS extra__compName,
				pr.roomType AS extra__prodRoomType
				FROM review AS r
				LEFT JOIN `member` AS m
				ON r.memberId = m.id
				LEFT JOIN company AS c
				ON r.comp_id = c.id
				LEFT JOIN product AS pr
				ON pr.comp_id = c.id
				WHERE r.memberId = #{memberId}
				<if test="searchKeyword != ''">
					<choose>
						<when test="searchKeywordTypeCode == 'name'">
							AND c.name LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
					</choose>
				</if>
				GROUP BY r.id
				ORDER BY r.id desc
				</script>
			""")
	List<Review> getReviewByMemberId(int memberId, String searchKeywordTypeCode, String searchKeyword);

}
