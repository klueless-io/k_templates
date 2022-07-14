# frozen_string_literal: true

ActiveAdmin.setup do |config|
  config.comments = false       # To completely disable comments

  config.namespace :admin do |admin|
    admin.build_menu :utility_navigation do |menu|
      menu.add label: "Architecture", url: "/architecture", html_options: { target: "{{dashify settings.Application}}" }
      admin.add_current_user_to_menu  menu
      admin.add_logout_button_to_menu menu
    end

    admin.build_menu do |menu|
      menu.add label: "Users", priority: 1 do |sites|
        sites.add label: "Users", url: "/admin/users", priority: 1
        sites.add label: "Admin Users", url: "/admin/admin_users", priority: 2
      end
      menu.add label: "All Models", priority: 2 do |sites|{{#menus}}
      sites.add label: "{{titleize (humanize name)}}", url: "/admin/{{snake name_plural}}", priority: {{@index}}

      {{/menus}}
      {{^menus}}
{{#entities}}{{#if (eq name "user")}}{{else if (eq name "admin_user" )}}{{else}}
        sites.add label: "{{titleize (humanize name)}}", url: "/admin/{{snake name_plural}}", priority: {{@index}}{{/if}}{{/entities}}
      {{/menus}}
      end
    end
  end
end
