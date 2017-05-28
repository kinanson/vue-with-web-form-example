Vue.component('removeButton', {
    props: ['item'],
    template: '<input type="button" :value="`remove編號${item.id}`" @click="remove(item)" />',
    methods: {
        remove: function (item) {
            //this.$emit('remove', item) 不需要再透過原本的方式向上層溝通

            //下面透過我們實例的bus來傳遞事件了，這邊要特別注意一下一定要是以元件加動作的方式來命名
            //以免用到不同的component都有remove的時候，會造成無法預期的狀況
            //因為我們完全無法預期每個頁面會重覆使用到什麼樣的component，如果不明確命名一定會造成撞名的狀況
            //雖然可以透過devtools來追查出原因，但是可以預期的狀況我們不如盡早做好預防
            bus.$emit('removeButtonRemove', item) 
        }
    }
})