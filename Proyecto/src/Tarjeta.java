import java.time.*;

/**
 * 
 */

/**
 * @author DELL
 *
 */
public class Tarjeta {
	
	// Atributos
	private final String numTarjeta;
	private LocalDate fechVenc;
	private String nombre;
	private float montoCarga = 0;
	private Compra compra;
	
	// Constructor
	public Tarjeta(String vnumTarjeta, LocalDate vfechVenc, String vnombre) {
		this.numTarjeta = vnumTarjeta;
		this.fechVenc = vfechVenc;
		this.nombre = vnombre;
		this.compra = new Compra();
	}

	// Propiedades
	public String getNumTarjeta() {
		return numTarjeta;
	}

	public float getMontoCarga() {
		return montoCarga;
	}


	public LocalDate getFechVenc() {
		return fechVenc;
	}

	public void setFechVenc(LocalDate fechVenc) {
		this.fechVenc = fechVenc;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	
	public Compra getCompra() {
		return this.compra;
	}
	
	//Metodos Objeto
	public void compraTicket (Evento eventaux, Localidad locaux, int numBoletos) throws NullPointerException {
		int cap = eventaux.getLugar().getListR().getCapacidad();
		int ocu = eventaux.getLugar().getListR().getVendidos();
		if(cap == ocu) {
			System.out.println("Capacidad Llena");
			return;
		}else if(numBoletos > eventaux.getLugar().getListR().asientosxLocalidad(locaux)) {
			throw new NullPointerException("numero de asientos no disponible "
					+ "en la localidad: " + locaux.getNombre()); 
		}else{
			ListaAsiento rowsAux = eventaux.getLugar().getListR();
			int aux = 0;
			while(aux !=  numBoletos) {	
				for(int i = 0; i < cap; i++) {
					aux = aux + 1;
					String num = "A"+aux;
					if(rowsAux.buscarAsiento(num).getLocalidad().equals(locaux)) {
						Asiento asientoAux = rowsAux.buscarAsiento(num); 
						asientoAux.updtDisponibilidad();
						Ticket ticketcito = new Ticket(eventaux, asientoAux);
						compra.getBoleto().agregarCompra(ticketcito);
						this.montoCarga = this.montoCarga + asientoAux.getLocalidad().getPrecio();
						break;
					}
				}
			}
		}
	}

}
