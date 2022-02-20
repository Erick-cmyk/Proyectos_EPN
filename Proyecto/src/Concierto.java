
public class Concierto extends Evento{
	
	//  Atributos
	private ListaArtista nombreArtista;
	private Cronograma horario;

	// Constructores
	public Concierto(ListaArtista vnombreArtista, Cronograma vhorario,String vnombre, String vprovincia, String vciudad, String vnombreLugar,
			String vdireccion, int vFila, int vColumna, int vnumPuertas,String vorganizador) {
		super(vnombre, vprovincia, vciudad, vnombreLugar, vdireccion, vFila, vColumna, vnumPuertas, vorganizador);
		this.nombreArtista = vnombreArtista;
		this.horario = vhorario;
	}
	
	public Concierto(String vnombre, Lugar vLugar, String vorganizador, 
			ListaArtista nombreArtista, Cronograma horario) {
		super(vnombre, vLugar, vorganizador);
		
		this.nombreArtista = nombreArtista;
		this.horario = horario;
	}
	
	//Propiedades

	public ListaArtista getNombreArtista() {
		return this.nombreArtista;
	}

	public void setNombreArtista(ListaArtista vnombreArtista) {
		this.nombreArtista = vnombreArtista;
	}

	public Cronograma getHorario() {
		return this.horario;
	}

	public void setHorario(Cronograma vhorario) {
		this.horario = vhorario;

	}

	public String toString() {
		return super.toString()+"\n"+"ARTISTA O ARTISTAS: "+this.getNombreArtista()+"\n"+"FECHA DEL CONCIERTO: "+this.horario;
	}

	public void mostrarInformacion() {
		System.out.println(this.toString());
	}
	
}
	
	
