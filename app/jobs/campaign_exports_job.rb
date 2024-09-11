class CampaignExportsJob < ApplicationJob
  queue_as :default

  def perform(export)
    export.build_files
  end
end
