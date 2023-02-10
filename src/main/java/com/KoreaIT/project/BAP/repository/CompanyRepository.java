package com.KoreaIT.project.BAP.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.KoreaIT.project.BAP.vo.Company;

@Mapper
public interface CompanyRepository {
	
	@Select("""
			<script>
			SELECT c.*,
			p.fee AS extra__productFee,
			MIN(fee) AS extra__minFee
			FROM company AS c
			LEFT JOIN product AS p
			ON c.id = p.comp_id
			WHERE 1
			<if test="searchKeyword1 != ''">
				AND (
					c.name LIKE CONCAT('%', #{searchKeyword1}, '%')
					OR
					c.address LIKE CONCAT('%', #{searchKeyword1}, '%')
				)
			</if>
			<if test="searchKeyword2 != ''">
				AND (
					c.name LIKE CONCAT('%', #{searchKeyword2}, '%')
					OR
					c.address LIKE CONCAT('%', #{searchKeyword2}, '%')
				)
			</if>
			<if test="searchKeyword3 != ''">
				AND (
					c.name LIKE CONCAT('%', #{searchKeyword3}, '%')
					OR
					c.address LIKE CONCAT('%', #{searchKeyword3}, '%')
				)
			</if>
			<if test="searchKeyword4 != ''">
				AND (
					c.name LIKE CONCAT('%', #{searchKeyword4}, '%')
					OR
					c.address LIKE CONCAT('%', #{searchKeyword4}, '%')
				)
			</if>
			<if test="searchKeyword5 != ''">
				AND (
					c.name LIKE CONCAT('%', #{searchKeyword5}, '%')
					OR
					c.address LIKE CONCAT('%', #{searchKeyword5}, '%')
				)
			</if>
			<if test="searchKeyword6 != ''">
				AND (
					c.name LIKE CONCAT('%', #{searchKeyword6}, '%')
					OR
					c.address LIKE CONCAT('%', #{searchKeyword6}, '%')
				)
			</if>
			<if test="low_price != 1">
				AND p.fee <![CDATA[>=]]> #{low_price}
			</if>
			<if test="high_price != 999999999">
				AND p.fee <![CDATA[<=]]> #{high_price}
			</if>
			<if test="motelType != '' || hotelType != '' || pensionType != '' || guesthouseType != ''">
				AND (
				<if test="motelType != ''">
					c.accommodationType = 'motel'
				</if>
				<if test="hotelType != ''">
					<if test="motelType != ''">
					OR
					</if>
					c.accommodationType = 'hotel'
				</if>
				<if test="pensionType != ''">
					<if test="motelType != '' || hotelType != ''">
					OR
					</if>
					c.accommodationType = 'pension'
				</if>
				<if test="guesthouseType != ''">
					<if test="motelType != '' || hotelType != '' || pensionType != ''">
					OR
					</if>
					c.accommodationType = 'guesthouse'
				</if>
				)
			</if>
			GROUP BY c.id
			<if test="order_by == ''">
				ORDER BY extra__minFee ASC
			</if>
			<if test="order_by != ''">
				<choose>
					<when test="order_by == 'lowPrice'">
						ORDER BY extra__minFee ASC
					</when>
					<when test="order_by == 'highPrice'">
						ORDER BY extra__minFee DESC
					</when>
				</choose>
			</if>
			</script>
			""")
	List<Company> getForPrintCompanies(String searchKeyword1, String searchKeyword2, String searchKeyword3, String searchKeyword4, String searchKeyword5, String searchKeyword6,
			String order_by, String motelType, String hotelType, String pensionType, String guesthouseType, int low_price, int high_price);
	
	@Insert("""
			INSERT into company
			SET regDate = NOW(),
			updateDate = NOW(),
			`name` = #{name},
			cellphoneNo = #{cellphoneNo},
			address = #{address},
			area = #{area},
			timeChkin = #{timeChkin},
			timeChkout = #{timeChkout},
			accommodationType = #{accommodationType},
			host_id = #{host_id}
			""")
	void register(String name, String cellphoneNo, String address, String area, String timeChkin, String timeChkout, String accommodationType, int host_id);

	@Select("SELECT LAST_INSERT_ID()")
	int getLastInsertId();

	@Select("""
			SELECT *
				FROM company
				WHERE id = #{comp_id}
			""")
	Company getCompanyByComp_id(int comp_id);

	@Select("""
			<script>
			SELECT COUNT(c.id) AS cnt
			FROM (
			SELECT c.id, COUNT(c.id)
			FROM company AS c
			LEFT JOIN product AS p
			ON c.id = p.comp_id
			WHERE 1
			<if test="searchKeyword1 != ''">
				AND (
					c.name LIKE CONCAT('%', #{searchKeyword1}, '%')
					OR
					c.address LIKE CONCAT('%', #{searchKeyword1}, '%')
				)
			</if>
			<if test="searchKeyword2 != ''">
				AND (
					c.name LIKE CONCAT('%', #{searchKeyword2}, '%')
					OR
					c.address LIKE CONCAT('%', #{searchKeyword2}, '%')
				)
			</if>
			<if test="searchKeyword3 != ''">
				AND (
					c.name LIKE CONCAT('%', #{searchKeyword3}, '%')
					OR
					c.address LIKE CONCAT('%', #{searchKeyword3}, '%')
				)
			</if>
			<if test="searchKeyword4 != ''">
				AND (
					c.name LIKE CONCAT('%', #{searchKeyword4}, '%')
					OR
					c.address LIKE CONCAT('%', #{searchKeyword4}, '%')
				)
			</if>
			<if test="searchKeyword5 != ''">
				AND (
					c.name LIKE CONCAT('%', #{searchKeyword5}, '%')
					OR
					c.address LIKE CONCAT('%', #{searchKeyword5}, '%')
				)
			</if>
			<if test="searchKeyword6 != ''">
				AND (
					c.name LIKE CONCAT('%', #{searchKeyword6}, '%')
					OR
					c.address LIKE CONCAT('%', #{searchKeyword6}, '%')
				)
			</if>
			<if test="low_price != 1">
				AND p.fee <![CDATA[>=]]> #{low_price}
			</if>
			<if test="high_price != 999999999">
				AND p.fee <![CDATA[<=]]> #{high_price}
			</if>
			<if test="motelType != '' || hotelType != '' || pensionType != '' || guesthouseType != ''">
				AND
				<if test="motelType != ''">
					c.accommodationType = 'motel'
				</if>
				<if test="hotelType != ''">
					<if test="motelType != ''">
					OR
					</if>
					c.accommodationType = 'hotel'
				</if>
				<if test="pensionType != ''">
					<if test="motelType != '' || hotelType != ''">
					OR
					</if>
					c.accommodationType = 'pension'
				</if>
				<if test="guesthouseType != ''">
					<if test="motelType != '' || hotelType != '' || pensionType != ''">
					OR
					</if>
					c.accommodationType = 'guesthouse'
				</if>
			</if>
			GROUP BY c.id
			) AS c;
			</script>
			""")
	int getCompainesCount(String searchKeyword1, String searchKeyword2, String searchKeyword3, String searchKeyword4, String searchKeyword5, String searchKeyword6, 
			String motelType, String hotelType, String pensionType,	String guesthouseType, int low_price, int high_price);
	
	@Select("""
			<script>
			SELECT c.*,
			p.fee AS extra__productFee,
			MIN(fee) AS extra__minFee
			FROM company AS c
			LEFT JOIN product AS p
			ON c.id = p.comp_id
			WHERE c.accommodationType = 'hotel'
			<if test="area != ''">
				AND `area` = #{area}
			</if>
			<if test="low_price != 1">
				AND p.fee <![CDATA[>=]]> #{low_price}
			</if>
			<if test="high_price != 999999999">
				AND p.fee <![CDATA[<=]]> #{high_price}
			</if>
			GROUP BY c.id
			<if test="order_by == ''">
				ORDER BY extra__minFee ASC
			</if>
			<if test="order_by != ''">
				<choose>
					<when test="order_by == 'lowPrice'">
						ORDER BY extra__minFee ASC
					</when>
					<when test="order_by == 'highPrice'">
						ORDER BY extra__minFee DESC
					</when>
				</choose>
			</if>
			</script>
			""")
	List<Company> getForPrintHotels(String area, String order_by, int low_price, int high_price);

	@Select("""
			<script>
			SELECT COUNT(c.id) AS cnt
			FROM (
			SELECT c.id, COUNT(c.id)
			FROM company AS c
			LEFT JOIN product AS p
			ON c.id = p.comp_id
			WHERE c.accommodationType = 'hotel'
			<if test="area != ''">
				AND `area` = #{area}
			</if>
			<if test="low_price != 1">
				AND p.fee <![CDATA[>=]]> #{low_price}
			</if>
			<if test="high_price != 999999999">
				AND p.fee <![CDATA[<=]]> #{high_price}
			</if>
			GROUP BY c.id
			) AS c;
			</script>
			""")
	int getHotelsCount(String area, int low_price, int high_price);

	@Select("""
			SELECT *
			FROM company
			WHERE host_id = #{hostId}
			""")
	List<Company> getCompanyByHostId(int hostId);

}
