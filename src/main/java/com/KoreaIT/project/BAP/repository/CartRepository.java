package com.KoreaIT.project.BAP.repository;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.KoreaIT.project.BAP.vo.Cart;

@Mapper
public interface CartRepository {

	@Select("""
			SELECT *
				FROM cart
				WHERE memberId = #{memberId}
				AND comp_id = #{comp_id}
			""")
	Cart getCartByMemberIdAndComp_id(int memberId, int comp_id);
	
	@Insert("""
			INSERT INTO cart
				SET regDate = NOW(),
				updateDate = NOW(),
				memberId = #{memberId},
				comp_id = #{comp_id}
			""")
	void doWrite(int memberId, int comp_id);

	@Delete("""
			DELETE FROM cart 
				WHERE memberId = #{memberId}
				AND comp_id = #{comp_id}
			""")
	void doDelete(int memberId, int comp_id);
	
}
