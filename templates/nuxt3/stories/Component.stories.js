import {{camel dom.component_name}} from '../components/{{camel dom.component_name}}.vue'

export default {
    title: '{{dom.group}}/{{camel dom.component_name}}',
    component: {{camel dom.component_name}},
    argTypes: {}
}

const Template = (args) => ({
    components: { {{camel dom.component_name}} },
    setup() {
        return {
            args
        }
    },
    template: '<{{camel dom.component_name}} v-bind="args" />'
})

export const First = Template.bind({})

First.args = {
    label: "Hello World"
}

export const Second = Template.bind({})

Second.args = {
    label: "Hello from the world of VUE3/NUXT3"
}
