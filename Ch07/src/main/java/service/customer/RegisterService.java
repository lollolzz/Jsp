package service.customer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CustomerDao;
import model.CommonService;
import vo.CustomerVo;

public class RegisterService implements CommonService {

	@Override
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		
		if(req.getMethod().equals("GET")) {
			return "/customer/register.jsp";
		}else {
			
			String name = req.getParameter("name");
			String address = req.getParameter("address");
			String phone = req.getParameter("phone");
			
			CustomerVo vo = new CustomerVo();
			vo.setName(name);
			vo.setAddress(address);
			vo.setPhone(phone);
			
			CustomerDao.getInstance().insertCustomer(vo);
			
			return "redirect:/customer/list.do";
		}
		
	}
}
