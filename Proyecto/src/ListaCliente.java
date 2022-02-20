import java.util.ArrayList;

/**
 * 
 */

/**
 * @author DELL
 *
 */
public class ListaCliente {
	
	private ArrayList<Cliente> ListaC;
	
	public ListaCliente() {
		ListaC = new ArrayList<Cliente>();
	}

	public ArrayList<Cliente> getListaC() {
		return ListaC;
	}

	public void setListaC(ArrayList<Cliente> listaC) {
		ListaC = listaC;
	}
	
	public void agregarCliente(Cliente c) {
		ListaC.add(c);
	}
	
	public boolean eliminarCliente(String vId) {
		for(Cliente c:ListaC) {
			if(c.getId().equals(vId)) {
				ListaC.remove(c);
				return true;
			}
		}
		return false;
	}
	
	public Cliente buscarCliente(String vId) {
		for(Cliente c:ListaC) {
			if(c.getId().equals(vId)) {
				return c;
			}
		}
		return null;
	}
	
	public void proyectar() {
		for (Cliente c: ListaC) {
			System.out.println(c);
		}
	}

}
