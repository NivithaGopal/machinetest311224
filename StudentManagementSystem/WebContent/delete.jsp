<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, dbconnection.dbconnection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Record</title>
</head>
<body>
<%
    String id = request.getParameter("id");
    if (id == null || id.trim().isEmpty()) {
        out.println("<script>alert('Invalid ID.'); window.location.href='index.jsp';</script>");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        dbconnection dbConn = new dbconnection();
        conn = dbConn.getConnection();

        String sql = "DELETE FROM students WHERE id = ?"; 
        ps = conn.prepareStatement(sql);
        ps.setInt(1, Integer.parseInt(id));

        int rowsDeleted = ps.executeUpdate();

        if (rowsDeleted > 0) {
            out.println("<script>alert('Record deleted successfully!'); window.location.href='index.jsp';</script>");
        } else {
            out.println("<script>alert('Failed to delete record.'); window.location.href='index.jsp';</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('An error occurred: " + e.getMessage() + "'); window.location.href='index.jsp';</script>");
    } finally {
        if (ps != null) try { ps.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>
</body>
</html>
