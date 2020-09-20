package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/voucher")
public class voucher extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public voucher() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String code = request.getParameter("voucherCode");
		if(code.equals("studentdiscount")) {
			HttpSession session = request.getSession();
			session.setAttribute("discount", "0.20");
		}
		response.sendRedirect("/092020_Apathon_-_internet_and_applications/cart");

	}

}
