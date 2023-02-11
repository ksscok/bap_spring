package com.KoreaIT.project.BAP.repository;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReviewRepository {

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
