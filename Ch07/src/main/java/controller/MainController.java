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
import model.GreetingService;
import model.HelloService;
import model.WelcomeService;


public class MainController extends HttpServlet {
	// HttpServlet을 상속받은 클래스는 doGet()메소드를 오버라이딩할 수 있기 때문이 이클래스는
	// 서블릿으로 동작 할 수 있게 된다.
	
	// 최종패턴 JSP → MODEL → Controller → MODEL<db랑 연동함> → JSP -> clinet
	
	// 이건 굳이 없어도 됨 -- 직렬화에 관련된 것 -- 데이터 잘 받기 위한것 
	// default값 받아오는 것
	private static final long serialVersionUID = 1L;
	private Map<String, Object> instances = new HashMap<>();
	// /urlMapping.properties 이 파일에 있는 주소들을 키<주소>와 값<클래스-service>으로 받아오기 위한것

	@Override
	public void init(ServletConfig config) throws ServletException {
		
		// 서블릿이 곧 CONTROLLER이다 
		// 최초 요청시 실행되는 컨트롤러 초기화 메서드
		// 최초 접속하는 클라이언트에 의해 실행된다.(한 번 실행되면 서버가 종료 될 때까지 두 번 다시 실행하지 않음)
		System.out.println("MainController init 실행!!!");
		
		// 액션주소 프로퍼티 파일 경로 구하기
		ServletContext ctx = config.getServletContext();
		String path = ctx.getRealPath("/WEB-INF") + "/urlMapping.properties";
		
		// 프로퍼티 파일 입력스트림 연결 후 프로퍼티 객체 생성
		// 위 의 map을 받아서 나타내는 것이다
		Properties prop = new Properties();
		
		try {
			FileInputStream fis = new FileInputStream(path);
			// WEB-INF 여기 경로에 있는 파일을 받아와서 load시킨다
			prop.load(fis);
			fis.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		// 프로퍼티 객체로 서비스 객체 생성
		// Map안의 정보 집합체로 부터 정보를 얻어내기 위한것
		// 어떤 컬렉션(set,list,map)이라도 동일한 방식으로 접근이 가능하여 그 안에 있는 항목들에 접근
		// 할 수 있는 방법을 제공한다(다형성)
		// 종류는 hasNext(), next(), remove()가 잇다
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
	
	
	// servlet파일에서는 get메소드와 post방식을 둘다 받아올 것이기 때문에 두 개의 메소드를 전부 만들어준다
	// 웹브라우저의 요청을 get과 post 메서드가 받는다.
	// 둘 중에 들어오는 방식으로 골라서 처리하기 위해 두개를 다 구현 하여 준다
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
	
	
	protected void requestProc(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 요청주소에서 key 구하기
		String path = req.getContextPath();
		String uri  = req.getRequestURI();
		String key = uri.substring(path.length());
		
		// Map에서 Service 객체 꺼내기
		// 만들어놓은 service들을 하나로 묶어서 해결하는 것이 좋다 ,, 메모리 및 수 많은 클라이언트에서
		// 요청할때 new객체를 생성해야 하는 문제가 발생한다 - > 서버의 resource 자원의 문제가 생기고
		// 서버의 객체들의 효율성등의 문제가 생기기 때문에 구조적으로 미리 만들어 놓는 것이 좋다.
		CommonService instance = (CommonService) instances.get(key);
		// object는 최상위 클래스여서 임의적으로 수정이 불가능 한다.,,, object는 모는 클래스의 부모이다
		// CommonService도 object를 상속 받은것이다
		// interface을 우선적으로 이해해야한다 
		
		// Service 객체 실행 후 결과정보 받기
		// 각각 Service파일에서 리다이렉트를 해주기 때문에 result로 바뀜 원레는 view엿음
		
		String result = instance.requestProc(req, resp);
		
		if(result.startsWith("redirect:")) {
			// 리다이렉트 -- 이제controller에서 이게 추가 되면서 기능이 확장된다고 보면된다
			// String result = instance.requestProc(req, resp);여기에 리다이렉트가 도착하면 if문을 시작하자
			String redirecUrl = result.substring(9);
			// substring(9);숫자가 9인이유는 redirecet:/user/list.do 라는 주소에서 / 여기서 분터 출력하기 위해
			resp.sendRedirect(path+redirecUrl);
			
		}else {
			// 해당 View로 forward 하기
			// RequestDispatcher 클래스는 클아이언트로 부터 요청request를 받고 그것을 서버상의 다른 웹
			// 페이지로 보내는 작업을 할때 사용한다
			RequestDispatcher dispatcher = req.getRequestDispatcher(result);
			dispatcher.forward(req, resp);
			// forward는 서블릿에서 다른 웹페이지로 요청 전달한다
			// result된거를 forward하면 req안에 들어있는 정보가 view로 간다
		}
		
	}
	
}


















