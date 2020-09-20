package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/add_product")
public class add_product extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public add_product() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}
	
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String product_id = request.getParameter("product_id");	
        ArrayList<String> products = null;
        if(session.getAttribute("products") == null){
        	products = new ArrayList<>();
        	session.setAttribute("products", products);
        }
        else {
        	products = (ArrayList<String>)session.getAttribute("products");
        }
		products.add(product_id);
		response.sendRedirect("/092020_Apathon_-_internet_and_applications/products");
		
	}

}
