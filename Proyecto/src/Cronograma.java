import java.time.LocalDate;
import java.time.LocalTime;

public class Cronograma {
	
	// Atributos
	private static int n = 1;
	private final String iDC;  
	private LocalDate fecha;
	private LocalTime hinicio;
	private LocalTime hfin;
	 
	// Constructor
	public Cronograma(LocalDate vfecha, LocalTime vhinicio, LocalTime vhfin) {
		this.iDC = "Cro" + n;
		fecha = vfecha;
		this.hinicio = vhinicio;
		this.hfin = vhfin;
		n++;
	}
	
	// Propiedades
	public LocalDate getFecha() {
		return fecha;
	}
	
	public void setFecha(LocalDate vFecha) {
		this.fecha = vFecha;
	}
	
	public LocalTime getHinicio() {
		return hinicio;
	}
	
	public void setHinicio(LocalTime hinicio) {
		this.hinicio = hinicio;
	}
	
	public LocalTime getHfin() {
		return hfin;
	}
	
	public void setHfin(LocalTime hfin) {
		this.hfin = hfin;
	}

	public String getiDC() {
		return iDC;
	}
	
	// Metodos Object
	@Override
	public String toString() {
		return fecha + "\t"+ hinicio + "-" + hfin;
	}
	  

}
