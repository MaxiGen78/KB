using KozhaBeauty.Models;
using static KozhaBeauty.DataAccess.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace KozhaBeauty.DataAccess
{
    public class Data
    {
        private readonly SqlDataAccess _sql = new SqlDataAccess();
        private readonly string _connectionName = "KBData";
        private object P { get; set; } = new { };



        //Get List of All Products
        public List<ProductModel> GetListOfAllProducts()
        {

            var output = _sql.LoadData<ProductModel, dynamic>("dbo.spGetAllProducts", P, _connectionName);

            foreach (var item in output)
            {
                item.ImageList = ConvertStringToList(item.ImageString);
                item.ProductCategoryList = ConvertStringToList(item.ProductCategoryString);
            }

            return output;
        }

        //Get List of Categories
        public List<CategoryModel> GetListOfCategories()
        {
            var output = _sql.LoadData<CategoryModel, dynamic>("dbo.spGetCategories", P, _connectionName);
            return output;
        }


        //Save Data to the database
        public void AmendData<T>(string sp, T data)
        {
            _sql.SaveData(sp, data, _connectionName);
        }

    }
}