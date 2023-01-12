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
			<if test="searchKeyword != ''">
				AND (
					c.name LIKE CONCAT('%', #{searchKeyword}, '%')
					OR
					c.address LIKE CONCAT('%', #{searchKeyword}, '%')
				)
			</if>
			<if test="low_price != 1">
				AND p.fee <![CDATA[>=]]> #{low_price}
			</if>
			<if test="high_price != 999999999">
				AND p.fee <![CDATA[<=]]> #{high_price}
			</if>
			<if test="motelType != '' || hotelType != '' || pensionType != '' || geusthouseType != ''">
				AND
				<if test="motelType != ''">
					c.accommodationType = '모텔'
				</if>
				<if test="hotelType != ''">
					<if test="motelType != ''">
					OR
					</if>
					c.accommodationType = '호텔'
				</if>
				<if test="pensionType != ''">
					<if test="motelType != '' || hotelType != ''">
					OR
					</if>
					c.accommodationType = '펜션'
				</if>
				<if test="geusthouseType != ''">
					<if test="motelType != '' || hotelType != '' || pensionType != ''">
					OR
					</if>
					c.accommodationType = '게스트하우스'
				</if>
			</if>
			GROUP BY c.id
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
	List<Company> getForPrintCompanies(String searchKeyword, String order_by, String motelType, String hotelType, String pensionType, String geusthouseType, int low_price, int high_price);

	@Insert("""
			INSERT into company
			SET regDate = NOW(),
			updateDate = NOW(),
			`name` = #{name},
			address = #{address},
			accommodationType = #{accommodationType},
			host_id = #{host_id}
			""")
	void register(String name, String address, String accommodationType, int host_id);

	@Select("SELECT LAST_INSERT_ID()")
	int getLastInsertId();

}
