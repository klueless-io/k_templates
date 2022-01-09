// More Info
// https://www.youtube.com/watch?v=FUKpWgRyPlU

import Menu from '../components/Menu.vue'

export default {
    title: 'Samples/Menu',
    component: Menu
}

const Template = (args) => ({
    components: { Menu },
    setup() {
        return {
            args
        }
    },
    // And then the `args` are bound to your component with `v-bind="args"`
    template: '<Menu v-bind="args"  />'
})

export const SampleMenu = Template.bind({})

