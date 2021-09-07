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
	// HttpServlet을 상속받은 클래스는 doGet(),doPoset() 메소드를 오버라이딩할 수 있기 때문에 이 클래스는
	// 서블릿으로 동작 할 수 있게 된다.
	// 최종 패턴 jsp -> model -> controller  -> model -> jsp
	
	private static final long serialVersionUID = 1L;
	// serialVersionUID -- 직렬화와 역직열화 할때 사용하는 것이며 속도 및 보안 문제 해결 목적으로 사용 
	// - 직렬화는 ObjectOutputStream
	// - 역직렬화는 ObjectInputStream
	// 명시적으로 선언해주는것을 권유한다
	// private로 쓰는 것이 좋다 
	// 1L -- JVM에서 자동으로 UID를 생성하란 뜻 
	private Map<String, Object> instances = new HashMap<>();
	// HashMap은 map인터페이스를 구현한 대표적인 map컬렉션
	// map은 키와 값을 가지며 키는 중복될 수 없다 
	// 키값은 컬렉션  내에 유일한 키이어야하고 값은 여러개가 있어도 상관없
	// 많은 양의 데이터를 처리하는것에 유리 
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		// 서블릿이 곧 controller이다.
		// 최초 요청시 실행되는 컨트롤러 초기화 메서드 
		// 최초 접속하는 클라이언트에 의해 실행된다.( 한 번 실행되면 서버가 종료 될 때까지 두 번 다시 실행하지 않음)
		System.out.println("MainController init 실행!!");
		
		//액션주소 프로퍼티 파일 경로 구하기
		ServletContext ctx = config.getServletContext();
		String path = ctx.getRealPath("/WEB-INF") + "/urlMapping.properties";
		
		// 프로퍼티 파일 입력스트림 연결 후 프로퍼티 객체 생성 
		 Properties prop = new Properties();
		 
		 try {
			 FileInputStream fis = new FileInputStream(path);
			 prop.load(fis);
			 fis.close();
			 
		 }catch (Exception e) {
			 e.printStackTrace();
		 }
		 
		 // 프로퍼티 객체로 서비스 객체 생성 
		 Iterator iter = prop.keySet().iterator();
		 
		 while(iter.hasNext()) {
			 String k = iter.next().toString();
			 String v = prop.getProperty(k);
			 
			 try {
				 
				 Class obj = Class.forName(v);
				 Object instance = obj.newInstance();
				 
				 instances.put(k, instance);
				 
				 
			 }catch(Exception e) {
				 e.printStackTrace();
			 }
		 }
	}// init end....
	
	// servlet파일에서는 get메서드와 post방식을 둘다 받아올 것이기 때문에 두 개의 메소드를 전부 만들어준다. 
	// 웹브라우저의 요청을 get과 post 메서드가 받는다.
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// HttpServletRequest, HttpServletResponse 두 메서드는 각각jsp의 request, response기본 객체와 동일하다
		// 오버라이딩한 메서드에서는 requset를 이용해서 웹 브라우저의 요청 정보를 읽어 오던가.,,, response를 이용해서 응답을 전송할 수 있다.
		requestProc(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		requestProc(req, resp);
	}
	
	protected void requestProc(HttpServletRequest req, HttpServletResponse resp) throws  ServletException, IOException {
		// 요청 주소에서 key 구하기 
		String path = req.getContextPath();
		String uri = req.getRequestURI();
		String key = uri.substring(path.length());
		
		// Map에서 Service 객체 꺼내기
		// 만들어놓은 service들을 하나로 묶어서 해결하는 것이 좋다,, 메모리 및 수많은 클라이언트에서
		// 요청할 때 new객체를 생성해야 하는 문제가 발생한다 -> 서버의 resource 자원의 문제가 생기고 
		// 서버의 객체들의 효율성등의 문제가 생기기 때문에 구조적으로 미리 만들어 놓은 것이 좋다. 
		
		CommonService instance = (CommonService) instances.get(key);
		
		// Service 객체를 실행 후 view정보 받기 
		String view = instance.requestProc(req, resp);
		
		// 해당 view로 forward하기 
		// RequestDispatcher 클래스는 클라이언트로 부터 요청 request를 받고 그것을 서버상의 다른 웹
		// 페이지로 보내는 작업을 할때 사용한다.
		RequestDispatcher dispathcher = req.getRequestDispatcher(view);
		dispathcher.forward(req, resp);
		// forward는 서블릿에서 다른 웹페이지로 요청 전달한다. 
	}

}
