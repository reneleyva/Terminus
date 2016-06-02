
package controlador;

import java.util.ArrayList;


public class Viaje {
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
    
    
    private int idRuta;
    private int idUsuario;
    private char calificado;

 

    public int getIdRuta() {
        return idRuta;
    }

    public void setIdRuta(int idRuta) {
        this.idRuta = idRuta;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public char getCalificado() {
        return calificado;
    }

    public void setCalificado(char calificado) {
        this.calificado = calificado;
    }
    
    
    public ArrayList getViajes() {
       ArrayList l = new ArrayList();
        try {
            l = conexionBD.getViajes();
        } catch (Exception ex) {
            System.out.println("Error desde Usuario " + ex.getMessage());
        }
        return l;
    }
    
    
    public boolean restaAsiento(int idRuta) {
        boolean b = false;
        try {
            b = conexionBD.restaAsiento(idRuta);
        } catch (Exception ex) {
            System.out.println("Error al registrar producto " + ex.getMessage());
        }
        return b;
    }
    
    public boolean sumaAsiento(int idRuta) {
        boolean b = false;
        try {
            b = conexionBD.sumaAsiento(idRuta);
        } catch (Exception ex) {
            System.out.println("Error al registrar producto " + ex.getMessage());
        }
        return b;
    }
    
    public boolean cancelaViaje(int idRuta, int idUsuario) {
        boolean b = false;
        try {
            b = conexionBD.cancelaViaje(idRuta, idUsuario);
        } catch (Exception ex) {
            System.out.println("Error al registrar producto " + ex.getMessage());
        }
        return b;
    }
    
    public boolean calificado(int idRuta, int idUsuario) {
        boolean b = false;
        try {
            b = conexionBD.viajeCalificado(idRuta, idUsuario);
        } catch (Exception ex) {
            System.out.println("Error al registrar producto " + ex.getMessage());
        }
        return b;
    }
    
    public Viaje buscaViaje(int idRuta) {
        ArrayList viajes = this.getViajes();
        Viaje viaje = null;
        for (Object o : viajes) {
            Viaje v = (Viaje) o;
            if (v.getIdRuta() == idRuta) 
                viaje = v;
        }
        return viaje;
    }
    @Override
    public String toString() {
        return "Viaje{" + "idRuta=" + idRuta + ", idUsuario=" + idUsuario + ", calificado=" + calificado + '}';
    }
    
    
}
