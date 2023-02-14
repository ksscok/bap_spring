package com.KoreaIT.project.BAP.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.KoreaIT.project.BAP.vo.Member;

@Mapper
public interface MemberRepository {

	@Select("""
			SELECT *
			FROM `member`
			WHERE loginId = #{loginId}
			""")
	public Member getMemberByLoginId(String loginId);

	
	@Insert("""
			INSERT into `member`
			SET regDate = NOW(),
			updateDate = NOW(),
			memberType = #{memberType},
			loginId = #{loginId},
			loginPw = #{loginPw},
			name = #{name},
			email = #{email},
			cellphoneNo = #{cellphoneNo}
			""")
	public void join(String memberType, String loginId, String loginPw, String name, String email, String cellphoneNo);


	@Select("""
			SELECT * 
			FROM `member`
			WHERE id = #{id}
			""")
	public Member getMemberById(long id);


	@Update("""
			<script>
			UPDATE `member`
			<set>
				updateDate = NOW(),
				<if test="loginPw != null">
					loginPw = #{loginPw},
				</if>
				<if test="email != null">
					email = #{email},
				</if>
				<if test="cellphoneNo != null">
					cellphoneNo = #{cellphoneNo},
				</if>
			</set>
			WHERE id = #{id}
			</script>
			""")
	public void modify(long id, String loginPw, String email, String cellphoneNo);

	@Update("""
			UPDATE `member`
			SET updateDate = NOW(),
			m_point = m_point + #{m_point}
			WHERE id = #{id}
			""")
	public void doModifyPoint(long id, int m_point);


	@Insert("""
			INSERT INTO `member`
			SET id = #{id},
			regDate = NOW(),
			updateDate = NOW(),
			memberType = 'guest',
			loginId = 'kakao',
			loginPw = 'kakao',
			name = #{name},
			email = #{email},
			cellphoneNo = 'kakao'
			""")
	public void kakaoJoin(long id, String name, String email);

}
