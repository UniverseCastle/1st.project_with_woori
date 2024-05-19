<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.File" %>
<%@ page import="project.bean.contact.VendorQnaDAO" %>
<jsp:useBean id="dto" class="project.bean.contact.VendorQnaDTO"/>
<jsp:setProperty property="*" name="dto"/>
<%
	
	int snum = (int) session.getAttribute("snum");
	
	
	String pageNum = request.getParameter("pageNum");
	
	String filePath = request.getRealPath("views/upload");
	int max = 1024*1024*5;
	String enc = "UTF-8";
	
	
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr 
	= new MultipartRequest(request, filePath, max, enc, dp);


	int member_num = Integer.parseInt(mr.getParameter("member_num")); 
	String title = mr.getParameter("title");
	String img = mr.getFilesystemName("img");
	String password = mr.getParameter("password");
	String question = mr.getParameter("question");
	int num = Integer.parseInt(mr.getParameter("num"));
	String secret_yn = mr.getParameter("secret_yn");
	String delete_yn = mr.getParameter("delete_yn");
	String business_name = mr.getParameter("business_name");
	String vendor = mr.getParameter("vendor");
	
	dto.setMember_num(member_num);
	dto.setTitle(title);
	dto.setImg(img);
	dto.setPassword(password);
	dto.setQuestion(question);
	dto.setVendor_qna_num(num);
	dto.setSecret_yn(secret_yn);
	dto.setDelete_yn(delete_yn);
	dto.setBusiness_name(business_name);
	dto.setVendor(vendor);

	VendorQnaDAO dao = VendorQnaDAO.getInstance();
	int result = dao.vendorQnaUpdatePro(dto,num);
	if(result == 1){%>
	<script>
		alert("글이 수정되었습니다.");
		window.location="vendorQnaList.jsp?pageNum=<%=pageNum%>";
	</script>
<%	}else{%>
	<script>
		alert("비밀번호가 맞지 않습니다.");
		history.go(-1);
	</script>
<%	} %>
	