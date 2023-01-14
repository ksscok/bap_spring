package com.KoreaIT.project.BAP.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.KoreaIT.project.BAP.vo.Rq;



@Component
public class NeedLoginInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {

		Rq rq = (Rq) req.getAttribute("rq");


		if ( !rq.isLogined() ) {
			String afterLoginUri = rq.getEncodedCurrentUri();
			rq.printReplaceJs("로그인 후 이용해주세요.", "../member/login?afterLoginUri=" + afterLoginUri);
			return false;
		}

		return HandlerInterceptor.super.preHandle(req, resp, handler);
	}
}
