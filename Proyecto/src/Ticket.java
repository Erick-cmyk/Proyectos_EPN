
public class Ticket {

	// Atributos
	private Evento evento;
	private Asiento asiento;
	
	// Constructor
	public Ticket(Evento evento, Asiento asiento) {
		this.evento = evento;
		this.asiento = asiento;
	}
	
	// Propiedades
	public Evento getEvento() {
		return evento;
	}

	public void setEvento(Evento evento) {
		this.evento = evento;
	}

	public Asiento getAsiento() {
		return asiento;
	}

	public void setAsiento(Asiento asiento) {
		this.asiento = asiento;
	}
	// Metodos Object

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (!(obj instanceof Ticket))
			return false;
		Ticket other = (Ticket) obj;
		if (asiento == null) {
			if (other.asiento != null)
				return false;
		} else if (!asiento.equals(other.asiento))
			return false;
		if (evento == null) {
			if (other.evento != null)
				return false;
		} else if (!evento.equals(other.evento))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return asiento + "--------------------------------------" + evento;
	}
	
	
	
	
}
