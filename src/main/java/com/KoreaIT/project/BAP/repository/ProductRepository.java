package com.KoreaIT.project.BAP.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.KoreaIT.project.BAP.vo.Product;

@Mapper
public interface ProductRepository {

	@Select("""
			SELECT p.*,
					c.name AS comName, 
					c.address AS comAddr
				FROM product AS p
				INNER JOIN company AS c
				ON p.companyId = c.id
				WHERE p.companyId = #{companyId}
				GROUP BY p.companyId
			""")
	Product getForPrintproduct(int companyId);

	@Select("""
			SELECT *
				FROM product
				WHERE companyId = #{companyId}
			""")
	List<Product> getProductsByCompanyId(int companyId);
}
