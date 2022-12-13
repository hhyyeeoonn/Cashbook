package dao;

public class test {

	/*
	SELECT * 
	FROM cash
	WHERE member_id = 'goodee';
	
	SELECT COUNT(*), SUM(cash_price), AVG(cash_price) 
	FROM cash  
	WHERE member_id = 'goodee';
	
	
	# 수입 지출을 구분할 수 없다 -> category join이 필요하다
	SELECT cs.*, cg.* 
	FROM cash cs
			INNER JOIN category cg 
			ON cs.category_no = cg.category_no
	WHERE member_id = 'goodee';
	
	SELECT cg.category_kind, COUNT(*), SUM(cs.cash_price), AVG(cs.cash_price)
	FROM cash cs
		INNER JOIN category cg ON cs.category_no = cg.category_no
		WHERE member_id = 'goodee'
	GROUP BY cg.category_kind;
					
	SELECT YEAR(cs.cash_date), COUNT(*), SUM(cs.cash_price), AVG(cs.cash_price)
	FROM cash cs
		INNER JOIN category cg ON cs.category_no = cg.category_no
		WHERE member_id = 'goodee'
	GROUP BY YEAR(cs.cash_date)
	ORDER BY YEAR(cs.cash_date) ASC;
	
	# 연도 + 수입, 지출 GROUOP BY
	SELECT YEAR(cs.cash_date), cg.category_kind, COUNT(*), SUM(cs.cash_price), AVG(cs.cash_price)
	FROM cash cs
		INNER JOIN category cg ON cs.category_no = cg.category_no
		WHERE member_id = 'goodee'
	GROUP BY YEAR(cs.cash_date), cg.category_kind
	ORDER BY YEAR(cs.cash_date) ASC;
	
	# 피벗 테이블 형태...수입과 지출을 구분하여 다른 컬럼에 출력
	SELECT *
	FROM
		(SELECT cs.cash_no cashNo
				, cs.cash_date cashDate
				, cs.cash_price cashPrice
				, cg.category_kind categoryKind 
		FROM cash cs 
		INNER JOIN category cg 
		ON cs.category_no = cg.category_no
		WHERE cs.member_id = 'goodee') t;
		
	SELECT memberId, cashNo, cashDate
			, IF(category_kind = '수입', cashPrice, NULL) importCash
			, IF(category_kind = '지출', cashPrice, NULL) exportCash
	FROM (SELECT cs.cash_no cashNo
				, cs.cash_date cashDate
				, cs.cash_price cashPrice
				, cg.category_kind categoryKind 
				, cs.member_id memberId
		FROM cash cs 
		INNER JOIN category cg 
		ON cs.category_no = cg.category_no) t
	WHERE cs.member_id = 'goodee';
	
	# 연도별 그룹핑
	SELECT YEAR(t2.cashDate) 연도 # 월별카운트도 추가...
			, COUNT(t2.importCash) 수입
			, IFNULL(SUM(t2.importCash), 0) 수입합계
			, IFNULL(AVG(t2.importCash), 0) 수입평균
			, COUNT(t2.exportCash) 지출카운트
			, IFNULL(SUM(t2.exportCash), 0) 지출합계
			, IFNULL(ROUND(AVG(t2.exportCash)), 0) 지출평균# 평균은 ROUND()해서 반올림
	FROM 
		(SELECT 
				memberId
				, cashNo
				, cashDate
				, IF(categoryKind = '수입', cashPrice, NULL) importCash
				, IF(categoryKind = '지출', cashPrice, NULL) exportCash
	FROM (SELECT cs.cash_no cashNo
					, cs.cash_date cashDate
					, cs.cash_price cashPrice
					, cg.category_kind categoryKind 
					, cs.member_id memberId
			FROM cash cs 
			INNER JOIN category cg 
			ON cs.category_no = cg.category_no) t) t2
	WHERE t2.memberId = 'goodee'
	GROUP BY YEAR(t2.cashDate), MONTH(t2.cashDate)
	ORDER BY YEAR(t2.cashDate) DESC, MONTH(t2.cashDate) DESC; # 최근데이터를 먼저 자바 기본타입은 null이 들어올 수 없다 
	# null값은 자바에서 오류를 일으킬 수 있음 null값을 자바에서 처리하는 것보다 쿼리에서 0으로 처리하는 과정을 거치는 것이...
	
	# 연도(페이징)를 매개값으로 입력받아 월별
	SELECT YEAR(t2.cashDate) 연도 # 월별카운트도 추가...
			, COUNT(t2.importCash) 수입
			, IFNULL(SUM(t2.importCash), 0) 수입합계
			, IFNULL(AVG(t2.importCash), 0) 수입평균
			, COUNT(t2.exportCash) 지출카운트
			, IFNULL(SUM(t2.exportCash), 0) 지출합계
			, IFNULL(ROUND(AVG(t2.exportCash)), 0) 지출평균# 평균은 ROUND()해서 반올림
	FROM 
		(SELECT 
				memberId
				, cashNo
				, cashDate
				, IF(categoryKind = '수입', cashPrice, NULL) importCash
				, IF(categoryKind = '지출', cashPrice, NULL) exportCash
	FROM (SELECT cs.cash_no cashNo
					, cs.cash_date cashDate
					, cs.cash_price cashPrice
					, cg.category_kind categoryKind 
					, cs.member_id memberId
			FROM cash cs 
			INNER JOIN category cg 
			ON cs.category_no = cg.category_no) t) t2
	WHERE t2.memberId = 'goodee'
	GROUP BY YEAR(t2.cashDate), MONTH(t2.cashDate)
	ORDER BY YEAR(t2.cashDate) DESC, MONTH(t2.cashDate) DESC;
	 */
	
	
	/*
	
	SELECT *
	FROM cash
	WHERE member_id = 'goodee';
	
	
	SELECT COUNT(*), SUM(cash_price), AVG(cash_price)
	FROM cash c 
	WHERE member_id = 'goodee';
	/수입, 지출을 구분할 수 없다 -> category 조인이 필요 
	SELECT cs.*, cg.*
	FROM cash cs 
		INNER JOIN category cg ON cs.category_no = cg.category_no
	WHERE member_id = 'goodee';
	
	SELECT cg.category_kind, COUNT(*), SUM(cs.cash_price), AVG(cs.cash_price)
	FROM cash cs 
		INNER JOIN category cg ON cs.category_no = cg.category_no
	WHERE member_id = 'goodee'
	GROUP BY cg.category_kind;
	
	SELECT YEAR(cs.cash_date), COUNT(*), SUM(cs.cash_price), AVG(cs.cash_price)
	FROM cash cs 
		INNER JOIN category cg ON cs.category_no = cg.category_no
	WHERE member_id = 'goodee'
	GROUP BY YEAR(cs.cash_date) ASC;
	
	/ 년도 + 수입,지출 그룹바이 
	SELECT YEAR(cs.cash_date), cg.category_kind, COUNT(*), SUM(cs.cash_price), AVG(cs.cash_price)
	FROM cash cs 
		INNER JOIN category cg ON cs.category_no = cg.category_no
	WHERE member_id = 'goodee'
	GROUP BY YEAR(cs.cash_date), cg.category_kind
	ORDER BY YEAR(cs.cash_date) ASC;
	
	/피벗 테이블 형태로 .... 수입과 지출을 구분하여 다른 컬럼에 출력 
	
	SELECT *
	FROM (SELECT cs.cash_no cashNo
					, cs.cash_date cashDate
					, cs.cash_price cashPrice
					, cg.category_kind categoryKind
			FROM cash cs 
			INNER JOIN category cg ON cs.category_no = cg.category_no
			WHERE cs.member_id = 'goodee') t;
	
	SELECT memberId, cashNo, cashDate
			, IF(categoryKind = '수입', cashPrice, NULL) importCash
			, IF(categoryKind = '지출', cashPrice, NULL) exportCash
	FROM (SELECT cs.cash_no cashNo
					, cs.cash_date cashDate
					, cs.cash_price cashPrice
					, cg.category_kind categoryKind
					, cs.member_id memberId
			FROM cash cs 
			INNER JOIN category cg ON cs.category_no = cg.category_no) t;
	
	/년도별 월별 그룹핑 
	SELECT YEAR(t2.cashDate) 년, MONTH(t2.cashDate) 월
			, COUNT(t2.importCash) 수입카운트
			, SUM(t2.importCash) 수입합계
			, ROUND(AVG(t2.importCash)) 수입평균
			, COUNT(t2.exportCash) 지출카운트
			, SUM(t2.exportCash) 지출합계
			, ROUND(AVG(t2.exportCash)) 지출평균
	FROM
		(SELECT 
				memberId
				, cashNo
				, cashDate
				, IF(categoryKind = '수입', cashPrice, null) importCash
				, IF(categoryKind = '지출', cashPrice, null) exportCash
		FROM (SELECT cs.cash_no cashNo
						, cs.cash_date cashDate
						, cs.cash_price cashPrice
						, cg.category_kind categoryKind
						, cs.member_id memberId
				FROM cash cs 
				INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2
	WHERE t2.memberId = 'goodee'
	GROUP BY YEAR(t2.cashDate), MONTH(t2.cashDate)
	ORDER BY YEAR(t2.cashDate) DESC, MONTH(t2.cashDate) DESC; /최근데이터를 먼저

	
	------------------------------------------------------------------------------
	1) 사용자별 년도별 수입/지출 sum,avg


		SELECT 
				YEAR(t2.cashDate) 년
				, COUNT(t2.importCash) 수입카운트
				, IFNULL(SUM(t2.importCash), 0) 수입합계
				, IFNULL(ROUND(AVG(t2.importCash)), 0) 수입평균
				, COUNT(t2.exportCash) 지출카운트
				, IFNULL(SUM(t2.exportCash), 0) 지출합계
				, IFNULL(ROUND(AVG(t2.exportCash)), 0) 지출평균
		FROM
			(SELECT 
					memberId
					, cashNo
					, cashDate
					, IF(categoryKind = '수입', cashPrice, null) importCash
					, IF(categoryKind = '지출', cashPrice, null) exportCash
			FROM (SELECT cs.cash_no cashNo
							, cs.cash_date cashDate
							, cs.cash_price cashPrice
							, cg.category_kind categoryKind
							, cs.member_id memberId
					FROM cash cs 
					INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2
		WHERE t2.memberId = 'goodee'
		GROUP BY YEAR(t2.cashDate)
		ORDER BY YEAR(t2.cashDate) ASC;
		
		
			2) 사용자별 년도를(페이징) 매개값으로 입력받아 월별(수입/지출) sum,avg
		
		SELECT 
				MONTH(t2.cashDate)
				, COUNT(t2.importCash) 수입카운트
				, IFNULL(SUM(t2.importCash), 0) 수입합계
				, IFNULL(ROUND(AVG(t2.importCash)), 0) 수입평균
				, COUNT(t2.exportCash) 지출카운트
				, IFNULL(SUM(t2.exportCash), 0) 지출합계
				, IFNULL(ROUND(AVG(t2.exportCash)), 0) 지출평균
		FROM
			(SELECT 
					memberId
					, cashNo
					, cashDate
					, IF(categoryKind = '수입', cashPrice, null) importCash
					, IF(categoryKind = '지출', cashPrice, null) exportCash
			FROM (SELECT cs.cash_no cashNo
							, cs.cash_date cashDate
							, cs.cash_price cashPrice
							, cg.category_kind categoryKind
							, cs.member_id memberId
					FROM cash cs 
					INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2
		WHERE t2.memberId = 'goodee' AND YEAR(t2.cashDate) = 2022
		GROUP BY MONTH(t2.cashDate)
		ORDER BY MONTH(t2.cashDate) ASC;

	 */
}
