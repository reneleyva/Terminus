/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import controlador.Usuario;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.ArrayList;
 
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileItemFactory;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
 
/**
 * Servlet implementation class Uploader
 */
@WebServlet("/Uploader")
public class Uploader extends HttpServlet {
  
 @Override
 protected void doPost(HttpServletRequest request, HttpServletResponse response) 
throws ServletException, IOException {
     
 
  PrintWriter out = response.getWriter();
  
 
  if(!ServletFileUpload.isMultipartContent(request)){
        out.println("<script type=\"text/javascript\">");
     out.println("alert('Solo se porta imagenes en PNG');");
     out.println("location='./editarPerfil.jsp';");
     out.println("</script>");
   return; 
  }
  
  FileItemFactory itemfactory = new DiskFileItemFactory(); 
  ServletFileUpload upload = new ServletFileUpload(itemfactory);
  String idUsuario = "";
  try{
   List<FileItem>  items = upload.parseRequest(request);
   
   for( FileItem uploadItem : items )
    {
      if( uploadItem.isFormField() )
      {
        String fieldName = uploadItem.getFieldName();
        idUsuario = uploadItem.getString();
        
      }
    }
    
   //Busca el usuario con ese id 
   Usuario user = new Usuario();
   ArrayList usuarios = new ArrayList();
   user.conecta();
   usuarios = user.getUsuarios();
   user.desconecta();
   
   for (Object o : usuarios) {
       Usuario current = (Usuario) o;
       if (current.getIdusuario() == Integer.parseInt(idUsuario)) {
           user = current;
       }
   }
   /**/
   for(FileItem item:items) {
     
    String contentType = item.getContentType();
    
    if(!contentType.equals("image/jpeg")){
     out.println("<script type=\"text/javascript\">");
     out.println("alert('Solo se porta imagenes en JPG');");
     out.println("location='./editarPerfil.jsp';");
     out.println("</script>");
     
     continue;
    }
    //Aqui la carpeta donde se guardan las imagenes, cambiar por favor.
    File uploadDir = new File("C:\\Users\\ReneGL\\Documents\\NetBeansProjects\\Maps\\web\\resources\\img");
    File file = File.createTempFile("img", ".jpg", uploadDir);
    System.out.println(file.getPath());
    String[] path = file.getPath().split("web");
    System.out.println("ETSPPPP: " + path[1]);
    
    user.conecta();
    user.actualizaPerfil(Integer.parseInt(idUsuario), path[1]);
    user.desconecta();
    item.write(file);
 
    out.println("<script type=\"text/javascript\">");
    
    out.println("location='./editarPerfil.jsp';");
    out.println("</script>");
   }
  }
  catch(FileUploadException e){
    
   out.println("upload fail");
  }
  catch(Exception ex){
    
   out.println("can't save");
  }
 }
}
