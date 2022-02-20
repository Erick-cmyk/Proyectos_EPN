
public class Teatro extends Evento {
	private ListaArtista nombreActor;
	private ListaCronograma horario;
	
	// Constructores
	public Teatro(ListaArtista vnombreActor, ListaCronograma vhorario, String vnombre, 
			String vprovincia, String vciudad, String vnombreLugar,String vdireccion, 
			int vFila, int vColumna, int vnumPuertas,String vorganizador) {
		super(vnombre, vprovincia, vciudad, vnombreLugar, vdireccion, vFila, vColumna,
				vnumPuertas, vorganizador);
	
		this.nombreActor = vnombreActor;
		this.horario = vhorario;
	}
	
	
	public Teatro(String vnombre, Lugar vLugar, String vorganizador, 
			ListaArtista nombreActor, ListaCronograma horario) {
		super(vnombre, vLugar, vorganizador);
		
		this.nombreActor = nombreActor;
		this.horario = horario;
	}

	// Propiedades
	public ListaArtista getNombreActor() {
		return this.nombreActor;
	}

	public void setNombreActor(ListaArtista vnombreActor) {
		this.nombreActor = vnombreActor;
	}

	public ListaCronograma getHorario() {
		return this.horario;
	}

	public void setHorario(ListaCronograma vhorario) {
		this.horario = vhorario;
	}
	
	public String toString() {
		return super.toString()+"\n"+"PARTICIPANTE/ES: "+this.getNombreActor()+"\n"+"HORARIOS: "+this.getHorario();
	}
	
	public void mostrarInformacion() {
		System.out.println(this.toString());
	}

}
