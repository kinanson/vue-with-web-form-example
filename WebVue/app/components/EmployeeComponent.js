Vue.component('employee', function (resolve) {
    $.get('app/components/EmployeeComponent.html', function (template) {
        resolve({
            props: ['item'],
            template: template
        })
    })
})