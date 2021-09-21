package kr.co.jboard2.service.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import kr.co.jboard2.dao.MemberDao;
import kr.co.jboard2.service.CommonService;

public class CheckEamilService implements CommonService {

	@Override
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		
		String email= req.getParameter("email");
		
		int result = MemberDao.getInstance().selectCountUserInfo(3, email);
		
		// json 데이터 생성 
		JsonObject json = new JsonObject();
		json.addProperty("result", result);
		
		
		// json 데이터 문자열 출력
		// json데이터라는 것을 controller에 알려주면 컨트롤러가 두번째 분기를 실행
		return "json:"+json.toString();
		// return 값은 controller로 간다 -> service 객체 실행 후 결과 정보받기로 이동
		// controller로 간 json데이터가 regiser.jsp페이지에 fuction(data)로 간다
		// 서비스에서 컨트롤러로 갈때 문자열 이고 컨트롤러에서 jsp페이지로 갈때는 json객체로 넘겨준다
	
	}
}

