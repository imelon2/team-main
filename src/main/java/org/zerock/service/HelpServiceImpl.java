package org.zerock.service;

import java.io.File;
import java.io.InputStream;
import java.nio.file.Path;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.AskFileVO;
import org.zerock.domain.HelpVO;
import org.zerock.domain.Pagenation;
import org.zerock.mapper.AskFileMapper;
import org.zerock.mapper.AskReplyMapper;
import org.zerock.mapper.HelpMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import software.amazon.awssdk.auth.credentials.ProfileCredentialsProvider;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.profiles.ProfileFile;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Log4j
@Service
public class HelpServiceImpl implements HelpService {
	
	private String bucketName;
	private String profileName;
	private S3Client s3;
	
	@Setter (onMethod_ = @Autowired)
	private HelpMapper mapper;
	
	@Setter (onMethod_ = @Autowired)
	private AskReplyMapper replyMapper;
	
	@Setter (onMethod_ = @Autowired)
	private org.zerock.mapper.AskFileMapper fileMapper;
	
	
	public HelpServiceImpl() {
		this.bucketName = "swteam1";
		this.profileName= "swteam1";
		
		/*  
		 * create
		 *  /home/tomcat/.aws/credentials
		 */
		
		Path contentLocation = new File(System.getProperty("user.home") + "/.aws/credentials").toPath();
		ProfileFile pf = ProfileFile.builder()
				.content(contentLocation)
				.type(ProfileFile.Type.CREDENTIALS)
				.build();
		ProfileCredentialsProvider pcp = ProfileCredentialsProvider.builder()
				.profileFile(pf)
				.profileName(profileName)
				.build();
		
		this.s3 = S3Client.builder()
				.credentialsProvider(pcp)
				.build();
	}
	
	//Dependency Injection
	@Setter(onMethod_ = @Autowired)
	private HelpMapper helpMapper;
	
	@Setter(onMethod_ = @Autowired)
	private AskFileMapper askFileMapper;
	
	
	@Override
	public void register(HelpVO help) {
		mapper.insertSelectkey(help);
		
	}
	
	@Override
	@Transactional
	public void register(HelpVO help, MultipartFile[] mfile) {
		register(help);
		
		for (MultipartFile file : mfile) {
			
			if(file != null && file.getSize() > 0) {
				
				AskFileVO vo = new AskFileVO();
				vo.setBno(help.getBno());
				vo.setFileName(file.getOriginalFilename());
				
				fileMapper.insert(vo);
				upload(help, file);
		}
		
		}
	}

	private void upload(HelpVO help, MultipartFile file){
		
		try(InputStream is = file.getInputStream()) {		
		PutObjectRequest objectRequeset = PutObjectRequest.builder()
				.bucket(bucketName)
				.key("help" + "/" + help.getBno() + "/" + file.getOriginalFilename())
				.contentType(file.getContentType())
				.acl(ObjectCannedACL.PUBLIC_READ)
				.build();
		
		s3.putObject(objectRequeset, RequestBody.fromInputStream(is, file.getSize()));
	} catch (Exception e) {
		throw new RuntimeException(e);
	}
		
	}

	@Override
	public HelpVO askGet(Long bno) {
		return mapper.read(bno);
	}

	@Override
	public boolean modify(HelpVO help) {
		return mapper.update(help) == 1;
	}
	
	@Override
	@Transactional
	public boolean modify(HelpVO help, MultipartFile[] mfile) {
	
		HelpVO oldBoard = mapper.read(help.getBno());
		removeFile(oldBoard);

		// tbl_board_file은 삭제 후 인서트
		fileMapper.deleteByBno(help.getBno());
		
		for (MultipartFile file : mfile) {
			if(file != null && file.getSize() > 0) {
				// s3는 삭제 후 재업로드
				upload(help, file);
				
				
				AskFileVO vo = new AskFileVO();
				vo.setBno(help.getBno());
				vo.setFileName(file.getOriginalFilename());
				fileMapper.insert(vo);
			}			
		}
		return modify(help);
	}
	
	
	/* 관리자 수정 관련 추가*/
	@Override
	public boolean AdminModify(HelpVO help) {
		return mapper.update(help) == 1;
	}
	
	@Override
	@Transactional
	public boolean AdminModify(HelpVO help, MultipartFile[] mfile) {
		HelpVO oldBoard = mapper.read(help.getBno());
		removeFile(oldBoard);

		// tbl_board_file은 삭제 후 인서트
		fileMapper.deleteByBno(help.getBno());
		
		for (MultipartFile file : mfile) {
			if(file != null && file.getSize() > 0) {
				// s3는 삭제 후 재업로드
				upload(help, file);
				
				
				AskFileVO vo = new AskFileVO();
				vo.setBno(help.getBno());
				vo.setFileName(file.getOriginalFilename());
				fileMapper.insert(vo);
			}			
		}
		return modify(help);
	}

	@Override
	@Transactional
	public boolean remove(Long bno) {
		//댓글 삭제
		replyMapper.deleteByBno(bno);
		
		//파일 삭제(s3)
		HelpVO vo = mapper.read(bno);
		removeFile(vo);

		//파일 삭제 (db)
		fileMapper.deleteByBno(bno);
		
		
		//게시물 삭제
		int cnt = mapper.delete(bno);
		
		return cnt == 1;
	}

	/*관리자 삭제 관련 추가*/
	@Override
	@Transactional
	public boolean AdminRemove(Long bno) {
		//댓글 삭제
		replyMapper.deleteByBno(bno);
		
		//파일 삭제(s3)
		HelpVO vo = mapper.read(bno);
		removeFile(vo);

		//파일 삭제 (db)
		fileMapper.deleteByBno(bno);
		
		
		//게시물 삭제
		int cnt = mapper.delete(bno);
		
		return cnt == 1;
	}
	
	private void removeFile(HelpVO vo) {
		//String buckeyName = "";
		for (String file : vo.getFileName()) {
			String key =  "help" + "/" + vo.getBno() + "/" + file;
			log.info(key);
			DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
					.bucket(bucketName)
					.key(key)
					.build();
			
			s3.deleteObject(deleteObjectRequest);
		}
		
		
	}
	
	
	

	@Override
	public List<HelpVO> getListUser(Pagenation pag) {
		return mapper.getListWithPagingUser(pag);
	}
	
@Override
	public List<HelpVO> getListAdmin(Pagenation pag) {
		
		return mapper.getListWithPagingAdmin(pag);
	}
	
	@Override
	public int getTotalUser(Pagenation pag) {
		return mapper.getTotalCountUser(pag);
	}
	
	@Override
	public int getTotalAdmin(Pagenation pag) {
		return mapper.getTotalCountAdmin(pag);
	}
}