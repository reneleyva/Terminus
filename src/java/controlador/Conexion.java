/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author Xavier
 */
public class Conexion {
    private Connection con;
    private Statement stmt;
    private ResultSet rs;
    
    
    public Conexion() {
        con = null;
        stmt = null;
        rs = null;
    }

    public void conectar() throws Exception{
        String driver = "org.postgresql.Driver";
        String dir = "jdbc:postgresql://localhost:5432/RideCiencias";
        //String dir = "jdbc:oracle:thin:@localhost:5432:RideCiencias";
        String user = "postgres";
        String password = "Rene8523";
        try{
            Class.forName(driver);
            con = DriverManager.getConnection(dir, user, password);
        } catch(ClassNotFoundException | SQLException ex){
            System.out.println("SQLException! desde conectar: " + ex.getMessage());   
        }        
    }
    
    public void desconectar() throws Exception{
        try{
            con.close();
        }catch(Exception ex){
            System.out.println("SQLException: " + ex.getMessage());
        }
    }
    
    //Empieza modificacion de datos
        public ArrayList getUsuarios() throws Exception {
            ArrayList usuarios = new ArrayList();
            try{
                stmt = con.createStatement();
                rs = stmt.executeQuery("select idusuario, correo, nombre, apellido,passwrd,perfil from usuario");
                while(rs.next()){
                    Usuario p = new Usuario();
                    p.setIdusuario(rs.getInt(1));
                    p.setCorreo(rs.getString(2));
                    p.setNombre(rs.getString(3));
                    p.setApellido(rs.getString(4));
                    p.setPassword(rs.getString(5));
                    p.setPerfil(rs.getString(6));
                    usuarios.add(p);
                }
            } catch(Exception ex) {
                System.out.println("SQLException!! desde conexion: " + ex.getMessage());
            }
            return usuarios;
        }
        
    public ArrayList getViajes() throws Exception {
            ArrayList usuarios = new ArrayList();
            try{
                stmt = con.createStatement();
                rs = stmt.executeQuery("select * from viaje");
                while(rs.next()){
                    Viaje p = new Viaje();
                    p.setIdRuta(rs.getInt(1));
                    p.setIdUsuario(rs.getInt(2));
                    p.setCalificado(rs.getString(3).charAt(0));
                    usuarios.add(p);
                }
            } catch(Exception ex) {
                System.out.println("SQLException!! desde conexion: " + ex.getMessage());
            }
            return usuarios;
    } 
    
    public ArrayList getCalificaciones() throws Exception {
            ArrayList usuarios = new ArrayList();
            try{
                stmt = con.createStatement();
                rs = stmt.executeQuery("select * from Calificacion");
                while(rs.next()){
                    Calificacion p = new Calificacion();
                    p.setId(rs.getInt(1));
                    p.setIdUsuario(rs.getInt(2));
                    p.setCalificacion(rs.getDouble(3));
                    usuarios.add(p);
                }
            } catch(Exception ex) {
                System.out.println("SQLException!! desde conexion: " + ex.getMessage());
            }
            return usuarios;
    } 
    
     public ArrayList getRutas() throws Exception {
            ArrayList rutas = new ArrayList();
            try{
                stmt = con.createStatement();
                rs = stmt.executeQuery("select * from ruta");
                while(rs.next()){
                    Ruta p = new Ruta();
                    p.setId(rs.getInt(1));
                    p.setDestino(rs.getString(2));
                    p.setFecha(rs.getString(3));
                    p.setHora(rs.getString(4));
                    p.setCupo(rs.getInt(5));
                    p.setIdUsuario(rs.getInt(6));
                    p.setSalida(rs.getString(7));
                    p.setPrecio(rs.getInt(8));
                    p.setDestino_dir(rs.getString(9));
                    p.setSalida_dir(rs.getString(10));
                    rutas.add(p);
                }
            } catch(Exception ex) {
                System.out.println("SQLException!! desde conexion: " + ex.getMessage());
            }
            return rutas;
    } 
    
    public ArrayList getNotificaciones() throws Exception {
            ArrayList not = new ArrayList();
            try{
                stmt = con.createStatement();
                rs = stmt.executeQuery("select * from Notificacion");
                while(rs.next()){
                    Notificacion n = new Notificacion();
                    n.setId(rs.getInt(1));
                    n.setIdUsuario(rs.getInt(2));
                    n.setMensaje(rs.getString(3));
                    n.setFecha(rs.getString(4));
                    n.setVisto(rs.getString(5).charAt(0));
                    not.add(n);
                }
            } catch(Exception ex) {
                System.out.println("SQLException!! desde conexion: " + ex.getMessage());
            }
            return not;
    } 
    /*public ArrayList getRutas() throws Exception {
        ArrayList rutas = new ArrayList();
        try{
            stmt = con.createStatement();
            rs = stmt.executeQuery("SELECT idruta, destino, fecha, hora, cupo, idusuario FROM ruta");
            while(rs.next()){
                Ruta p = new Ruta();
                p.setIdruta(rs.getInt(1));
                p.setDestino(rs.getString(2));
                p.setFecha(rs.getDate(3));
                p.setHora(rs.getDate(4));
                p.setCupo(rs.getInt(5));
                p.setIdusuario(rs.getInt(5));                
                rutas.add(p);
            }
        }catch(Exception ex){
            System.out.println("SQLException!: " + ex.getMessage());
        }
        return rutas;
    } */
        
        
    
    /*
    ** AQUI EMPIEZAN LOS METODOS DE GUARDA
    *
    */       
    public boolean guardaUsuario(int id, String nombre, String apellido, String correo, 
            String passwrd,String perfil) throws Exception {
        
        boolean b = false;
        try {
            stmt = con.createStatement();
            stmt.executeUpdate("INSERT INTO usuario (idusuario, correo, nombre, apellido, passwrd, perfil)"
                    + "VALUES (" + id +",'" + correo + "', '" + nombre + "' , '" + apellido + "','" + passwrd +"','"+perfil+ "')");
            b = true;
        } catch(Exception ex){
            System.out.println("SQLException!!!: " + ex.getMessage());
        }
        return b;
    }
    
    public boolean guardaNotificacion(int id, int idUsuario, String mensaje, String fecha, char visto) throws Exception {
        
        boolean b = false;
        try {
            stmt = con.createStatement();
            stmt.executeUpdate("insert into Notificacion (id, idUsuario, mensaje, fecha, visto) \n" +
                                "values ("+id+", "+idUsuario+", '"+mensaje+"', '"+fecha+"', '"+visto+"')");
            b = true;
        } catch(Exception ex){
            System.out.println("SQLException!!!: " + ex.getMessage());
        }
        return b;
    }
    
    public boolean notificacionVista(int id) {
        
        boolean b = false;
        try {
            stmt = con.createStatement();
            stmt.executeUpdate("update Notificacion \n" +
                                "set visto = 'T'\n" +
                                "where id = "+id+"  ");
            b = true;
        } catch(Exception ex){
            System.out.println("SQLException!: " + ex.getMessage());
        }
        return b;
    }
    
    public boolean guardaCalificacion(int id, int idUsuario, double calificacion) throws Exception {
        
        boolean b = false;
        try {
            stmt = con.createStatement();
            stmt.executeUpdate("insert into calificacion (id, idUsuario, calificacion) \n" +
                                "values ("+id+", "+idUsuario+", "+calificacion+")");
            b = true;
        } catch(Exception ex){
            System.out.println("SQLException!!!: " + ex.getMessage());
        }
        return b;
    }
    
    public boolean eliminaNotificacion(int id) throws Exception {
        
        boolean b = false;
        try {
            stmt = con.createStatement();
            stmt.executeUpdate("delete from Notificacion \n" +
                                "where id = "+id+"");
            b = true;
        } catch(Exception ex){
            System.out.println("SQLException!!!: " + ex.getMessage());
        }
        return b;
    }
    
    
    public boolean restaAsiento(int idRuta) throws Exception {
        
        boolean b = false;
        try {
            stmt = con.createStatement();
            stmt.executeUpdate("update ruta \n" +
                                "set  cupo = cupo -1\n" +
                                "where idRuta = "+idRuta+"");
            b = true;
        } catch(Exception ex){
            System.out.println("SQLException!!!: " + ex.getMessage());
        }
        return b;
    }
    
    public boolean sumaAsiento(int idRuta) throws Exception {
        
        boolean b = false;
        try {
            stmt = con.createStatement();
            stmt.executeUpdate("update ruta \n" +
                                "set  cupo = cupo +1\n" +
                                "where idRuta = "+idRuta+"");
            b = true;
        } catch(Exception ex){
            System.out.println("SQLException!!!: " + ex.getMessage());
        }
        return b;
    }
    
    public boolean cancelaViaje(int idRuta, int idUsuario) throws Exception {
        
        boolean b = false;
        try {
            stmt = con.createStatement();
            stmt.executeUpdate("delete from viaje\n" +
                                "where idUsuario = "+idUsuario+" and idRuta = "+idRuta+"");
            b = true;
        } catch(Exception ex){
            System.out.println("SQLException!!!: " + ex.getMessage());
        }
        return b;
    }
    
    public boolean viajeCalificado(int idRuta, int idUsuario) throws Exception {
        boolean b = false;
        try {
            stmt = con.createStatement();
            stmt.executeUpdate("update viaje \n" +
                                "set calificado = 'T'\n" +
                                "where idRuta = "+idRuta+" and idUsuario = "+idUsuario+" ");
            b = true;
        } catch(Exception ex) {
            System.out.println("SQLException!!!: " + ex.getMessage());
        }
        return b;
        
    }
    
    public String getNombreUsuario(int idUsuario) {
        String nom = "";
        try{
            stmt = con.createStatement();
            rs = stmt.executeQuery("select concat_ws(' ', nombre::text, apellido::text) as nom from usuario \n" +
                                    "where idUsuario = "+idUsuario+" ");
            while(rs.next()){
                nom = rs.getString(1);                
            }
        }catch(Exception ex){
            System.out.println("SQLException: " + ex.getMessage());
        }
        return nom;
    }
    
    public boolean execute(String command) {
        boolean b = false;
        try {
            stmt = con.createStatement();
            stmt.executeUpdate(command);
            b = true;
        } catch(Exception ex){
            System.out.println("SQLException!!!: " + ex.getMessage());
        }
        return b;
    }
    
    public boolean guardaViaje(int idRuta, int idUsuario) throws Exception {
        
        boolean b = false;
        try {
            stmt = con.createStatement();
            stmt.executeUpdate("insert into viaje (idruta, idusuario, calificado)\n" +
                                "values("+idRuta+", "+idUsuario+", 'F')");
            b = true;
        } catch(Exception ex){
            System.out.println("SQLException!!!: " + ex.getMessage());
        }
        return b;
    }
    
    public boolean actualizaUsuario(int id, String nombre, String apellido, String correo, String password, String perfil) {
        boolean b = false;
        try {
            stmt = con.createStatement();
            stmt.executeUpdate("update usuario\n" +
                                "set correo = '"+correo+"', nombre='"+nombre+"', apellido = '"+apellido+"', passwrd = '"+password+"',perfil='"+perfil+"'\n" +
                                "where idusuario = "+id+" ");
            b = true;
        } catch(Exception ex){
            System.out.println("SQLException!!!: " + ex.getMessage());
        }
        return b;
    }
    
    public boolean actualizaPerfil(int idUsuario, String perfil) {
        boolean b = false;
        try {
            stmt = con.createStatement();
            stmt.executeUpdate("update usuario \n" +
                                "set perfil = '"+perfil+"'\n" +
                                "where idUsuario = "+idUsuario+" ");
            b = true;
        } catch(Exception ex){
            System.out.println("SQLException!!!: " + ex.getMessage());
        }
        return b;
    }
    
    public String getFoto(int id) throws Exception {
        String nom = "";
        try{
            stmt = con.createStatement();
            rs = stmt.executeQuery("select perfil from usuario \n" +
                                    "where idUsuario = "+id+" ");
            while(rs.next()){
                nom = rs.getString(1);                
            }
        }catch(Exception ex){
            System.out.println("SQLException: " + ex.getMessage());
        }
        return nom;
    }
    
    public boolean actualizaRuta(int id, String destino, String salida, String fecha, String hora, 
            int cupo, int idUsuario, int precio, String destino_dir, String salida_dir) {
        
         boolean b = false;
        try {
            stmt = con.createStatement();
            stmt.executeUpdate("update ruta \n" +
                                "set destino = '"+destino+"', fecha = '"+fecha+"', hora = '"+hora+"', cupo = "+cupo+", idUsuario = "+idUsuario+", \n" +
                                "salida='"+salida+"', precio="+precio+", destino_dir='"+destino_dir+"', salida_dir='"+salida_dir+"'");
            b = true;
        } catch(Exception ex){
            System.out.println("SQLException!!!: " + ex.getMessage());
        }
        return b;
       
    }
    
    public boolean guardaRuta(int id, String destino, String salida, String fecha, String hora, 
            int cupo, int idUsuario, int precio, String destino_dir, String salida_dir) {
        
        boolean b = false;
        try {
            stmt = con.createStatement();
            stmt.executeUpdate("insert into ruta (idRuta, destino, fecha, hora, cupo, idUsuario, salida, precio, destino_dir, salida_dir)\n" +
                                "values("+id+", '"+destino+"', '"+fecha+"', "
                    + "'"+hora+"', "+cupo+", "+idUsuario+", '"+salida+"', "+precio+", '"+destino_dir+"', '"+salida_dir+"');");
            b = true;
        } catch(Exception ex){
            System.out.println("SQLException!!!: " + ex.getMessage());
        }
        return b;
        
    }
    
    public boolean eliminaUsuario(int id) {
        boolean b = false;
        try {
            stmt = con.createStatement();
            stmt.executeUpdate("delete from usuario\n" +
                                    "where idUsuario ="+id+"");

            b = true;
        } catch(Exception ex){
            System.out.println("SQLException!!!: " + ex.getMessage());
        }
        return b;
    }
    
    public boolean eliminaRuta(int id) {
        boolean b = false;
        try {
            stmt = con.createStatement();
            stmt.executeUpdate("delete from viaje\n" +
                                    "where idruta ="+id+" ");
            
            stmt.executeUpdate("delete from ruta\n" +
                                    "where idruta ="+id+" ");
            
            b = true;
        } catch(Exception ex){
            System.out.println("SQLException!!!: " + ex.getMessage());
        }
        return b;
    }
    
        public boolean setCreacion(int idcrea,String pago,int iduser, int idrut,int calif) throws Exception{
        boolean b = false;
        try{
            stmt = con.createStatement();
            rs = stmt.executeQuery("INSERT INTO creacion (idcrea,pago,iduser,idrut,calif)"
                    + "VALUES (" + idcrea +",'" + pago + "'," + iduser + "," + idrut + "," + calif  +")");
            b = true;
        }catch(Exception ex){
            System.out.println("SQLException: " + ex.getMessage());
        }
        return b;
    }
        
     
        
    /*
    ** MAXIMOS
    *
    */ 
        
    public int getMaximoIdUsuario() throws Exception{
        int max = 0;
        try{
            stmt = con.createStatement();
            rs = stmt.executeQuery("select max(idUsuario) from usuario");
            while(rs.next()){
                max = rs.getInt(1);                
            }
        }catch(Exception ex){
            System.out.println("SQLException: " + ex.getMessage());
        }
        return max;
    }
    
    public int getMaximoIdCalificacion() throws Exception{
        int max = 0;
        try{
            stmt = con.createStatement();
            rs = stmt.executeQuery("select max(id) from Calificacion");
            while(rs.next()){
                max = rs.getInt(1);                
            }
        }catch(Exception ex){
            System.out.println("SQLException: " + ex.getMessage());
        }
        return max;
    }
    
    public int getMaximoIdRuta() throws Exception {
        int max = 0;
        try{
            stmt = con.createStatement();
            rs = stmt.executeQuery("select max(idruta) from ruta");
            while(rs.next()){
                max = rs.getInt(1);                
            }
        }catch(Exception ex){
            System.out.println("SQLException: " + ex.getMessage());
        }
        return max;
    }
    
    public int getMaximoIdNotificacion() throws Exception {
        int max = 0;
        try{
            stmt = con.createStatement();
            rs = stmt.executeQuery("select max(id) from Notificacion");
            while(rs.next()){
                max = rs.getInt(1);                
            }
        }catch(Exception ex){
            System.out.println("SQLException: " + ex.getMessage());
        }
        return max;
    }
    
    public double getPromedioCalificacion(int idUsuario) throws Exception {
        double prom = 0;
        try{
            stmt = con.createStatement();
            rs = stmt.executeQuery("select round( CAST(avg(calificacion) as numeric), 2) from calificacion \n" +
                                    "where idUsuario = "+idUsuario+" ");
            while(rs.next()){
                prom = rs.getDouble(1);                
            }
        }catch(Exception ex){
            System.out.println("SQLException: " + ex.getMessage());
        }
        return prom;
    }
}

