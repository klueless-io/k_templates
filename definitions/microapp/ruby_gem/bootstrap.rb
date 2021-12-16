KDoc.bootstrap :ruby_gem do
  settings do
    name                    '{{name}}'
    description             '{{title name}} {{problem}}'
    definition_subfolder    'ruby-gem'
    main_story              "As a {{title actor}}, I want to , so I can "
  end
  
  def on_action
    settings = odata.settings

    log.structure settings
  end
end
