import java.util.ArrayList;


public class ListaCronograma {
	
	// Atributos
	ArrayList<Cronograma>ListaCronograma = new ArrayList<Cronograma>();
	
	
	// Constructor
	public ListaCronograma(){
		ListaCronograma= new ArrayList<Cronograma>();
	}
	// Propiedades
	public ArrayList<Cronograma> getListaCronograma() {
		return ListaCronograma;
	}
	
	// Metodos Objeto
	public void AgregarCronograma(Cronograma c) {
		ListaCronograma.add(c);
	}
	
	
	public boolean EliminarCronograma(String idC) {
		for(Cronograma c: ListaCronograma) {
			if(c.getiDC().equals(idC)) {
				ListaCronograma.remove(c);
				return true;
			}
		}
		return false;
	}
	
	public Cronograma BuscarCronograma(String idC) {
		Cronograma c1 = null;
		for(Cronograma c:ListaCronograma) {
			if(c.getiDC().equals(idC)) {
				c1 = c;
			}
		}
		return c1;
	}
	
	public void proyectarCronogramas() {
		System.out.printf("%-14s%-1s%s\n", "Fecha", "Inicio", "Final");
		for(Cronograma c: ListaCronograma) {
			System.out.println(c);
		}
	}
	
	
}
