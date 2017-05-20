<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebVue._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        li {
            list-style: none;
        }
    </style>
    <script src="app/services/employeeService.js"></script>
    <script src="app/components/EmployeeComponent.js"></script> <%--這裡加入component的file--%>
    <div id="app">
        <input type="text" name="name" v-model="name" />
        <input type="button" value="add" @click="add" /> <%--新增的按鈕--%>
        <ul>
            <li v-for="item in employees" :key="item.id">
                <input type="button" :value="`remove編號${item.id}`" @click="remove(item)" />    
                <employee :item="item"></employee>    <%--這裡改成使用component的方式--%>  
            </li>
        </ul>
    </div>

    <script>

        let app = new Vue({
            el: '#app',
            data: {
                name: 'hello world',
                employees: []
            },
            methods: {
                get: function () {
                    employeeService.get().then(employees=>this.employees = employees) //取得
                },
                add: function () { //對應新增的方法
                    let employee = {
                        id: 0,
                        name: this.name
                    }
                    employeeService.add(employee).then(id=>employee.id = id) //呼叫ajax並使用promise等待新增後的流水號
                    this.employees.push(employee)
                    this.name = null
                },
                remove: function (item) {
                    employeeService.remove(item.id).then(x=> {
                        this.employees = this.employees.filter(employee=>employee !== item)
                    })
                }
            },
            created: function () { //這個代表是vue的生命週期，有興趣可以去參考一下vue的lifecyle
                this.get() 
            }
        })
    </script>
</asp:Content>