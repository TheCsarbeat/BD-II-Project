using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace indioSupermercado
{
    public static class usefull
    {
        public static string strCon = ConfigurationManager.ConnectionStrings["connectionSebas"].ConnectionString;
        public static bool validateFloat(string num)
        {
            try
            {
                float asd = (float)Convert.ToDouble(num);
            }
            catch
            {
                return false;
            }
            return true;
        }

        public static bool validateInt(string num)
        {
            try
            {
                int asd = (int)Convert.ToInt64(num);
            }
            catch
            {
                return false;
            }
            return true;
        }
    }
        
}