KManager.action :domain_model do
  action do

    DrawioDsl::Drawio
      .init(k_builder, on_exist: :write, on_action: :execute)
      .diagram(theme: :style_04)
      .page('Domain Modal', margin_left: 0, margin_top: 0, rounded: 0, background: '#fafafa') do
        grid_layout(wrap_at: 6, grid_w: 220, grid_h: 180)

        w = 200

        group(title: '{{camel name}}', theme: :style_01) 

        group(title: 'Configuration', theme: :style_01) 

        klass(:a1, w: w) do
          format
            .header('Configuration', namespace: :config, description: 'Configuration container for {{camel name}}')
            .field(:collections       , type: :Collections)
            .field(:some_attribute    , type: :String)
        end

        # A Collection would be better named as a UIKit or DesignSystem
        klass(:a2, w: w) do
          format
            .header('Collection', namespace: :config, description: 'Configuration for ...')
            .field(:name, type: :String)
            .field(:description, type: :String)
        end

        solid(source: :a1, target: :a2, exit_point: :e, entry_point: :w, waypoint: :orthogonal_curved)

        group(title: 'Schema', theme: :style_01) 

        interface(description: 'Create an instance...', theme: :style_02) do
          format
            .header('Factory', interface_type: 'MixIn')
            .method(:data)
            .method(:data_instance)
        end
      end
      .cd(:docs)
      .save('domain-model.drawio')
      .save_json('domain-model')
      .export_svg('domain-model', page: 1)
  end
end

KManager.opts.app_name                    = '{{snake name}}'
KManager.opts.sleep                       = 2
KManager.opts.reboot_on_kill              = 0
KManager.opts.reboot_sleep                = 4
KManager.opts.exception_style             = :long
KManager.opts.show.time_taken             = true
KManager.opts.show.finished               = true
KManager.opts.show.finished_message       = 'FINISHED :)'
