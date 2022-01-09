import Counter from '../components/Counter.vue'

export default {
    title: 'Samples/Counter',
    component: Counter
}

const Template = (args) => ({
    // Components used in your story `template` are defined in the `components` object
    components: { Counter },
    // The story's `args` need to be mapped into the template through the `setup()` method
    // setup() {
    //     return {
    //         args
    //     }
    // },
    // And then the `args` are bound to your component with `v-bind="args"`
    template: '<Counter />'
})

export const MyCounter = Template.bind({})

