K.cmd
  .starter(:csharp_solution,
    name: '{{name}}',
    problem: 'What is the problem',
    solution: 'What is the solution',
    actor: 'Who')
  .starter(:csharp_library,
    name: '{{name}}_library',
  )
  .starter(:csharp_console,
    name: '{{name}}',
  )
  .starter(:csharp_test,
    name: '{{name}}_tests',
  )
  
puts 'done'