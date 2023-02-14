package com.KoreaIT.project.BAP;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
// 애플리케이션 서버 실행 시 자동 스케줄링 실행 설정
@EnableScheduling
public class BapSpringApplication {

	public static void main(String[] args) {
		SpringApplication.run(BapSpringApplication.class, args);
	}

}
