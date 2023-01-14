package com.KoreaIT.project.BAP.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.KoreaIT.project.BAP.vo.Product;

@Mapper
public interface ProductRepository {

	@Select("""
			SELECT p.*,
					C.name AS comName, 
					C.address AS comAddr
				FROM product AS P
				INNER JOIN company AS C
				ON P.companyId = C.id
				WHERE P.companyId = #{companyId}
				GROUP BY P.companyId
			""")
	Product getForPrintproduct(int companyId);

	@Select("""
			SELECT *
				FROM product
				WHERE comp_id = #{comp_id}
			""")
	List<Product> getProductsByCompanyId(int comp_id);
}
