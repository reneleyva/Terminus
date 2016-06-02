package controlador;

import java.util.ArrayList;

/**
 *
 * @author ReneGL
 */
public class Notificacion {
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
    private String mensaje;
    private String fecha;
    private char visto;

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

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public char getVisto() {
        return visto;
    }

    public void setVisto(char visto) {
        this.visto = visto;
    }
    
    
    public boolean guarda(int id, int idUsuario, String mensaje, String fecha) {
        
        boolean b = false;
        try {
            b = conexionBD.guardaNotificacion(id, idUsuario, mensaje, fecha, 'F');
        } catch (Exception ex) {
            System.out.println("Error al registrar producto " + ex.getMessage());
        }
        return b;
    }
    
    public boolean notificacionVista(int id) {
        
        boolean b = false;
        try {
            b = conexionBD.notificacionVista(id);
        } catch (Exception ex) {
            System.out.println("Error  " + ex.getMessage());
        }
        return b;
    }
    
    public boolean elimina(int id) {
        
        boolean b = false;
        try {
            b = conexionBD.eliminaNotificacion(id);
        } catch (Exception ex) {
            System.out.println("Error al registrar producto " + ex.getMessage());
        }
        return b;
    }
    
    public ArrayList getNotificaciones() {
       ArrayList l = new ArrayList();
        try {
            l = conexionBD.getNotificaciones();
        } catch (Exception ex) {
            System.out.println("Error " + ex.getMessage());
        }
        return l;
    }
    
    
    public int getMaximoId() throws Exception {
        int maximo = 0;
        try {
            maximo = conexionBD.getMaximoIdNotificacion();
        } catch (Exception ex) {
            System.out.println("Error al recuperar máximo de tabla " + ex.getMessage());
        }
        return maximo;
    }

    @Override
    public String toString() {
        return "Notificacion{" + "id=" + id + ", idUsuario=" + idUsuario + ", mensaje=" + mensaje + ", fecha=" + fecha + ", visto=" + visto + '}';
    }
    
    
    
}
