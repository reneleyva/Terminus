package controlador;

import java.io.Serializable;
import java.util.ArrayList;


/**
 *
 * @author Renoir
 */
public class Ruta {

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
    private String destino;
    private String salida;
    private String fecha;
    private String hora;
    private int cupo;
    private int idUsuario;
    private int precio;
    private String destino_dir;
    private String salida_dir;
    private String descripccion;
    
    public Ruta() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDestino() {
        return destino;
    }

    public void setDestino(String destino) {
        this.destino = destino;
    }

    public String getSalida() {
        return salida;
    }

    public void setSalida(String salida) {
        this.salida = salida;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }

    public int getCupo() {
        return cupo;
    }

    public void setCupo(int cupo) {
        this.cupo = cupo;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }


    public int getPrecio() {
        return precio;
    }

    public void setPrecio(int precio) {
        this.precio = precio;
    }

    public String getDestino_dir() {
        return destino_dir;
    }

    public void setDestino_dir(String destino_dir) {
        this.destino_dir = destino_dir;
    }

    public String getSalida_dir() {
        return salida_dir;
    }

    public void setSalida_dir(String salida_dir) {
        this.salida_dir = salida_dir;
    }

    public String getDescripccion() {
        return descripccion;
    }

    public void setDescripccion(String descripccion) {
        this.descripccion = descripccion;
    }
    
    
    public int getMaximoId() throws Exception {
        int maximo = 0;
        try {
            maximo = conexionBD.getMaximoIdRuta();
        } catch (Exception ex) {
            System.out.println("Error al recuperar máximo de tabla " + ex.getMessage());
        }
        return maximo;
    }
    
    public boolean guardaRuta(int id, String destino, String salida, String fecha, String hora, 
            int cupo, int idUsuario, int precio, String destino_dir, String salida_dir) {
        
        boolean b = false;
        try {
            b = conexionBD.guardaRuta(id, destino, salida, fecha, hora, cupo, idUsuario, precio, 
                    destino_dir, salida_dir);
        } catch (Exception ex) {
            System.out.println("Error al registrar producto " + ex.getMessage());
        }
        return b;
    }
    
    public boolean actualizaRuta(int id, String destino, String salida, String fecha, String hora, 
            int cupo, int idUsuario, int precio, String destino_dir, String salida_dir) {
        
        boolean b = false;
        try {
            b = conexionBD.actualizaRuta(id, destino, salida, fecha, hora, cupo, 
                    idUsuario, precio, destino_dir, salida_dir);
        } catch (Exception ex) {
            System.out.println("Error al registrar producto " + ex.getMessage());
        }
        return b;
    }
    
    public boolean elimina(int id) {
        boolean b = false;
        try {
            b = conexionBD.eliminaRuta(id);
        } catch (Exception ex) {
            System.out.println("Error al registrar producto " + ex.getMessage());
        }
        return b;
    }
    
    
    public ArrayList getRutas() {
       ArrayList l = new ArrayList();
        try {
            l = conexionBD.getRutas();
        } catch (Exception ex) {
            System.out.println("Error desde Usuario " + ex.getMessage());
        }
        return l;
    }

    @Override
    public String toString() {
        return "Ruta{" + "id=" + id + ", destino=" + destino + ", salida=" + salida + ", fecha=" + 
                fecha + ", hora=" + hora + ", cupo=" + cupo + ", idUsuario=" + idUsuario + 
                ", precio=" + precio + '}';
    }

}
