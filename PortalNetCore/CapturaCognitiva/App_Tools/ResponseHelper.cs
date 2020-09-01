
using System.Collections.Generic;


namespace CapturaCognitiva.App_Tools
{
    public abstract class ResponseHelperBase
    {      
        public int Id { get; set; }
        public bool Response { get; set; }
        public string Message { get; set; }
        public string Errors { get; set; }

        public void SetValidations(Dictionary<string, string> vals)
        {
            if (vals != null && vals.Count > 0)
            {
                PrepareResponse(-1, false, "La validación no ha sido superada");
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="r"></param>
        /// <param name="m"></param>
        /// <param name="p"></param>     

        protected void PrepareResponse(int id, bool r, string m = "", string others = "", string v = "")
        {
            Response = r;
            Id = id;

            if (r)
            {
                Message = m;
            }
            else
            {
                Message = (m == "" ? "Ocurrió un error inesperado" : m);
            }
        }

        protected ResponseHelperBase()
        {
            PrepareResponse(0, false);
        }
    }

    public class ResponseHelper : ResponseHelperBase
    {
        public ResponseHelper SetResponse(int id, bool r, string m = "", string others = "", string v = "")
        {
            PrepareResponse(id, r, m, others, v);
            return this;
        }
    }

    public class ResponseHelper<T> : ResponseHelperBase where T : class
    {
        public ResponseHelper<T> SetResponse(bool r, string m = "")
        {
            PrepareResponse(0, r, m);
            return this;
        }
    }
}