using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;

using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Net; //Explorador
using System.Xml.Linq;
using System.Runtime.CompilerServices;

namespace Cliente
{
    public partial class Pokedex : Form
    {
        // Variables
        private WebClient cliente = new WebClient();
        private XNamespace espacioXML =
            XNamespace.Get("http://schemas.microsoft.com/2003/10/Serialization/");
        String galleta;
        int caso;

        public Pokedex()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            cliente.DownloadStringCompleted +=
              new DownloadStringCompletedEventHandler(cliente_DescargaCompleta);
        }
        private void cliente_DescargaCompleta(object sender, DownloadStringCompletedEventArgs e)
        {
            if (e.Error == null) 
            {
           
                try
                {
                    XDocument respuestaXml = XDocument.Parse(e.Result);
                    String res = respuestaXml.Element(espacioXML + "string").Value.ToString();
                    if (res != "null")
                    {
                        switch (caso)
                        {
                            case 0:
                                // Mensaje de bienvenida 
                                string[] words = res.Split(',');
                                string nombre = words[0];
                                galleta = res;

                                MessageBox.Show("Bienvenido entrenador! " + nombre);
                                pPokemon.Visible = true;
                                break;
                            case 1:
                                textBox3.Text = res;
                                break;
                            case 2:
                                textBox2.Text = res;
                                break;
                            default:
                                Console.WriteLine("Default case");
                                break;
                        }
                    }
                    else
                    {
                        MessageBox.Show("Usuario/Password no encontrados", "Error");
                    }
                }
                catch (System.Xml.XmlException)
                {
                    MessageBox.Show("Usuario/Password no encontrados", "Error");
                }
            }
        }
        private void btValidar_Click(object sender, EventArgs e)
        {
            // Ejecucion inmediata e (Hilo background)
            cliente.DownloadStringAsync(
                new Uri("http://localhost:62511/Usuario.svc/login?Usuario="+tbNombre.Text+"&Password="+tbPass.Text));
            caso = 0;
        }

        private void btType_Click(object sender, EventArgs e)
        {
            cliente.DownloadStringAsync(
                new Uri("http://localhost:62511/Usuario.svc/tipo?cookie=" + galleta+ "&pokemon=" + tbPokemon.Text));
            caso = 1;
        }

        private void btDebilidad_Click(object sender, EventArgs e)
        {
            cliente.DownloadStringAsync(
                new Uri("http://localhost:62511/Usuario.svc/debilidad?cookie=" + galleta + "&pokemon=" + tbPokemon.Text));
            caso = 2;
        }

        private void pPokemon_Paint(object sender, PaintEventArgs e)
        {

        }
    }
}
