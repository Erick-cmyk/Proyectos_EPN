import java.util.*;
public class ListaEvento {
	private ArrayList<Evento> listE;
	
	public ListaEvento() {
		listE=new ArrayList<Evento>();
	}

	public ArrayList<Evento> getListE() {
		return listE;
	}

	public void setListE(ArrayList<Evento> vlistE) {
		this.listE = vlistE;
	}
	
	
	public void agregarEvento(Evento e) {
		listE.add(e);
	}
	public Evento buscarEvento(String vidEvento) {
		for(Evento e: listE) {
			if(vidEvento.equals(e.getIdEvento())) {
				return e;
			}
			
		}
		return null;
	}
	
	public void eliminarEvento(String vidEvento) {
		for(Evento e:listE) {
			if(vidEvento.equals(e.getIdEvento())) {
				listE.remove(e);
			}
		}
	}
	
	

}
