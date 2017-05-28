Vue.component('employee', function (resolve) {
    $.get('app/components/EmployeeComponent.html', function (template) {
        resolve({
            props: ['item'],
            template: template
            //methods: { 這邊的通知不用了
            //    remove: function (item) {
            //        this.$emit('remove', item)
            //    }
            //}
        })
    })
})