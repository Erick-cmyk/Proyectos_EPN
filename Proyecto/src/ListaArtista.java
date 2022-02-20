import java.util.ArrayList;

public class ListaArtista {
	ArrayList<Artista>ListaArtista=new ArrayList<Artista>();
	
	public ListaArtista() {
		ListaArtista = new ArrayList<Artista>();  
	}
	public void AgregarArtista(Artista a) {
		if(this.BuscarArtista(a.getNombre()) != null) {
			System.out.println("El artista " + a.getNombre() + " ya se encuentra en lista.\n");
		}else {
			ListaArtista.add(a);
		}
	}
	public boolean EliminarArtista(String vnombre) {
	
		for(Artista a:ListaArtista) {
			if(a.getNombre().equals(vnombre)) {
				ListaArtista.remove(a);
				return true;
			}
		}
		return false;
	}
	
	public Artista BuscarArtista(String vnombre) {
		Artista a1=null;
		for(Artista a:ListaArtista) {
			if(a.getNombre().equals(vnombre)) {
				a1=a;
			}
		}
		return a1;
	}
	
	public void proyectar() {
		for (Artista a: ListaArtista) {
			System.out.println(a);
		}
	}

}
