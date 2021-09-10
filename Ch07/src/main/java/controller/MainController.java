package controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.CommonService;



public class MainController extends HttpServlet {
	

	private static final long serialVersionUID = 1L;
	private Map<String, Object> instances  = new HashMap<>();
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		
		System.out.println("MainController init 실행!!!!");
		
		// 액션 주소 프로퍼티 파일 경로 구하기 
		ServletContext ctx = config.getServletContext();
		String path = ctx.getRealPath("/WEB-INF") + "/urlMapping.properties";
		
		// 프로퍼티 파일 입력스트림 연결 후 프로퍼티 객체 생성 
		Properties prop = new Properties();
		
		try {
			FileInputStream fis = new FileInputStream(path);
			prop.load(fis);
			fis.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		Iterator iter = prop.keySet().iterator();
		
		while(iter.hasNext()) {
			// hsanext 다음 값이 있으면 true 반환 아니면 false
			// next는 다음 값의 유무와 관계없이 true값 가져오기 -- break 써주기 
			// remove는 next로 읽어온 요소를 삭제
			// 메소드 호출순서는 hasNext()-> next()-> remove()이다
			
			String k = iter.next().toString();
			String v = prop.getProperty(k);
			// v는 문자열이다 
			
			try {
				
				Class obj = Class.forName(v);
				Object instance = obj.newInstance();
				
				instances.put(k, instance);
				
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
	} // init end...
		
		
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		requestProc(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		requestProc(req, resp);
	}
	
	protected void requestProc(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		// 요청 주소에서 key구하기 
		String path = req.getContextPath();
		String uri  = req.getRequestURI();
		String key  = uri.substring(path.length());
		
		CommonService instance = (CommonService) instances.get(key);
		
		String result = instance.requestProc(req, resp);
		
		if(result.startsWith("redirect:")) {
			String redirecUrl = result.substring(9);
			resp.sendRedirect(path+redirecUrl);
		}else {
			
			RequestDispatcher dispatcher = req.getRequestDispatcher(result);
			dispatcher.forward(req, resp);
		}
		
		
	}	
}
