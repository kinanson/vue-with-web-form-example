<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebVue._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        li {
            list-style: none;
        }
    </style>
    <script src="app/services/employeeService.js"></script>
    <script src="app/components/EmployeeComponent.js"></script>
    <script src="app/components/RemoveButtonComponent.js"></script>
    <div id="app">
        <input type="text" name="name" v-model="name" />
        <input type="button" value="add" @click="add" /> 
        <ul>
            <li v-for="item in employees" :key="item.id">
                <%--<employee :item="item" @remove="remove"></employee>--%>
               <employee :item="item"></employee> <%--這邊的remove去掉了--%>
            </li>
        </ul>
    </div>

    <script>
        let bus = new Vue() //新增一個Vue的實體，來達成eventbus的溝通

        let app = new Vue({
            el: '#app',
            data: {
                name: 'hello world',
                employees: []
            },
            methods: {
                get: function () {
                    employeeService.get().then(employees=>this.employees = employees)
                },
                add: function () {
                    let employee = {
                        id: 0,
                        name: this.name
                    }
                    employeeService.add(employee).then(id=>employee.id = id)
                    this.employees.push(employee)
                    this.name = null
                }
                //remove: function (item) { 這邊不需要了，改用bus來接收
                //    employeeService.remove(item.id).then(x=> {
                //        this.employees = this.employees.filter(employee=>employee !== item)
                //    })
                //}
            },
            created: function () {
                this.get(),
                bus.$on('removeButtonRemove', function (item) { //bus接受最底下的removeButton發送的通知
                    employeeService.remove(item.id).then(x=> {
                        //下面要特別注意一下，這邊不能用this，因為這邊的this是指向eventBus這個Vue的實體，所以我們必須明確呼叫app這個實體
                        app.employees = app.employees.filter(employee=>employee !== item) 
                    })
                })
            }
        })
    </script>
</asp:Content>