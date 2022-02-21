using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using System.Web;

namespace PokeDB
{
    
    [ServiceContract]
    public interface IUsuario
    {
        [OperationContract]
        [WebGet(UriTemplate = "/login?Usuario={x}&Password={y}")]
        string login(string x, string y);


        [OperationContract]
        [WebGet(UriTemplate = "/tipo?cookie={x}&pokemon={y}")]
        string tipoPokemon (string x, string y);

        [OperationContract]
        [WebGet(UriTemplate = "/debilidad?cookie={x}&pokemon={y}")]
        string debilidadPokemon(string x, string y);
    }
}
