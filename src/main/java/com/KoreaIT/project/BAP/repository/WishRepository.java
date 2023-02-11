package com.KoreaIT.project.BAP.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.KoreaIT.project.BAP.vo.Company;
import com.KoreaIT.project.BAP.vo.Wish;

@Mapper
public interface WishRepository {

	@Select("""
			SELECT *
				FROM wish
				WHERE memberId = #{memberId}
				AND comp_id = #{comp_id}
			""")
	Wish getWishByMemberIdAndComp_id(int memberId, int comp_id);
	
	@Insert("""
			INSERT INTO wish
				SET regDate = NOW(),
				updateDate = NOW(),
				memberId = #{memberId},
				comp_id = #{comp_id}
			""")
	void doWrite(int memberId, int comp_id);

	@Delete("""
			DELETE FROM wish 
				WHERE memberId = #{memberId}
				AND comp_id = #{comp_id}
			""")
	void doDelete(int memberId, int comp_id);

	@Select("""
			SELECT *
				FROM wish
				WHERE memberId = #{memberId}
			""")
	List<Wish> getWishByMemberId(int memberId);

	@Select("""
			SELECT comp_id
				FROM wish
				WHERE memberId = #{memberId}
			""")
	int[] getComp_idByMemberId(int memberId);

	@Select("""
			<script>
			SELECT COUNT(*)
				FROM wish AS w
				LEFT JOIN company AS c
				ON w.comp_id = c.id
				WHERE memberId = #{memberId}
					<if test="searchKeyword != ''">
						<choose>
							<when test="searchKeywordTypeCode == 'name'">
								AND c.name LIKE CONCAT('%', #{searchKeyword}, '%')
							</when>
						</choose>
					</if>
			</script>
			""")
	int getWishesCountByIds(int memberId, String searchKeywordTypeCode, String searchKeyword);

}
