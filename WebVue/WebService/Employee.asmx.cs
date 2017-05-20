using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace WebVue.WebService
{
    /// <summary>
    /// Summary description for Employee
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class Employee : System.Web.Services.WebService
    {
        EmployeeDto employeeDto = new EmployeeDto();

        private JsonSerializerSettings ConvertToCamelCase()
        {
            return new JsonSerializerSettings
            {
                ContractResolver = new CamelCasePropertyNamesContractResolver()
            };
        }

        [WebMethod]
        public void Get()
        {
            HttpContext.Current.Response.ContentType = "application/json;charset=utf-8";
            var json = JsonConvert.SerializeObject(employeeDto.Get(), ConvertToCamelCase());
            HttpContext.Current.Response.Write(json);
        }

        [WebMethod]
        public void Post(int id,string name)
        {
            var maxId = employeeDto.Get().Max(x => x.Id) + 1;
            var employee = new EmployeeDto { Id = maxId, Name = name };
            EmployeeDto.Employees.Add(employee);
            HttpContext.Current.Response.Write(maxId);
        }

        [WebMethod]
        public void Delete(int id)
        {
            var employee = EmployeeDto.Employees.FirstOrDefault(x => x.Id == id);
            EmployeeDto.Employees.Remove(employee);
        }

        
    }

    public class EmployeeDto
    {
        public static IList<EmployeeDto> Employees { get; set; }

        public IList<EmployeeDto> Get()
        {
            Employees = Employees ?? new List<EmployeeDto>
            {
                new EmployeeDto {Id=1,Name="anson" },
                new EmployeeDto {Id=2,Name="jacky" }
            };
            return Employees;
        }

        public int Id { get; set; }
        public string Name { get; set; }
    }
}
