/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package test;
import controlador.*;
import java.util.ArrayList;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
/**
 *
 * @author ReneGL
 */
public class Main {
    public static void main(String[] args) throws Exception {
        
        //Prueba conexion
       /* ArrayList l = new ArrayList();
        Conexion con = new Conexion();
        con.conectar();
        l = con.getUsuarios();
        con.desconectar();
        Usuario s = (Usuario) l.get(0);
        assert s != null;
        
        boolean estado = false; */
        
        //Prueba usuario guarda uno y maximoID
        /*Usuario user = new Usuario();
        user.conecta();
        int id = user.getMaximoId();
        id += 1;
        estado = user.guarda(id, "Otro", "MArtinez", "lol@ciecnias", "Rene8523");
        user.desconecta();
        assert estado;*/
        
        //Prueba iniciar sesion 
       /* ArrayList usuarios = new ArrayList();
        Usuario user = new Usuario();
        user.conecta();
        usuarios = user.getUsuarios();
        user.desconecta();
        
        System.out.println(usuarios.size());*/
       /*Viaje v = new Viaje();
       ArrayList viajes = new ArrayList();
       v.conecta();
       viajes = v.getViajes();
       System.out.println(viajes.size());
       v.desconecta();*/
       
       /*Ruta r = new Ruta();
       ArrayList rutas = new ArrayList();
       r.conecta();
       rutas = r.getRutas();
       r.desconecta();
       
       for (Object o : rutas ){
           Ruta current = (Ruta) o;
           System.out.println(current.getSalida());
       }*/
      
      /*ArrayList not = new ArrayList();
      Notificacion n = new Notificacion();
      n.conecta();
      not = n.getNotificaciones();
      n.desconecta();
      
      for (Object o: not) {
          Notificacion c = (Notificacion) o;
          System.out.println(c.toString());
      }*/
      
      
     /*Date date = new Date();
     DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
     String fecha = dateFormat.format(date);
     System.out.println(fecha);*/
     
     //REvisa fehca 
     
     /*Date date = new Date(2016-1900, 5-1, 31);
     Date hoy = new Date();
     System.out.println(date.toString());*/
     
     
     /*Calificacion c = new Calificacion();
     c.conecta();
     int max = c.getMaximoId();
     System.out.println("MAX: " + max);
     ArrayList cal = new ArrayList();
     cal = c.getCalificaciones();
     
     for (Object o: cal) {
          Calificacion current = (Calificacion) o;
          System.out.println(current.toString());
     }
     double prom = c.getPromedio(10);
     System.out.println("PRomedio: " + prom);
     c.desconecta();*/
   
     
     /*Viaje v = new Viaje();
     
     //ArrayList viajes = new ArrayList();
     boolean estado = false;
     v.conecta();
     
     estado = v.calificado(3, 7);
     System.out.println(estado);
     viajes = v.getViajes();
     
     for (Object o: viajes) {
          Viaje current = (Viaje) o;
          System.out.println(current.toString());
     }
     v.desconecta();*/
     /*Conexion con = new Conexion();
     con.conectar();
     String nom = con.getNombreUsuario(10);
     System.out.println(nom);
     con.desconectar();*/
     
     /*Viaje v = new Viaje();
     Viaje otro = null;
     v.conecta();
     otro = v.buscaViaje(3);
     v.desconecta();
     System.out.println(otro.toString());*/
     
    
    /*Calificacion c = new Calificacion();
    c.conecta();
   
    c.viajeCalificado(2, 1);  
    c.desconecta();*/
    
    Usuario u = new Usuario();
    u.conecta();
    u.actualizaPerfil(2, "LOLLLLL");
    System.out.println(u.getFoto(1));
    u.desconecta();
    
     
    }
}
