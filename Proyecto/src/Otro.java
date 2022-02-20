
public class Otro extends Evento {
	
	private ListaArtista nombreInvitdo;
	private ListaCronograma  horario;
	

	public Otro(ListaArtista vnombreInvitado, ListaCronograma vhorario, 
			String vnombre, String vprovincia, String vciudad, String vnombreLugar,
			String vdireccion, int vFila, int vColumna, int vnumPuertas,
			String vorganizador) {
		super(vnombre,vprovincia,vciudad, vnombreLugar, vdireccion,  vFila, vColumna,  vnumPuertas, vorganizador);
		this.nombreInvitdo=vnombreInvitado;
		this.horario=vhorario;
	}

	public ListaArtista getNombreInvitdo() {
		return this.nombreInvitdo;
	}

	public void setNombreInvitdo(ListaArtista vnombreInvitdo) {
		this.nombreInvitdo = vnombreInvitdo;
	}

	public ListaCronograma getHorario() {
		return this.horario;
	}

	public void setHorario(ListaCronograma vhorario) {
		this.horario = vhorario;
	}
	
	public String toString() {
		return super.toString()+"\n"+"PARTICIPANTE/ES: "+this.getNombreInvitdo()+"\n"+"HORARIOS; "+this.getHorario();
	}
	
	public void mostrarInformacion() {
		System.out.println(this.toString());
	}

}
