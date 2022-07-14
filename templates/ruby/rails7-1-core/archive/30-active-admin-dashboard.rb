# frozen_string_literal: true

ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  action_item :update_stats do
    link_to "Update Stats", action: "update_states"
  end

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    panel "Table Statistics" do
      div class: "blank_slate_container" do
        span class: "blank_slate" do
          table_for KlueStatistics.where(stat_type: "table_count").order("table_group") do
            column("Table") { |stat| stat.table_name.titleize }
            column("Total")   { |stat| status_tag(stat.total) }
          end
        rescue StandardError
          span "Click Update Stats"
        end
      end
      # div class: "blank_slate_container" do
      #   span class: "blank_slate" do
      #     table_for KlueStatistics.where(stat_type: "table_child_count").order(:table_group) do
      #       column("Table") { |stat| stat.table_name.titleize }
      #       column("Group By") { |stat| stat.group_by.titleize }
      #       column("Group For") { |stat| stat.group_for }
      #       column("Total")   { |stat| status_tag(stat.total) }
      #     end
      #   end
      # end
    end

    # panel "Recent Video's" do
    #   ul style: 'list-style-type: none" do
    #     VideoDeck.limit(10).order(updated_at: :desc).map do |video_deck|
    #       li link_to(video_deck.title, admin_video_deck_path(video_deck))
    #     end
    #   end
    # end

    div class: "custom-class" do
      # render partial: "active_admin/dashboard_graph"
    end
  end

  page_action :update_states do
    KlueStatistics::SqlMigration.create

    redirect_to admin_dashboard_path
  end
end
