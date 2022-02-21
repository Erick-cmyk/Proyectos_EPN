using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.Web;

namespace PokeDB
{
    
    public class Entrenador : IEntrenador
    {
        [DataMember]
        public string Password { get; set; }
        [DataMember]
        public string Nombre { get; set; }



        
        public List<Entrenador> RetornarLista()
        {
            int count = 0;
            string[] lines = System.IO.File.ReadAllLines(@"C:\Users\erick\source\repos\prueba2\Test\Test\Datos.txt");
            foreach (string line in lines)
            {
                if (line == "USUARIOS")
                {
                    count = 1;
                    continue;
                }
                if (line == "POKEMON")
                {
                    count = 2;
                }
                if (line == "DEBILIDADES")
                {
                    count = 3;
                }
                if (count == 1)
                {
                    string[] words = line.Split(',');
                    string nombre = words[0];
                    string pass = words[1];
                    Cookie.ListaUsuarios.Add(new Entrenador()
                    {
                        Nombre = nombre,
                        Password = pass
                    });
                }
            }
            return Cookie.ListaUsuarios;
        }


        public string login(string Nombre, string Password)
        {
            Entrenador entrenador = new Entrenador();
            var model = entrenador.RetornarLista().Where(z => z.Nombre == Nombre && z.Password == Password).SingleOrDefault();

            if (model != null)
            {
                string cookie = Nombre+","+DateTime.Now.Date.Date.ToString()+","+DateTime.Now.Hour.ToString();
                Cookie.ListaCookies.Add(cookie);
                return cookie;
            }
            else
            {
                return null;
            }
        }


        public Boolean VerificarCookie(string cookie)
        {
            foreach (string Cookie in Cookie.ListaCookies)
            {
                if (Cookie == cookie)
                {
                    return true;
                }
            }
            return false;
        }




        public string tipoPokemon(string cookie, string Pokemon)
        {
            if (cookie == null)
            {
                return "NO VALIDADO";
            }
            else
            {
                if (VerificarCookie(cookie) == true)
                {
                    Dictionary<string, string> tipos = new Dictionary<string, string>();
                    int count = 0;
                    string[] lines = System.IO.File.ReadAllLines(@"C:\Users\erick\source\repos\prueba2\Test\Test\Datos.txt");
                    foreach (string line in lines)
                    {
                        if (line == "USUARIOS")
                        {
                            count = 1;
                        }
                        if (line == "POKEMON")
                        {
                            count = 2;
                            continue;
                        }
                        if (line == "DEBILIDADES")
                        {
                            count = 3;
                        }
                        if (count == 2)
                        {
                            string[] words = line.Split(',');
                            string pokemon = words[0];
                            string tipo = words[1];
                            tipos.Add(pokemon, tipo);
                        }
                    }

                    if (tipos[Pokemon] != null)
                    {
                        return tipos[Pokemon];
                    }
                    else
                    {
                        return "Pokemon no encontrado";
                    }
                }
                else
                {
                    return "NO VALIDADO";
                }
                
            }

        }

        public string debilidadPokemon(string cookie, string Pokemon)
        {
            if (cookie == null)
            {
                return "NO VALIDADO";
            }
            else
            {
                if (VerificarCookie(cookie) == true)
                {
                    Dictionary<string, string> tipos = new Dictionary<string, string>();
                    Dictionary<string, string> debilidades = new Dictionary<string, string>();
                    int count = 0;
                    string[] lines = System.IO.File.ReadAllLines(@"C:\Users\erick\source\repos\prueba2\Test\Test\Datos.txt");
                    foreach (string line in lines)
                    {
                        if (line == "USUARIOS")
                        {
                            count = 1;
                        }
                        if (line == "POKEMON")
                        {
                            count = 2;
                            continue;
                        }
                        if (line == "DEBILIDADES")
                        {
                            count = 3;
                            continue;
                        }
                        if (count == 2)
                        {
                            string[] words = line.Split(',');
                            string pokemon = words[0];
                            string tipo = words[1];
                            tipos.Add(pokemon, tipo);
                        }
                        if (count == 3)
                        {
                            string[] words = line.Split(',');
                            string tipo = words[0];
                            string debilidad = words[1];
                            debilidades.Add(tipo, debilidad);
                        }
                    }

                    if (tipos[Pokemon] != null)
                    {
                        string tipo = tipos[Pokemon];
                        if (debilidades[tipo] != null)
                        {
                            return debilidades[tipo];
                        }
                        else
                        {
                            return "Pokemon no encontrado";
                        }
                    }
                    else
                    {
                        return "Pokemon no encontrado";
                    }
                }
                else
                {
                    return "NO VALIDADO";
                }

            }

        }

    }
}
