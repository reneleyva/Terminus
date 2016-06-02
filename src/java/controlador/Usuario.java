/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.util.ArrayList;

/**
 *
 * @author Xavier
 */

public class Usuario {

    Conexion conexionBD = new Conexion();

    public void conecta() throws Exception {
        try {
            conexionBD.conectar();
        } catch (Exception ex) {
            System.out.println("Falló conecta " + ex.getMessage());
        }
    }

    public void desconecta() throws Exception {
        try {
            conexionBD.desconectar();
        } catch (Exception ex) {
            System.out.println("Falló desconecta " + ex.getMessage());
        }
    }
    
    private int idusuario;
    private String correo;
    private String nombre;
    private String apellido;
    private String password;
    private String perfil;

    
    public Usuario() {
    }

    public int getIdusuario() {
        return idusuario;
    }

    public void setIdusuario(int idusuario) {
        this.idusuario = idusuario;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getPerfil() {
        return perfil;
    }

    public void setPerfil(String perfil) {
        this.perfil = perfil;
    }
    
    public ArrayList getUsuarios() {
       ArrayList l = new ArrayList();
        try {
            l = conexionBD.getUsuarios();
        } catch (Exception ex) {
            System.out.println("Error desde Usuario " + ex.getMessage());
        }
        return l;
    }
    
    
    
    public boolean guarda(int id, String nombre, String apellido, String correo, String password, String perfil) {
        boolean b = false;
        try {
            b = conexionBD.guardaUsuario(id, nombre, apellido, correo, password, perfil);
        } catch (Exception ex) {
            System.out.println("Error al registrar producto " + ex.getMessage());
        }
        return b;
    }
    
    public boolean actualiza(int id, String nombre, String apellido, String correo, String password, String perfil) {
        boolean b = false;
        try {
            b = conexionBD.actualizaUsuario(id, nombre, apellido, correo, password, perfil);
        } catch (Exception ex) {
            System.out.println("Error al registrar producto " + ex.getMessage());
        }
       
        this.idusuario = id;
        this.nombre = nombre;
        this.apellido = apellido;
        this.correo = correo;
        this.password = password;
        this.perfil = perfil;
        
        return b;
        
    }
    
    public boolean actualizaPerfil(int id, String perfil) {
        boolean b = false;
        try {
            b = conexionBD.actualizaPerfil(id, perfil);
        } catch (Exception ex) {
            System.out.println("Error al registrar producto " + ex.getMessage());
        }
       
        this.perfil = perfil;
        
        return b;
        
    }
    
    
    public boolean elimina(int id) {
        boolean b = false;
        try {
            b = conexionBD.eliminaUsuario(id);
        } catch (Exception ex) {
            System.out.println("Error al registrar producto " + ex.getMessage());
        }
        return b;
    }
    
    public int getMaximoId() throws Exception {
        int maximo = 0;
        try {
            maximo = conexionBD.getMaximoIdUsuario();
        } catch (Exception ex) {
            System.out.println("Error al recuperar máximo de tabla " + ex.getMessage());
        }
        return maximo;
    }
    
    public String getFoto(int id) throws Exception {
        String maximo = "";
        try {
            maximo = conexionBD.getFoto(id);
        } catch (Exception ex) {
            System.out.println("Error al recuperar máximo de tabla " + ex.getMessage());
        }
        return maximo;
    }
    /*@Override
    public int hashCode() {
        int hash = 0;
        hash += (idusuario != null ? idusuario.hashCode() : 0);
        return hash;
    }*/

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Usuario)) {
            return false;
        }
        Usuario other = (Usuario) object;
        return this.idusuario == other.getIdusuario();
    }

    @Override
    public String toString() {
        return "DBConex.Usuario[ idusuario=" + idusuario + " ]";
    }
    
}
