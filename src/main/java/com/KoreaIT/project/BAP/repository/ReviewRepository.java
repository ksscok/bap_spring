package com.KoreaIT.project.BAP.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.KoreaIT.project.BAP.vo.Review;

@Mapper
public interface ReviewRepository {

	@Select("""
			SELECT *
				FROM review
				WHERE comp_id = #{comp_id}
			""")
	List<Review> getReviewByComp_id(int comp_id);

//	@Select("""
//			SELECT *
//				FROM wish
//				WHERE memberId = #{memberId}
//				AND comp_id = #{comp_id}
//			""")
//	
//	@Insert("""
//			INSERT INTO wish
//				SET regDate = NOW(),
//				updateDate = NOW(),
//				memberId = #{memberId},
//				comp_id = #{comp_id}
//			""")
//
//	@Delete("""
//			DELETE FROM wish 
//				WHERE memberId = #{memberId}
//				AND comp_id = #{comp_id}
//			""")
//
//	@Select("""
//			SELECT *
//				FROM wish
//				WHERE memberId = #{memberId}
//			""")
//
//	@Select("""
//			SELECT comp_id
//				FROM wish
//				WHERE memberId = #{memberId}
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
