package org.zerock.controller.gwon;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.MemberVO;
import org.zerock.domain.SubscriberInfoVO;
import org.zerock.security.domain.CustomUser;
import org.zerock.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j 
@RequestMapping("/member")
@Controller
public class MyPageController {
 
	@Setter(onMethod_ = @Autowired)
	private MemberService service;

	@RequestMapping("/mypage")
	@PreAuthorize("isAuthenticated() and (!hasRole('ROLE_ADMIN'))")
	public void mypage(Model model, Principal principal) {
		log.info("메인페이지");

		MemberVO member = service.read(principal.getName());

		model.addAttribute("member", member);
	}

	@RequestMapping("/subinfo")
	@PreAuthorize("isAuthenticated()")
	public void subinfo() {
		log.info("구독정보 확인");
	}

	@RequestMapping("/myinfo")
	@PreAuthorize("isAuthenticated()")
	public void info(Model model, Principal principal) {

		log.info("내정보 확인 : " + principal.getName());

		MemberVO member = service.read(principal.getName());

		model.addAttribute("member", member);

	}

	@GetMapping("/exp")
	public String logout() {
		log.info("실험");

		return "";
	}

	@PostMapping("/modify")
	public String modify(MemberVO vo, RedirectAttributes rttr) {
		log.info("비밀번호:" + vo.getUserpw());

		service.modify(vo);

		return "redirect:/logout";
	}

	@PostMapping("/remove")
	public String remove(MemberVO vo) {
		log.info(vo.getUserid());

		service.remove(vo);

		return "redirect:/logout";
	}

	 
	/*
	 * @RequestMapping("/myget") public void myget( Model model, Principal
	 * principal) {
	 * 
	 * log.info("get : " + principal.getName());
	 * 
	 * MemberVO member = service.read(principal.getName());
	 * 
	 * model.addAttribute("member", member); }
	 */

	@RequestMapping("/myget")
	@PreAuthorize("isAuthenticated()")
	public void myget(Model model, Principal principal) {
		log.info("get");

		MemberVO member = service.read(principal.getName());

		model.addAttribute("member", member);
	}

	// mypage에서 내구독정보 불러오기
	@PostMapping(value = "/getsubsoptions", produces = "text/plain; charset=utf-8")
	@PreAuthorize("isAuthenticated()")
	@ResponseBody
	public String getSubsOptions(String userid) {

		String vo = service.getSubsOptions(userid);

		log.info(vo);

		return vo;
	}

}
