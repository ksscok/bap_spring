package com.KoreaIT.project.BAP.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.KoreaIT.project.BAP.vo.Product;

@Mapper
public interface ProductRepository {

	@Select("""
			SELECT *
				FROM product AS P
				WHERE id = #{id}
			""")
	Product getForPrintproduct(int id);

	@Select("""
			<script>
			SELECT *
				FROM (
					SELECT id, includeMeals
						FROM product
					<if test="withoutMealsType != '' || withBreakfastType != '' || withDinnerType != '' || withBreakfastAndDinnerType != ''"> 
					WHERE
						<if test="withoutMealsType != ''"> 
							includeMeals = '식사불포함'
						</if> 
						<if test="withBreakfastType != ''"> 
							<if test="withoutMealsType != ''"> 
								OR
							</if> 
							includeMeals = '조식'
						</if> 
						<if test="withDinnerType != ''"> 
							<if test="withoutMealsType != '' or withBreakfastType != ''"> 
								OR
							</if> 
							includeMeals = '석식'
						</if> 
						<if test="withBreakfastAndDinnerType != ''"> 
							<if test="withoutMealsType != '' or withBreakfastType != '' or withDinnerType != ''"> 
								OR
							</if> 
							includeMeals = '조식, 석식'
						</if> 
					</if>
					) AS `PI`
				INNER JOIN product AS PC
				ON `PI`.id = PC.id
				WHERE 1 = 1
				AND PC.comp_id = #{comp_id}
				<if test="countOfRoom != '' and countOfRoom != 0">
					AND PC.countOfRoom = #{countOfRoom}
				</if>
				<if test="countOfAdult != '' and countOfAdult != 0">
					AND PC.countOfAdult = #{countOfAdult}
				</if>
				<if test="countOfChild != '' and countOfChild != 0">
					AND PC.countOfChild = #{countOfChild}
				</if>
				<if test="smokingType != ''">
					AND PC.smokingType = #{smokingType}
				</if>
				<if test="low_price != 1">
					AND PC.fee <![CDATA[>=]]> #{low_price}
				</if>
				<if test="high_price != 999999999">
					AND PC.fee <![CDATA[<=]]> #{high_price}
				</if>
				GROUP BY `PI`.id
			</script>
			""")
	List<Product> getProductsByCompanyId(int comp_id, String countOfRoom, String countOfAdult, String countOfChild, String withoutMealsType, String withBreakfastType, String withDinnerType, String withBreakfastAndDinnerType, String smokingType, int low_price, int high_price);

	
	
	@Insert("""
			INSERT into product
			SET regDate = NOW(),
			updateDate = NOW(),
			comp_id = #{comp_id},
			roomType = #{roomType},
			numberOfRooms = #{numberOfRooms},
			fee = #{fee},
			countOfRoom = #{countOfRoom},
			countOfAdult = #{countOfAdult},
			countOfChild = #{countOfChild},
			includeMeals = #{includeMeals},
			smokingType = #{smokingType}
			""")
	int register(int comp_id, String roomType, int numberOfRooms, int fee, String countOfRoom, String countOfAdult, String countOfChild,
			String includeMeals, String smokingType);
}
