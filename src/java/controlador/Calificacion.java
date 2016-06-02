
package controlador;

import java.util.ArrayList;

/**
 *
 * @author ReneGL
 */
public class Calificacion {
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
    
    private int id;
    private int idUsuario;
    private double calificacion;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public double getCalificacion() {
        return calificacion;
    }

    public void setCalificacion(double calificacion) {
        this.calificacion = calificacion;
    }

    public int getMaximoId() throws Exception {
        int maximo = 0;
        try {
            maximo = conexionBD.getMaximoIdCalificacion();
        } catch (Exception ex) {
            System.out.println("Error al recuperar máximo de tabla " + ex.getMessage());
        }
        return maximo;
    }
    
    public boolean guardaCalificacion(int id, int idUsuario, int idRuta, double calificacion) {
        
        boolean b = false;
        try {
            b = conexionBD.guardaCalificacion(id, idUsuario,calificacion);
        } catch (Exception ex) {
            System.out.println("Error al registrar producto " + ex.getMessage());
        }
        return b;
    }
    
    
    public boolean viajeCalificado(int idUsuario, int idRuta) {
        
        boolean b = false;
        try {
            b = conexionBD.viajeCalificado(idRuta, idUsuario);
        } catch (Exception ex) {
            System.out.println("Error al registrar producto " + ex.getMessage());
        }
        return b;
    }
    
    public ArrayList getCalificaciones() {
       ArrayList l = new ArrayList();
        try {
            l = conexionBD.getCalificaciones();
        } catch (Exception ex) {
            System.out.println("Error desde Usuario " + ex.getMessage());
        }
        return l;
    }
    
    public double getPromedio(int idUsuario) throws Exception {
        double prom = 0;
        try {
            prom = conexionBD.getPromedioCalificacion(idUsuario);
        } catch (Exception ex) {
            System.out.println("Error al recuperar máximo de tabla " + ex.getMessage());
        }
        return prom;
    }

    @Override
    public String toString() {
        return "Calificacion{" + "id=" + id + ", idUsuario=" + idUsuario + ", calificacion=" + calificacion + '}';
    }
    
    
}
