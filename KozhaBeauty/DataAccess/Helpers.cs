using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace KozhaBeauty.DataAccess
{
    public static class Helpers
    {
        public static List<string> ConvertStringToList(string sourceString)
        {
            List<string> resultList = new List<string>();
            if (!string.IsNullOrWhiteSpace(sourceString))
            {
                var list = sourceString.Split(';').ToList();
                resultList = new List<string>(list);
            }
            return resultList;
        }
    }
}