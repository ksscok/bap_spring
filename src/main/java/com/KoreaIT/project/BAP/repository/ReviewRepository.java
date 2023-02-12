package com.KoreaIT.project.BAP.repository;

import java.util.List;

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
				WHERE comp_id = #{comp_id}
			""")
	List<Review> getReviewByComp_id(int comp_id);

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

//	@Delete("""
//			DELETE FROM wish 
//				WHERE memberId = #{memberId}
//				AND comp_id = #{comp_id}
//			""")
//
//	@Select("""
//			<script>
//			SELECT COUNT(*)
//				FROM wish AS w
//				LEFT JOIN company AS c
//				ON w.comp_id = c.id
//				WHERE memberId = #{memberId}
//					<if test="searchKeyword != ''">
//						<choose>
//							<when test="searchKeywordTypeCode == 'name'">
//								AND c.name LIKE CONCAT('%', #{searchKeyword}, '%')
//							</when>
//						</choose>
//					</if>
//			</script>
//			""")

}
