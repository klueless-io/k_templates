import HelloWorld from '../components/HelloWorld.vue'

export default {
    title: 'Samples/HelloWorld',
    component: HelloWorld,
    argTypes: {}
}

// export const Example1 = () => ({
//   components: { HelloWorld },
//   template: '<HelloWorld label="Hello Vue3/Nuxt3 World" />'
// })

// export const Example2 = () => ({
//   components: { HelloWorld },
//   template: '<HelloWorld label="Hello World" />'
// })



const Template = (args) => ({
    // Components used in your story `template` are defined in the `components` object
    components: { HelloWorld },
    // The story's `args` need to be mapped into the template through the `setup()` method
    setup() {
        return {
            args
        }
    },
    // And then the `args` are bound to your component with `v-bind="args"`
    template: '<HelloWorld v-bind="args" />'
})

export const First = Template.bind({})

First.args = {
    label: "Hello World"
}

export const Second = Template.bind({})

Second.args = {
    label: "Hello from the world of VUE3/NUXT3"
}

export const AnotherVariation = Template.bind({})

AnotherVariation.args = {
    label: "Too Varied"
}
AnotherVariation.storyName = 'Variation with Custom Name'



