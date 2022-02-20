
public abstract class Evento {
	
	// Atributos
	private static int n;
	private final String idEvento;
	private String nombre;
	private Lugar lugar;
	private String organizador;
	
	// Constructores
	public Evento(String vnombre, String vprovincia, String vciudad, String vnombreLugar,String vdireccion, int vFila, int vColumna, int vnumPuertas,String vorganizador) {
		Lugar lug1 = new Lugar (vprovincia,vciudad,vnombreLugar, vdireccion,vFila, vColumna,vnumPuertas );
		this.idEvento = "Event" + n;
		this.nombre=  vnombre; 
		this.lugar = lug1;
		this.organizador = vorganizador;
		n++;
	}
	
	public Evento(String vnombre, Lugar vlugar, String vorganizador) {
		this.idEvento = "Event" + n;
		this.nombre =vnombre;
		this.lugar = vlugar;
		this.organizador = vorganizador;
		n++;
	}

	public String getIdEvento() {
		return this.idEvento;
	}

	public String getNombre() {
		return this.nombre;
	}

	public void setNombre(String vnombre) {
		this.nombre = vnombre;
	}

	public Lugar getLugar() {
		return this.lugar;
	}

	public void setLugar(Lugar vlugar) {
		this.lugar = vlugar;
	}

	public String getOrganizador() {
		return this.organizador;
	}

	public void setOrganizador(String vorganizador) {
		this.organizador = vorganizador;
	}
	
	public String toString() {
		return this.getIdEvento()+"\t"+this.getNombre()+"\t"+this.getLugar()+"\t"+this.getOrganizador();
	}
	
	// Metodos abstractos
	public abstract void mostrarInformacion();

	// Metodos Object
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (!(obj instanceof Evento))
			return false;
		Evento other = (Evento) obj;
		if (lugar == null) {
			if (other.lugar != null)
				return false;
		} else if (!lugar.equals(other.lugar))
			return false;
		if (nombre == null) {
			if (other.nombre != null)
				return false;
		} else if (!nombre.equals(other.nombre))
			return false;
		return true;
	}
	
}
