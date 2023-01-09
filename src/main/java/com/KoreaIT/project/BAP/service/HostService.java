package com.KoreaIT.project.BAP.service;

import org.springframework.stereotype.Service;

import com.KoreaIT.project.BAP.repository.HostRepository;

@Service
public class HostService {
	
	HostRepository hostRepository;
	
	HostService(HostRepository hostRepository) {
		this.hostRepository = hostRepository;
	}
	
}
