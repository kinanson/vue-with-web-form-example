const employeeService = (function () {
    const service = {
        get:get,
        add:add,
        remove:remove
    }
    
    function get() {
        return $.get(`WebService/Employee.asmx/Get`)
    }

    function add(postData) {
        return $.post(`WebService/Employee.asmx/Post`, postData)
    }

    function remove(id){
        return $.get(`WebService/Employee.asmx/Delete?id=${id}`)
    }

    return service
})();